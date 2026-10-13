//// The page of marola-bench. Every fact (titles, rules, notes, counts) comes from
//// `content.gleam`, which `generate` writes from the research's files. The sentences that tell
//// the story are written here.

import gleam/int
import gleam/list
import gleam/string
import lustre/attribute.{type Attribute}
import lustre/effect.{type Effect}
import lustre/element.{type Element}
import lustre/element/html
import lustre/event
import marola_bench_site/content.{type Entry, type Logo, type Note}

/// Which text of the abstract is shown.
pub type Text {
  Original
  EasyPtBr
}

pub type Model {
  Model(text: Text)
}

pub type Msg {
  ShowText(Text)
}

pub fn initial() -> Model {
  Model(text: Original)
}

pub fn init(_: Nil) -> #(Model, Effect(Msg)) {
  #(initial(), effect.none())
}

pub fn update(_: Model, msg: Msg) -> #(Model, Effect(Msg)) {
  case msg {
    ShowText(text) -> #(Model(text:), effect.none())
  }
}

/// A workflow of the repository: its name as GitHub shows it, and its file.
pub type Check {
  Check(name: String, file: String, does: String)
}

/// The checks of the repository. `just site` fails when a file named here is not a workflow.
pub const checks = [
  Check(
    "pdf",
    "pdf.yml",
    "the paper builds, every reference has its row and is cited, and the PDF is the one its text makes.",
  ),
  Check(
    ".md",
    "md.yml",
    "structure, plain words and links to files, in every Markdown file; the notes keep their rules.",
  ),
  Check("live links", "links.yml", "every web link answers."),
  Check(
    "site",
    "site.yml",
    "this page builds from the research's files and its tests pass.",
  ),
]

fn tree(path: String) -> String {
  content.repo <> "/blob/main/" <> content.slug <> "/" <> path
}

fn link(href: String, label: String) -> Element(msg) {
  html.a([attribute.href(href)], [html.text(label)])
}

fn external(href: String, label: String) -> Element(msg) {
  html.a([attribute.href(href), attribute.rel("noopener")], [html.text(label)])
}

fn head(id: String, title: String, aside: Element(msg)) -> Element(msg) {
  html.div([attribute.class("head")], [
    html.h2([attribute.id(id)], [html.text(title)]),
    aside,
  ])
}

/// The title's two halves: "marola-bench" and what it is.
pub fn title_parts() -> #(String, String) {
  case string.split_once(content.title, ": ") {
    Ok(parts) -> parts
    Error(_) -> #(content.title, "")
  }
}

pub fn view(model: Model) -> Element(Msg) {
  html.div([], [
    cover(),
    html.main([attribute.class("wrap")], [
      stamps(),
      bench_section(),
      gaps_section(),
      rules_section(),
      system_section(),
      reactive_section(),
      standing_section(),
      read_section(model),
      notes_section(),
      journal_section(),
      references_section(),
      checks_section(),
      unknown_section(),
    ]),
    footer(),
  ])
}

fn cover() -> Element(msg) {
  let #(name, what) = title_parts()
  html.header([attribute.class("cover")], [
    html.div([attribute.class("wrap")], [
      html.p([attribute.class("imprint")], [
        external(content.repo, "marola research"),
        html.text(" / " <> content.date),
      ]),
      html.h1([], [html.text(name)]),
      html.p([attribute.class("what")], [html.text(what)]),
      html.p([attribute.class("sub")], [html.text(content.subtitle)]),
      html.figure([attribute.class("series")], [
        html.img([
          attribute.src("drawings/series.svg"),
          attribute.alt(
            "An empty chart: a time axis, a score axis and a dashed line for the climatology floor. No series is drawn.",
          ),
          attribute.width(960),
          attribute.height(260),
        ]),
        html.figcaption([], [
          html.b([], [html.text("The bench today. ")]),
          html.text(
            "A series for each forecaster at each point will be drawn here. None is: "
            <> content.version
            <> ".",
          ),
        ]),
      ]),
      html.p([attribute.class("actions")], [
        html.a([attribute.class("button"), attribute.href("paper.pdf")], [
          html.text("Read the paper (PDF)"),
        ]),
        html.a(
          [
            attribute.class("button quiet"),
            attribute.href(content.repo <> "/tree/main/" <> content.slug),
            attribute.rel("noopener"),
          ],
          [html.text("The research on GitHub")],
        ),
      ]),
      html.nav([attribute.class("jump")], [
        link("#bench", "The bench"),
        link("#rules", "Rules"),
        link("#system", "How it works"),
        link("#standing", "Where it stands"),
        link("#read", "Read"),
        link("#notes", "Notes"),
        link("#journal", "Journal"),
        link("#checks", "Checks"),
        link("#unknown", "Not known"),
      ]),
    ]),
  ])
}

