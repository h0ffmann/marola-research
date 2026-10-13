# marola-research

The science of [marola](https://github.com/marola-dev/marola). One directory is one research:
its paper, its sources, the log of how each source was checked, and later its code.

## Researches

| Research | What it is | Paper | Status |
|---|---|---|---|
| [`marola-bench`](marola-bench/README.md) | a WeatherBench for Brazil: Brazilian regions, wave variables, instruments as the truth | [PDF](marola-bench/marola-bench.pdf), [source](marola-bench/paper/paper.md) | a proposal, v0, draft. No score has been computed |

## How to read a paper here

Every claim carries a mark: `(v)` was checked, and the paper's `REFERENCES.md` says how; `⚠`
was not. Every paper ends with what is not known.

## Make a paper

```sh
just paper marola-bench    # marola-bench/paper/*.md -> marola-bench/marola-bench.pdf
```

It needs Nix and `just`. The tools (pandoc, XeLaTeX) come from
[picasso](https://github.com/h0ffmann/picasso)'s `paper` lab, pinned in `flake.lock`.

## For agents

[`AGENTS.md`](AGENTS.md) has the map and the rules;
[`ouro-paper`](.claude/skills/ouro-paper/SKILL.md) is how a text is written and checked. The
skill has no evals yet.

## Checks

`just check <research>` and `just md-quality` are what CI runs, on each pull request and on
`main`: [`pdf`](.github/workflows/pdf.yml) (one job for each research),
[`.md`](.github/workflows/md.yml) and [`live links`](.github/workflows/links.yml).
[`AGENTS.md`](AGENTS.md) says what each one checks.

## Not here yet

A release, a DOI, and any code of a research.

## Licence

The repository's licence is MIT ([`LICENSE`](LICENSE)). The licence for the texts is not
decided: the design that the first paper gives an account of asks for CC BY 4.0 for what it
publishes. Until the owner decides, MIT applies.
