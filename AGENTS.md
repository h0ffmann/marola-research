# AGENTS.md

This repository holds marola's research. It holds more than one research. Read this file, then
the `README.md` of the research you work on, then the `ouro-paper` skill.

## Map

- One directory at the root is one research: `marola-bench/` is the first.
- A research has a `README.md` (what it is, its hard rules, its status), a `paper/` directory
  (the text, its references, the log of how each was checked) and its rendered paper,
  `<research>/<research>.pdf`. Its code, when it has code, is in the same directory.
- What every research shares is at the root: this file, `README.md` (the index), `justfile`,
  `flake.nix`, `format/` (what every rendered paper shares), `scripts/` and `.claude/skills/`.
- How a text is written, checked and released: `.claude/skills/ouro-paper/SKILL.md`.

## Rules

1. Humans steer. A thesis, an author, a conclusion and a hard rule of a research are the
   owner's. Stop and ask when a task needs one that nobody gave.
2. A research's hard rules are in its `README.md`. They are not open to an agent's choice.
3. A research does not read the directory of another research. What two of them share goes to
   the root.
4. A new research is a new directory with the three parts above, and one row in the root
   `README.md`. Only the owner starts one.
5. Never invent a reference. Every claim carries a mark (`ouro-paper`).
6. A design change is written in a MIP in `marola-dev/marola` first. A paper gives an account of
   a design; it does not make one.
7. Work on a branch, stage files by path, open a pull request. Never merge, never push to
   `main`, never tag or release.
8. Never weaken a check to get green, and never copy from a private repository.

## Checks before a pull request

Run them before you open it. CI runs the same ones on the pull request and on `main`: a check
that can fail on `main` runs on the pull request first.

| Command | What it checks | In CI |
|---|---|---|
| `just check <research>` | every entry of `refs.bib` has a row in `REFERENCES.md`; the paper builds with no pandoc warning; the committed PDF is the one its text makes | `pdf / build (<research>)`, one job for each research |
| `just md-quality` | the structure (markdownlint-cli2), the prose rules (Vale) and the links to files (lychee) of every Markdown file | `.md / quality` |
| `just md-quality --online` | every web link answers | `live links / alive`, also each Monday |

- After you change a paper's text, run `just paper <research>` and commit the PDF with it.
- A new research needs no change in CI: a directory with `paper/paper.md` gets its own job.
- A logo is a trademark of its project. Never commit a logo's file: list it in
  `<research>/paper/logos.tsv` at a pinned commit with its sha256 (`scripts/logos.sh`).
- A link to a page that needs a login is written as code, not as a link: the check cannot open
  it.
- A quotation is in double quotation marks. Vale does not judge the words inside them.
- The pull request says what was checked, what was not, and each decision that is the owner's.

Not here, because there is nothing for them to check yet: a citation check (no `.zenodo.json`),
a release workflow (no release; an agent never tags) and a site.