/// Whose work this is and which way it is made: the logos of the paper's first page, loaded from
/// their owners' repositories. They are trademarks and are not copied here.
fn stamps() -> Element(msg) {
  case content.logos {
    [] -> element.none()
    logos ->
      html.p(
        [attribute.class("stamps")],
        list.map(logos, fn(l: Logo) {
          html.a([attribute.href(l.href), attribute.rel("noopener")], [
            html.img([
              attribute.src(l.src),
              attribute.alt(l.name),
              attribute.height(36),
              attribute.attribute("loading", "lazy"),
            ]),
          ])
        }),
      )
  }
}

fn bench_section() -> Element(msg) {
  html.section([attribute.class("lede")], [
    head("bench", "What the bench is", element.none()),
    html.blockquote([], [
      html.p([], [html.text("“" <> content.bench <> "”")]),
      html.footer([], [html.text(content.author <> ", the owner")]),
    ]),
    html.p([attribute.class("prose")], [
      html.text(
        "A score is one forecast compared with one observation. A series is those scores in order of time, for one forecaster, one point, one variable and one lead. The bench is all the series, and it is the final goal: the points, the actors and the cloud exist to make it.",
      ),
    ]),
  ])
}

fn gaps_section() -> Element(msg) {
  let gap = fn(title, body) {
    html.li([], [html.h3([], [html.text(title)]), html.p([], [html.text(body)])])
  }
  html.section([], [
    head(
      "gaps",
      "Three things the public benchmarks do not have",
      link("#read", "the paper, sections 1 and 2"),
    ),
    html.p([attribute.class("prose")], [
      html.text(
        "WeatherBench, WeatherBench 2 and Operational WeatherBench made weather models comparable. marola-bench keeps their method: one scorer, a truth that is stated one time, fixed leads and regions, a rule written before the scores. It changes three things.",
      ),
    ]),
    html.ul([attribute.class("gaps")], [
      gap(
        "A region that is Brazil",
        "The operational scoreboard offers the globe, the tropics, the two hemispheres, North America and Europe.",
      ),
      gap(
        "A score for waves",
        "Its variables are of the atmosphere. marola forecasts the sea.",
      ),
      gap(
        "An instrument as the truth",
        "There, a model is scored against its own analysis. Here, against what a buoy or a station measured.",
      ),
    ]),
  ])
}

fn rules_section() -> Element(msg) {
  html.section([], [
    head(
      "rules",
      int.to_string(list.length(content.rules)) <> " hard rules",
      external(tree("README.md"), "the research's page"),
    ),
    html.p([attribute.class("prose")], [
      html.text(
        "The owner's rules. They are not open to an agent's choice. Four of them change the design that was accepted the same day, and the paper says where; a new design document must settle the rest before code is written.",
      ),
    ]),
    html.ol(
      [attribute.class("rules")],
      list.map(content.rules, fn(r) { html.li([], [html.text(r)]) }),
    ),
  ])
}

