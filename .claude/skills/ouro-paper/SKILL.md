---
name: ouro-paper
description: "Write, check and release a citable research text the way marola's research is made: a paper, a proposal or a report in a research directory (<research>/paper/). Use when asked to write or draft a paper or proposal, add a section or a reference, check a paper before a pull request, prepare its release or DOI, or make its easy pt-BR version. Use it before any other writing skill in this repository."
---

# ouro-paper

Written for this repository. It combines the working rules of four of the owner's projects:
h0ffmann/closed-source, h0ffmann/ww3-gpu, h0ffmann/picasso and marola-dev/marola. No file or
paragraph of theirs is copied; each rule names where it comes from, at a commit ("Sources").

**Audience.** An agent that writes or changes a text in a research directory (`AGENTS.md` says
what a research is). A person can read it as
the list of what a paper here must pass.

**Status: untested.** `evals/evals.json` has three cases, and nobody has run them: nobody has
measured that this skill triggers, or that a paper is better with it than without it.

Several steps came from other people's skills for paper quality. [`REA.md`](REA.md) names each
one at a commit, with its licence, and says what was adopted and what was left. Nothing of theirs
is copied.

## The loop

"Ouro" is for Ouroboric: the work documents itself as it documents its subject. A paper here is
never only prose. It is prose, its sources, the log of how each source was checked, and the
marks that say what was checked.

1. **Read** what exists before you write: the design (a MIP), the notes, the code.
2. **Evaluate** each thing on your own terms: fetch it, run it, or mark it unchecked.
3. **Adopt** only what passed, with credit pinned to a DOI or a commit.
4. **Write**, with a mark on every claim.
5. **Log** how each source was checked.
6. **Say** what is not known.

## Hard rules

**Hard rule: humans steer.** The thesis, the authors and the conclusions are the owner's. Do not
change one without the owner's word. If the task needs one that nobody gave, stop and ask.

**Hard rule: never invent a reference.** Fetch a source before you cite it. Copy its title,
authors, journal and year from the registry's record (Crossref, DataCite), not from memory. A
source you could not fetch is not cited; it goes in the log under "Looked for and not cited".
What does not count as reading a source: a search result's snippet, a summary, your memory, and
the reference list of another paper.

**Hard rule: every claim has a mark.**

- `(v)`: checked while writing. The log says how.
- `(v, title only)`: the source's record was read and its text was not. The claim then depends
  on nothing but the title.
- `(MIP §n)` or `(MIP Rn)`: the claim is a design's, from that place in it.
- `⚠`: not checked.

Never remove a `⚠` without doing the check. Never turn a plan or a projection into a
measurement.

A mark belongs to the words it was made for. When you reword a claim, the mark is gone until the
check is done again for the new words. A mark from an earlier session is a note of where to
look, not a check.

"The source does not say" is not "it is not so". Write which of the two you found.

**Hard rule: every number has its command.** A number in a table comes with its unit and the
command or the source that produces it. A number that was copied by hand is `⚠`.

**Hard rule: no result before parity.** Do not report that something is faster or better before
you show that it is correct. Never widen a tolerance to make a check pass.

**Hard rule: facts and analysis stay apart.** Say which sentence is a fact with a source and
which is the writer's reading.

**Hard rule: the design wins.** When a paper gives an account of a MIP, the MIP is the source.
Cite it at a commit. If the two disagree, change the paper, or stop and ask if the MIP is the
one that is wrong. Do not design in a paper.

**Hard rule: a private source stays private.** Do not copy from a private repository or a held
note. Say that it exists and that it is not public, and leave its content out.

**Hard rule: an agent does not release.** A release makes a DOI, and a DOI cannot be deleted.
The owner tags. An agent prepares the metadata and gives the owner the command.

**Hard rule: never weaken a check to get green.** Do not remove, skip or loosen one.

## A paper's files

```text
<research>/
  README.md         what the research is, its hard rules, its status
  <research>.pdf    the rendered paper (`just paper <research>`)
  notes/            the slip box: one idea in one note (NOTES.md)
  journal/          one entry for each challenge met (NOTES.md)
  site/             the website, built from the files of this directory
  paper/
    paper.md        the text: front matter, then prose with a mark on each claim
    refs.bib        every reference; a DOI where one exists
    REFERENCES.md   one row for each entry of refs.bib: how it was checked, what the paper takes
```

`paper.md` starts with front matter: `title`, `author`, `status` (`draft` until the owner says
otherwise), `version`, `date`, `related`, `style: research`.

The first thing after the title is a block that says what the text is (a proposal, a report, a
result), what it is not, and how to read the marks.

The last sections are always "What is not known" and "Where the thesis comes from".

