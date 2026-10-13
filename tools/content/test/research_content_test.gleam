import gleeunit
import research_content as generate

pub fn main() -> Nil {
  gleeunit.main()
}

pub fn front_matter_fields_test() {
  let lines =
    generate.front_lines(
      "---\ntitle: \"A: b\"\nstatus: draft\nabstract: |\n  one\n  two\nnext: x\n---\n# T\n",
    )
  assert generate.field(lines, "title") == "A: b"
  assert generate.field(lines, "status") == "draft"
  assert generate.field(lines, "abstract") == "one two"
  assert generate.field(lines, "missing") == ""
  assert generate.front_lines("# no front matter\n") == []
}

pub fn numbered_items_join_their_lines_test() {
  assert generate.numbered([
      "The owner's rules.", "", "1. marola-bench is in **Apache Pekko**, in",
      "   **Scala 3**.", "2. Two.", "", "Rules 1 and 2 change the design.",
    ])
    == ["marola-bench is in Apache Pekko, in Scala 3.", "Two."]
}

pub fn plain_takes_the_marks_out_test() {
  assert generate.plain("the **record** is a `book` ([why](x.md))")
    == "the record is a book (why)"
}

pub fn sections_and_unknowns_test() {
  let paper =
    "## Hard rules\n\n## 1. Summary\n\n## 9. What is not known\n\n- **The name.** x\n- plain\n- **A second.** y\n\n## 10. Where\n"
  assert generate.sections(paper) == ["Summary", "What is not known", "Where"]
  assert generate.unknowns(paper) == ["The name", "A second"]
}

pub fn reading_counts_how_each_reference_was_read_test() {
  let log =
    "| Key | Identifier | Read | Passage | Status |\n|---|---|---|---|---|\n| `a` | x | full text, arXiv | q | verified |\n| `b` | x | abstract, Crossref | q | verified |\n| `c` | x | the page | q | verified |\n"
  assert generate.reading(log) == #(3, 1, 1, 1)
}

pub fn logos_are_the_rows_of_the_list_test() {
  assert generate.logos(
      "# a comment\nmarola\thttps://x/logo.svg\tabc\thttps://marola.dev\n\n",
    )
    == [#("marola", "https://x/logo.svg", "https://marola.dev")]
}