fn system_section() -> Element(msg) {
  let step = fn(title, body) {
    html.li([], [html.b([], [html.text(title)]), html.text(" " <> body)])
  }
  html.section([], [
    head("system", "How it works", link("#read", "the paper, section 4")),
    html.div([attribute.class("with-drawing")], [
      html.ol([attribute.class("steps")], [
        step(
          "A person adds a point.",
          "A buoy or a station, through an API. By hand, because a point has an instrument, a quality flag and a licence, and somebody must read the terms.",
        ),
        step(
          "The point gets an actor.",
          "One small program for one point. It knows when the next observation is due.",
        ),
        step(
          "The actor asks the forecasters.",
          "The providers that publish a model today, and marola's own forecaster later. It asks all of them the same way.",
        ),
        step(
          "The actor registers a score.",
          "One forecast against one observation. A score that was registered is not edited.",
        ),
        step(
          "The scores are the series, and the series are the bench.",
          "marola's forecaster is in it as one forecaster among the others.",
        ),
      ]),
      html.span(
        [
          attribute.class("drawing buoy"),
          attribute.attribute("aria-hidden", "true"),
        ],
        [],
      ),
    ]),
  ])
}

fn reactive_section() -> Element(msg) {
  let row = fn(name, cheap, reliable) {
    html.tr([], [
      html.th([attribute.attribute("scope", "row")], [html.text(name)]),
      html.td([], [html.text(cheap)]),
      html.td([], [html.text(reliable)]),
    ])
  }
  html.section([], [
    head(
      "reactive",
      "Cheap, and reliable",
      link("#read", "the paper, section 4.4"),
    ),
    html.p([attribute.class("pull")], [
      html.text("Reliability is what makes it cheap."),
    ]),
    html.p([attribute.class("prose")], [
      html.text(
        "Cheap capacity on a cloud is the kind that can be taken away. A cluster that survives the loss of any node can use it. So the two requirements are one piece of work: first survive the loss of a node, then buy the cheap nodes. The four properties of a reactive system are used for both.",
      ),
    ]),
    html.table([attribute.class("properties")], [
      html.thead([], [
        html.tr([], [
          html.th([attribute.attribute("scope", "col")], [html.text("Property")]),
          html.th([attribute.attribute("scope", "col")], [html.text("Cheap")]),
          html.th([attribute.attribute("scope", "col")], [html.text("Reliable")]),
        ]),
      ]),
      html.tbody([], [
        row(
          "Message driven",
          "An actor that waits uses no processor.",
          "One failed point or provider does not stop the others.",
        ),
        row(
          "Resilient",
          "A node may be lost, so capacity that can be taken away is usable.",
          "An actor's state is its stored events: no score is lost with a node.",
        ),
        row(
          "Elastic",
          "An idle actor is stopped. Memory follows the work, not the number of points.",
          "More points do not need a larger design.",
        ),
        row(
          "Responsive",
          "No capacity is kept for a peak.",
          "An answer that does not come in time is a row that says missing, never a guess.",
        ),
      ]),
    ]),
    html.p([attribute.class("note")], [
      html.text(
        "These are proposals for the next design document. Nothing has been priced, and no cluster exists.",
      ),
    ]),
  ])
}

fn standing_section() -> Element(msg) {
  let item = fn(state, what, detail) {
    html.li([attribute.class("is-" <> state)], [
      html.span([attribute.class("state")], [html.text(state)]),
      html.b([], [html.text(what)]),
      html.span([], [html.text(detail)]),
    ])
  }
  html.section([], [
    head(
      "standing",
      "Where it stands",
      external(tree("journal/README.md"), "the journal"),
    ),
    html.ul([attribute.class("standing")], [
      item(
        "done",
        "The proposal",
        content.status <> ", " <> content.version <> ".",
      ),
      item(
        "done",
        "The references",
        int.to_string(content.references)
          <> " of them, each read against a passage of its own text.",
      ),
      item(
        "done",
        "The accepted design",
        "MIP-0091, in marola's main repository.",
      ),
      item(
        "open",
        "A design for the five rules",
        "How Pekko, GCP and Besom meet the accepted design.",
      ),
      item("none", "Code", "None yet."),
      item("none", "Observation points", "None yet."),
      item("none", "Scores", "None yet."),
    ]),
  ])
}