**Hard rules of a research.** When the owner gives a rule for a research ("it is implemented in
X"), write it in the research's `README.md` and at the top of its paper, in his words and with
the date. Then say, for each rule, what it meets today: what already agrees, and what in an
accepted design it changes. Do not hide a conflict and do not resolve it; the next MIP does.

## Steps

1. **Find the design.** Look for a MIP or a note that already says what the paper will say.
   Read it whole. If there is one, the paper is an account of it.
2. **List the claims** you intend to make, before the prose. Give each one its kind, because the
   kind says what can check it:

   | Kind | It says | What checks it |
   |---|---|---|
   | a fact about a source | "the page says X" | the passage, quoted |
   | a description | "there are ten buoys" | a count, a file, a record, with its date |
   | a cause | "X makes Y cheaper" | a measurement. A reason is not one: mark it as a proposal |
   | a forecast | "this will hold next year" | nothing yet. Say so |
   | a design choice | "the truth is an instrument" | the design it comes from, at a commit |
   | a claim of being first | "no benchmark has a Brazilian region" | nobody can check it by reading. Narrow it to what was looked at, and when |

3. **Check each one**, and write the row in `REFERENCES.md` as you go, not after. A reference
   passes three checks, and all three are against the source itself:
   - **It exists**, and its title, authors, venue and year are copied from one record.
   - **It is the work you mean.** An identifier that resolves can be another work. A preprint
     can have a published version; cite that one.
   - **It says what you say it says.** Quote the passage. Look for a correction or a retraction.

   The verdict is one of three: *verified*, *mismatch* (it exists and does not say that) or
   *not found*. Doubt is "not found". For what you looked for and did not cite, the log keeps
   the search: where, with which words, on which day.
4. **Write the body.** Short sentences. Active voice. One idea in a sentence. Numbers, not
   adjectives. A technical word is explained the first time. A mark is short; the account of the
   check is in the log, not in the sentence.
5. **Cut what failed.** A claim that you could not check is marked `⚠` or removed. Do not soften
   it into a claim that sounds the same.
6. **Write the ends last.** "What is not known", from the `⚠` marks and from the design's own
   open questions. Then the summary and the abstract, when the body exists: an opening that was
   written first promises what the writer hoped, and the last one promises what the evidence
   gives. Write a note for each idea the paper stands on, and a journal entry for each challenge
   the work met, in the same pull request (`NOTES.md`). A claim that reading corrected is a
   journal entry, not a silent edit.
7. **The mechanical pass.** Faults that a tool or a count can find, before anybody judges the
   text:
   - **the numbers:** a number that is written in more than one place (the abstract, a section,
     the site) is the same in each. List them and compare;
   - **the names:** one word for one thing, from the first page to the last;
   - **the facts after a style edit:** when a sentence was changed for its style, compare its
     facts, numbers and citations with what it had before;
   - `just paper <research>`, then read the PDF: a citation that did not resolve shows as its
     key. Then `just check <research>` and `just md-quality`; CI runs the same.
8. **The cold reader.** Give the rendered paper, and nothing else, to a reader that has not seen
   the work: a fresh agent, or a person. Do not tell it what you think of the text.
   - Ask it five to ten questions that a reader of the paper would ask. Where it answers wrong,
     or cannot, the paper is unclear there.
   - Ask it for faults. A finding has five parts: where; the words, quoted; the rule or the
     evidence; why it matters; what to do. A finding that quotes nothing is dropped. Five that
     are certain are worth more than thirty that are not.
   - Fix, and write in the pull request what it found.
9. **Open a pull request.** Work on a branch and stage files by path. In the body: what was
   checked, with what each check printed, pasted; what was not; and each decision that is the
   owner's. "Checked" with no output is not a check. Do not merge.

When a paper reports a study (a trial, a review, a measurement on animals or people), name the
reporting guideline for its design and follow it. When it has a statistic, give the number of
cases, the exact value, the size of the effect and its interval. No paper here has either yet.

## Borrow, cite, propagate

1. **Borrow** only what the licence allows. Read the licence first and record it.
2. **Cite** at the point of use: a DOI when there is one, else a URL with a commit.
3. **Propagate** the credit: the work goes into `refs.bib`, and at a release into the record's
   related works.

A skill, a script or a template from another repository is not copied here on trust. Write it
here and name its source, or vendor it with its licence and its commit.

## Release, when the owner asks

Not built in this repository yet. When it is, it follows the chain the four projects share:

- `.zenodo.json` is the one citation file edited by hand. `CITATION.cff` and the "how to cite"
  block are generated from it and checked in CI.
- Never write `version`, `publication_date` or `doi` in it. Zenodo sets them.
- A release is a Git tag `vMAJOR.MINOR.PATCH` on a green `main`. A workflow makes the GitHub
  release, and Zenodo's webhook mints the DOI. Cite the concept DOI for "the work" and the
  version DOI for "this exact text".
- A supervisor is a contributor, never a creator.
- After a release, one pull request writes the new DOI wherever the latest release is named.

## An easy pt-BR version

When asked for a "versão fácil": put `<name>.easy.pt-BR.md` beside the source. Start it with a
block that says: the original wins; which dated version it was made from; who it is for; what
was left out; who wrote it. Keep every claim and every mark. Explain each hard word where it
first appears. Add no fact.

## What this skill does not do

- It does not make a typeset journal paper. `just paper` renders a plain PDF with pandoc and
  XeLaTeX from `picasso`'s `paper` lab, pinned in `flake.lock`. There is no template and no arXiv
  bundle yet.
- It does not check that a claim is true. It makes the writer say how it was checked.
- It does not replace a referee. The cold reader of step 8 finds what is unclear and what is
  unsupported; it does not judge whether the work matters.
- It does not decide a thesis, a name, a licence or a release.

## Sources

Two kinds. The working rules of the owner's own projects are below. The ideas from other
people's skills for paper quality are in [`REA.md`](REA.md): seven repositories, twelve skills,
each at a commit with its licence. Six of them are K-Dense's (Kassis, Agarwal, He, Patel and
Brueckner, 2026, *Scientific Agent Skills*, arXiv:2609.00065); they are pinned in
[`../skills.lock`](../skills.lock) and can be fetched as they are with `just skills fetch`, for a
task that needs the skill itself and not only its idea.

