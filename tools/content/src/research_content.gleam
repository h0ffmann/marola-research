//// research_content: write `<research>/site/src/<package>/content.gleam` from the research's own
//// files, so a site never repeats a fact by hand. Every research's site uses it. It reads the
//// paper's front matter and section titles, the hard rules of the research's README.md, its
//// notes, its journal, its reference log and its easy pt-BR abstract.
////
////     gleam run -- <research> <package>     # from tools/content; `just site <research>` does it
////
//// It is its own package, because a site cannot compile before its content exists.
//// The idea is h0ffmann/closed-source's `tools/fabric content` (at c52ff71); written here.

import gleam/int
import gleam/io
import gleam/list
import gleam/result
import gleam/string

@external(javascript, "./research_content_ffi.mjs", "read")
fn read(path: String) -> String

@external(javascript, "./research_content_ffi.mjs", "write")
fn write(path: String, text: String) -> Nil

@external(javascript, "./research_content_ffi.mjs", "markdown_files")
fn markdown_files(dir: String) -> String

@external(javascript, "./research_content_ffi.mjs", "revision")
fn revision() -> String

/// The arguments of the command, one on each line.
@external(javascript, "./research_content_ffi.mjs", "arguments_")
fn arguments() -> String

/// The lines between the first two `---` lines, or [] when the text has no front matter.
pub fn front_lines(text: String) -> List(String) {
  case string.split(text, "\n") {
    ["---", ..rest] -> list.take_while(rest, fn(l) { l != "---" })
    _ -> []
  }
}

fn unquote(s: String) -> String {
  let s = string.trim(s)
  case string.starts_with(s, "\"") && string.ends_with(s, "\"") {
    True -> s |> string.drop_start(1) |> string.drop_end(1)
    False -> s
  }
}