fn pressed(on: Bool) -> Attribute(msg) {
  attribute.attribute("aria-pressed", case on {
    True -> "true"
    False -> "false"
  })
}

/// One paragraph of the easy abstract: "**lead.** text" becomes a bold lead and its text.
fn easy_paragraph(p: String) -> Element(msg) {
  case string.split(p, "**") {
    ["", lead, rest] ->
      html.p([], [html.b([], [html.text(lead)]), html.text(rest)])
    _ -> html.p([], [html.text(string.replace(p, "*", ""))])
  }
}

fn read_section(model: Model) -> Element(Msg) {
  let button = fn(text: Text, label: String) {
    html.button([pressed(model.text == text), event.on_click(ShowText(text))], [
      html.text(label),
    ])
  }
  html.section([], [
    head("read", "Read", external(tree("paper/paper.md"), "the source")),
    html.div([attribute.class("filters")], [
      button(Original, "Abstract"),
      case content.abstract_easy_pt_br {
        "" -> element.none()
        _ -> button(EasyPtBr, "🇧🇷 versão fácil, passo a passo")
      },
    ]),
    case model.text {
      Original ->
        html.div([attribute.class("prose")], [
          html.p([], [html.text(content.abstract)]),
        ])
      EasyPtBr ->
        html.div(
          [attribute.class("prose easy"), attribute.attribute("lang", "pt-BR")],
          list.append(
            content.abstract_easy_pt_br
              |> string.split("\n\n")
              |> list.map(easy_paragraph),
            [
              html.p([attribute.class("note")], [
                html.text(
                  "Vale o original, em inglês. Esta versão explica o resumo; ela não diz nada novo sobre o trabalho.",
                ),
              ]),
            ],
          ),
        )
    },
    html.ol(
      [attribute.class("contents")],
      list.map(content.sections, fn(s) { html.li([], [html.text(s)]) }),
    ),
    html.iframe([
      attribute.class("preview"),
      attribute.src("paper.pdf"),
      attribute.title("Preview of the paper (PDF)"),
      attribute.attribute("loading", "lazy"),
    ]),
    html.p([attribute.class("note")], [
      html.text("The preview does not show on every phone. "),
      link("paper.pdf", "Open the PDF"),
      html.text(" or "),
      html.a(
        [
          attribute.href("paper.pdf"),
          attribute.download(content.slug <> ".pdf"),
        ],
        [html.text("download it")],
      ),
      html.text("."),
    ]),
  ])
}

fn tag(text: String, class: String) -> Element(msg) {
  html.span([attribute.class("tag " <> class)], [
    html.text(string.replace(text, "-", " ")),
  ])
}

fn notes_section() -> Element(msg) {
  html.section([], [
    head("notes", "Notes", external(tree("notes/index.md"), "the slip box")),
    html.p([attribute.class("prose")], [
      html.text(
        "One idea in one note, linked to other notes, each with how far it was checked. The paper is written from them.",
      ),
    ]),
    html.ul(
      [attribute.class("records")],
      list.map(content.notes, fn(n: Note) {
        html.li([], [
          external(tree("notes/" <> n.file <> ".md"), n.title),
          html.span([attribute.class("tags")], [
            tag(n.kind, ""),
            tag(n.status, "is-" <> n.status),
          ]),
        ])
      }),
    ),
  ])
}

fn journal_section() -> Element(msg) {
  html.section([], [
    head(
      "journal",
      "Journal",
      external(tree("journal/README.md"), "every entry"),
    ),
    html.p([attribute.class("prose")], [
      html.text(
        "One entry for each challenge met: what was hard, the options, the decision, the result and the lesson. What went wrong is an entry too.",
      ),
    ]),
    html.ul(
      [attribute.class("records")],
      list.map(content.journal, fn(e: Entry) {
        html.li([], [
          external(tree("journal/" <> e.file <> ".md"), e.title),
          html.span([attribute.class("tags")], [
            html.span([attribute.class("tag")], [html.text(e.date)]),
            tag(e.status, "is-" <> e.status),
          ]),
        ])
      }),
    ),
  ])
}