Read on 13 October 2026. Each line is a rule of this skill and the place it was read.

- **Humans steer; never invent a reference; never weaken a guardrail; borrow, cite, propagate;
  the reference log; "what is not known"; the easy pt-BR header.** h0ffmann/closed-source at
  `bc1caaf`: `AGENTS.md`, `papers/closed-source/REFERENCES.md`,
  `.claude/skills/easy-pt-br/SKILL.md`
  (<https://github.com/h0ffmann/closed-source/tree/bc1caaf>).
- **The `(v)` and `⚠` marks; every number with its command; no timing without parity; never
  widen a tolerance; the lab notebook with negative results.** h0ffmann/ww3-gpu at `fe472ab`:
  `AGENTS.md`, `CONTRIBUTING.md`, `docs/log/README.md`
  (<https://github.com/h0ffmann/ww3-gpu/tree/fe472ab>).
- **A toolchain is a dependency, so pin it; `.zenodo.json` is the one hand-edited citation file;
  an agent never tags; a commit says what was tested, or that it was not; every reference
  checked against Crossref, arXiv or the primary page.** h0ffmann/picasso at `3d60c00`:
  `AGENTS.md`, `PHILOSOPHY.md`, `labs/paper/README.md`,
  `docs/whitepapers/determinism-2026/README.md`
  (<https://github.com/h0ffmann/picasso/tree/3d60c00>).
- **Design first, in a MIP; "every claim names what checked it … or says it was not checked";
  the release chain and "a DOI cannot be deleted"; a supervisor is a contributor; the shape of a
  skill (a name, a description, an audience, hard rules); "A status nobody can reproduce is
  Untested".** marola-dev/marola at `cf7bd4f`: `AGENTS.md`, `.claude/rules/docs.md`,
  `.claude/skills/zenodo-release/SKILL.md`; and marola-dev/marola-skills at `72b5740`:
  `docs/3-development.md` (<https://github.com/marola-dev/marola/tree/cf7bd4f>).
- **Read, Evaluate, Adopt; facts kept apart from analysis; "Humans steer".**
  ouroboric-dev/ouroboric at `b355b1d`: `AGENTS.md`,
  `docs/4-ways-of-working/writing-styles.md`
  (<https://github.com/ouroboric-dev/ouroboric/tree/b355b1d>). The Ouroboric ideas are Bruno
  Valério's.

The four works have DOIs: closed-source
[10.5281/zenodo.23333656](https://doi.org/10.5281/zenodo.23333656), ww3-gpu
[10.5281/zenodo.23221351](https://doi.org/10.5281/zenodo.23221351), picasso
[10.5281/zenodo.23311208](https://doi.org/10.5281/zenodo.23311208) and marola
[10.5281/zenodo.23224155](https://doi.org/10.5281/zenodo.23224155).

Three of the five sets of files were read by a helper agent in this session and reported with
their quotations; the writer of this skill read closed-source directly and did not open the
other files again.