/// One value of a front matter: `key: value` on one line, or a block (`key: |`) whose lines are
/// indented. "" when the key is not there.
pub fn field(lines: List(String), key: String) -> String {
  case lines {
    [] -> ""
    [line, ..rest] ->
      case string.split_once(line, key <> ":") {
        Ok(#("", value)) ->
          case string.trim(value) {
            "|" ->
              list.take_while(rest, fn(l) {
                string.starts_with(l, "  ") || l == ""
              })
              |> list.map(string.trim)
              |> string.join(" ")
              |> string.trim
            v -> unquote(v)
          }
        _ -> field(rest, key)
      }
  }
}

/// Markdown marks out: bold, code marks, and a link becomes its words.
pub fn plain(s: String) -> String {
  s
  |> string.replace("**", "")
  |> string.replace("`", "")
  |> unlink
  |> string.trim
}

fn unlink(s: String) -> String {
  case string.split_once(s, "](") {
    Error(_) -> s
    Ok(#(before, after)) ->
      case string.split_once(after, ")") {
        Error(_) -> s
        Ok(#(_, rest)) ->
          case list.reverse(string.split(before, "[")) {
            [words, ..head] ->
              string.join(list.reverse(head), "[") <> words <> unlink(rest)
            [] -> s
          }
      }
  }
}

/// The lines of the section under `heading`, to the next heading of the same depth.
pub fn section(text: String, heading: String) -> List(String) {
  string.split(text, "\n")
  |> list.drop_while(fn(l) { l != heading })
  |> list.drop(1)
  |> list.take_while(fn(l) { !string.starts_with(l, "## ") })
}

/// The items of a numbered list, each joined from its wrapped lines, as plain text.
pub fn numbered(lines: List(String)) -> List(String) {
  let is_item = fn(l: String) {
    case string.split_once(l, ". ") {
      Ok(#(n, _)) -> result.is_ok(int.parse(n))
      Error(_) -> False
    }
  }
  list.fold(lines, [], fn(acc: List(String), l) {
    case is_item(l), acc {
      True, _ -> [result.unwrap(string.split_once(l, ". "), #("", l)).1, ..acc]
      False, [last, ..rest] ->
        case string.starts_with(l, "   ") {
          True -> [last <> " " <> string.trim(l), ..rest]
          False -> acc
        }
      False, [] -> acc
    }
  })
  |> list.reverse
  |> list.map(plain)
}

/// The paper's numbered sections: "## 3. The proposal" gives "The proposal".
pub fn sections(paper: String) -> List(String) {
  string.split(paper, "\n")
  |> list.filter_map(fn(l) {
    case l {
      "## " <> rest ->
        case string.split_once(rest, ". ") {
          Ok(#(n, title)) ->
            case int.parse(n) {
              Ok(_) -> Ok(title)
              Error(_) -> Error(Nil)
            }
          Error(_) -> Error(Nil)
        }
      _ -> Error(Nil)
    }
  })
}

/// What is not known: the bold lead of each bullet of that section of the paper.
pub fn unknowns(paper: String) -> List(String) {
  string.split(paper, "\n")
  |> list.drop_while(fn(l) { !string.ends_with(l, ". What is not known") })
  |> list.drop(1)
  |> list.take_while(fn(l) { !string.starts_with(l, "## ") })
  |> list.filter_map(fn(l) {
    case l {
      "- **" <> rest ->
        case string.split_once(rest, "**") {
          Ok(#(lead, _)) ->
            Ok(case string.ends_with(string.trim(lead), ".") {
              True -> string.drop_end(string.trim(lead), 1)
              False -> string.trim(lead)
            })
          Error(_) -> Error(Nil)
        }
      _ -> Error(Nil)
    }
  })
}

/// How the references were read: #(all, full text, abstract, page or record). From the rows of
/// the reference log's table, whose third cell is "Read".
pub fn reading(log: String) -> #(Int, Int, Int, Int) {
  let rows =
    string.split(log, "\n")
    |> list.filter(fn(l) { string.starts_with(l, "| `") })
    |> list.filter_map(fn(l) {
      case string.split(l, "|") {
        [_, _, _, read, ..] -> Ok(string.lowercase(read))
        _ -> Error(Nil)
      }
    })
  let full = list.count(rows, string.contains(_, "full text"))
  let abstract =
    list.count(rows, fn(r) {
      string.contains(r, "abstract") && !string.contains(r, "full text")
    })
  let all = list.length(rows)
  #(all, full, abstract, all - full - abstract)
}

/// The logos of `paper/logos.tsv`: #(name, the SVG's address at a pinned commit, where it links).
pub fn logos(tsv: String) -> List(#(String, String, String)) {
  string.split(tsv, "\n")
  |> list.filter_map(fn(l) {
    case string.starts_with(l, "#"), string.split(l, "\t") {
      False, [name, url, _sha, href] -> Ok(#(name, url, href))
      _, _ -> Error(Nil)
    }
  })
}

fn between(text: String, start: String, end: String) -> String {
  case string.split_once(text, start) {
    Ok(#(_, rest)) ->
      case string.split_once(rest, end) {
        Ok(#(block, _)) -> string.trim(block)
        Error(_) -> ""
      }
    Error(_) -> ""
  }
}

/// A Gleam string literal.
pub fn lit(s: String) -> String {
  "\""
  <> s
  |> string.replace("\\", "\\\\")
  |> string.replace("\"", "\\\"")
  |> string.replace("\n", "\\n")
  <> "\""
}

fn lits(items: List(String)) -> String {
  "[\n" <> string.concat(list.map(items, fn(i) { "  " <> i <> ",\n" })) <> "]"
}

fn files(dir: String) -> List(String) {
  markdown_files(dir)
  |> string.split("\n")
  |> list.filter(fn(f) { f != "" && f != "index.md" && f != "README.md" })
}

fn first_heading(text: String) -> String {
  string.split(text, "\n")
  |> list.find_map(fn(l) {
    case l {
      "# " <> title -> Ok(title)
      _ -> Error(Nil)
    }
  })
  |> result.unwrap("")
}

pub fn main() -> Nil {
  case string.split(arguments(), "\n") {
    [research, package] -> generate(research, package)
    _ ->
      io.println_error(
        "research_content: usage: gleam run -- <research> <package>",
      )
  }
}

fn generate(research: String, package: String) -> Nil {
  // From tools/content, the repository's root is two levels up.
  let dir = "../../" <> research <> "/"
  let out = dir <> "site/src/" <> package <> "/content.gleam"
  let paper = read(dir <> "paper/paper.md")
  let fm = front_lines(paper)
  let rules = numbered(section(read(dir <> "README.md"), "## Hard rules"))
  let notes =
    files(dir <> "notes")
    |> list.map(fn(f) {
      let n = front_lines(read(dir <> "notes/" <> f))
      "Note(file: "
      <> lit(string.drop_end(f, 3))
      <> ", title: "
      <> lit(field(n, "title"))
      <> ", kind: "
      <> lit(field(n, "type"))
      <> ", status: "
      <> lit(field(n, "status"))
      <> ")"
    })
    |> list.reverse
  let journal =
    files(dir <> "journal")
    |> list.map(fn(f) {
      let text = read(dir <> "journal/" <> f)
      let j = front_lines(text)
      "Entry(file: "
      <> lit(string.drop_end(f, 3))
      <> ", date: "
      <> lit(field(j, "date"))
      <> ", title: "
      <> lit(first_heading(text))
      <> ", status: "
      <> lit(field(j, "status"))
      <> ")"
    })
    |> list.reverse
  let #(all, full, abstract, page) = reading(read(dir <> "paper/REFERENCES.md"))
  let easy =
    between(
      read(dir <> "paper/abstract.easy.pt-BR.md"),
      "<!-- easy-abstract:start -->",
      "<!-- easy-abstract:end -->",
    )
  // The DOIs of a research that was released: the rows of its doi.tsv.
  let ids =
    string.split(read(dir <> "doi.tsv"), "\n")
    |> list.filter_map(fn(l) {
      case string.starts_with(l, "#"), string.split(l, "\t") {
        False, [key, value] -> Ok(#(key, value))
        _, _ -> Error(Nil)
      }
    })
  let id = fn(key: String) { result.unwrap(list.key_find(ids, key), "") }
  let logo_rows =
    logos(read(dir <> "paper/logos.tsv"))
    |> list.map(fn(l) {
      "Logo(name: "
      <> lit(l.0)
      <> ", src: "
      <> lit(l.1)
      <> ", href: "
      <> lit(l.2)
      <> ")"
    })
  let text =
    "//// Generated by tools/content (`just site <research>`) from the research's files; do not edit.

pub type Note {
  Note(file: String, title: String, kind: String, status: String)
}

pub type Entry {
  Entry(file: String, date: String, title: String, status: String)
}

/// A logo that the page shows, loaded from its owner's repository at a pinned commit.
pub type Logo {
  Logo(name: String, src: String, href: String)
}

pub const repo = \"https://github.com/marola-dev/marola-research\"

pub const slug = "
    <> lit(research)
    <> "

pub const revision = "
    <> lit(revision())
    <> "

/// The DOI of the work, which always opens its latest version (doi.tsv). Empty before the first
/// release.
pub const doi = "
    <> lit(id("doi"))
    <> "

/// The released version and its own DOI.
pub const released = "
    <> lit(id("version"))
    <> "

pub const version_doi = "
    <> lit(id("version_doi"))
    <> "

pub const title = "
    <> lit(field(fm, "title"))
    <> "

pub const subtitle = "
    <> lit(field(fm, "subtitle"))
    <> "

pub const author = "
    <> lit(field(fm, "author"))
    <> "

pub const status = "
    <> lit(field(fm, "status"))
    <> "

pub const version = "
    <> lit(field(fm, "version"))
    <> "

pub const date = "
    <> lit(field(fm, "date"))
    <> "

/// The bench, in the owner's words (the paper's front matter).
pub const bench = "
    <> lit(field(fm, "bench"))
    <> "

pub const abstract = "
    <> lit(field(fm, "abstract"))
    <> "

/// The abstract step by step in easy Brazilian Portuguese: paragraphs that start with a bold
/// lead. Empty when the research has none.
pub const abstract_easy_pt_br = "
    <> lit(easy)
    <> "

/// The logos of the paper's first page (paper/logos.tsv). Trademarks of their projects.
pub const logos = "
    <> lits(logo_rows)
    <> "

/// The owner's hard rules, from the research's README.md.
pub const rules = "
    <> lits(list.map(rules, lit))
    <> "

pub const sections = "
    <> lits(list.map(sections(paper), lit))
    <> "

/// The leads of the paper's section \"What is not known\".
pub const unknowns = "
    <> lits(list.map(unknowns(paper), lit))
    <> "

/// Newest first.
pub const notes = "
    <> lits(notes)
    <> "

/// Newest first.
pub const journal = "
    <> lits(journal)
    <> "

/// The references of the paper, and how each was read (the paper's REFERENCES.md).
pub const references = "
    <> int.to_string(all)
    <> "

pub const read_full_text = "
    <> int.to_string(full)
    <> "

pub const read_abstract = "
    <> int.to_string(abstract)
    <> "

pub const read_page = "
    <> int.to_string(page)
    <> "
"
  write(out, text)
  io.println("research_content: wrote " <> string.drop_start(out, 6))
}