fn stat(value: Int, label: String) -> Element(msg) {
  html.li([], [
    html.b([], [html.text(int.to_string(value))]),
    html.span([], [html.text(label)]),
  ])
}

fn references_section() -> Element(msg) {
  html.section([], [
    head(
      "references",
      "References",
      external(tree("paper/REFERENCES.md"), "how each one was checked"),
    ),
    html.p([attribute.class("prose")], [
      html.text(
        "No reference is cited before it is fetched. For each one, a passage of its own text that supports the claim was read, and the log quotes it and says how much of the source was read.",
      ),
    ]),
    html.ul([attribute.class("stats")], [
      stat(content.references, "references"),
      stat(content.read_full_text, "read as full text"),
      stat(content.read_abstract, "read as an abstract"),
      stat(content.read_page, "read as a page or a record"),
    ]),
  ])
}

fn checks_section() -> Element(msg) {
  let badge = fn(c: Check) {
    html.li([], [
      html.a(
        [
          attribute.href(content.repo <> "/actions/workflows/" <> c.file),
          attribute.rel("noopener"),
        ],
        [
          html.img([
            attribute.src(
              "https://img.shields.io/github/actions/workflow/status/marola-dev/marola-research/"
              <> c.file
              <> "?branch=main&label="
              <> string.replace(c.name, " ", "%20")
              <> "&style=flat-square&labelColor=0B2A3F",
            ),
            attribute.alt(c.name <> ": the state of its last run"),
            attribute.height(20),
            attribute.attribute("loading", "lazy"),
          ]),
        ],
      ),
      html.span([], [html.text(c.does)]),
    ])
  }
  html.section([], [
    head("checks", "Checks", external(content.repo <> "/actions", "all runs")),
    html.p([attribute.class("prose")], [
      html.text(
        "A change to the paper is a proposal first. Machines read it, then a person decides. The same checks run on the proposal and on the main branch, and each badge is the state of that check now.",
      ),
    ]),
    html.ul([attribute.class("checks")], list.map(checks, badge)),
  ])
}

fn unknown_section() -> Element(msg) {
  html.section([], [
    head(
      "unknown",
      "What is not known",
      link("#read", "the paper's last sections"),
    ),
    html.p([attribute.class("prose")], [
      html.text(
        "Every paper here ends with what is not known. For this one, from its own list:",
      ),
    ]),
    html.ul(
      [attribute.class("unknowns")],
      list.map(content.unknowns, fn(u) { html.li([], [html.text(u)]) }),
    ),
  ])
}

fn footer() -> Element(msg) {
  html.footer([attribute.class("foot")], [
    html.div([attribute.class("wrap")], [
      html.p([], [
        html.text(content.author <> ". Built from "),
        external(
          content.repo <> "/commit/" <> content.revision,
          "commit " <> content.revision,
        ),
        html.text(". Texts under CC BY 4.0, code under MIT ("),
        external(content.repo <> "/blob/main/REUSE.toml", "REUSE.toml"),
        html.text(")."),
      ]),
      html.p([], [
        html.text("This is "),
        external("https://marola.dev", "marola"),
        html.text("'s research, made in the "),
        external("https://github.com/ouroboric-dev/ouroboric", "Ouroboric"),
        html.text(
          " way, whose ideas are Bruno Valério's. The names and logos of marola and Ouroboric are trademarks of their projects. The site is Gleam and Lustre, with tools pinned by Nix from ",
        ),
        external("https://github.com/h0ffmann/picasso", "picasso"),
        html.text(", after the site of "),
        external("https://github.com/h0ffmann/closed-source", "closed-source"),
        html.text("."),
      ]),
    ]),
  ])
}
