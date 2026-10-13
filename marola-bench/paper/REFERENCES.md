---
title: "Reference log for marola-bench"
status: draft
date: 2026-10-13
related: [paper.md, refs.bib]
style: reference
---

# Reference log for marola-bench

Every entry of [`refs.bib`](refs.bib) has a row here. A reference is not cited before it is
fetched. "Record read" means the registry's record of the DOI was fetched and its title, authors,
journal, volume, pages and year were copied from it. It does not mean that the text was read:
where only the record was read, the paper says "(v, title only)" and depends on nothing but the
title.

Date of record: 13 October 2026.

| Key | Identifier | How it was checked | What the paper takes from it | Status |
|---|---|---|---|---|
| `mip0091` | [marola-dev/marola at `cf7bd4f`](https://github.com/marola-dev/marola/blob/cf7bd4f/docs/MIPs/MIP-0091-marola-forecaster-architecture.md) | the file was fetched with GitHub's API on 13 October 2026 and read: its header, sections 1, 2, 4.1 to 4.3, 8, 11 and the appendix | every claim marked "(MIP §n)" or "(MIP Rn)" | verified as a source; its own claims are its own |
| `rasp2020weatherbench` | [10.1029/2020MS002203](https://doi.org/10.1029/2020MS002203) | Crossref record read | that it is a benchmark data set for data-driven weather forecasting (its title) | record only |
| `rasp2024weatherbench2` | [10.1029/2023MS004019](https://doi.org/10.1029/2023MS004019) | Crossref record read | that it is a benchmark for data-driven global weather models (its title) | record only |
| `brightband2026owb` | <https://owb.brightband.com/methodology> | two readings by others, not by this paper's writer: the owner's note of 12 October 2026 in h0ffmann/closed-source (`notes/202610122356-operational-weatherbench.md` at `bc1caaf`), and MIP-0091 section 4.1, which quotes the page as fetched on 13 October 2026. The two agree. On 13 October the page answered 200 to this paper's check | the models, the scores, the truth for each model, the regions, the leads, the climatology baseline, the use of WeatherBench-X, the CC BY 4.0 terms | verified, through the note and the MIP |
| `weatherbenchx` | <https://github.com/google-research/weatherbenchX> | GitHub's record of the repository read: description "A modular framework for evaluating weather forecasts", licence Apache-2.0 | that the scorer is open, and its licence | verified |
| `hersbach2020era5` | [10.1002/qj.3803](https://doi.org/10.1002/qj.3803) | Crossref record read | that ERA5 is a global reanalysis (its title) | record only |
| `lam2023graphcast` | [10.1126/science.adi2336](https://doi.org/10.1126/science.adi2336) | Crossref record read | that it is a data-driven global forecast model (its title); the name GraphCast is from the Operational WeatherBench page | record only |
| `pereira2017buoys` | [10.1007/s10236-017-1113-9](https://doi.org/10.1007/s10236-017-1113-9) | Crossref record read; the record has no abstract | that directional wave buoys were operated off the southern Brazilian coast (its title) | record only |
| `li2010contextual` | [10.1145/1772690.1772758](https://doi.org/10.1145/1772690.1772758) | Crossref record read | the term "contextual bandit" (its title). It is not MIP-0091's source for its algorithms; the MIP cites its policy note, which is private | record only |
| `rodwell2010seeps` | [10.1002/qj.656](https://doi.org/10.1002/qj.656) | Crossref record read | that it defines a score for precipitation (its title); the name SEEPS is from the Operational WeatherBench page | record only |
| `gneiting2007scoring` | [10.1198/016214506000001437](https://doi.org/10.1198/016214506000001437) | Crossref record read | the term "proper scoring rule" (its title) | record only |
| `hoffmann2026ww3gpu` | [10.5281/zenodo.23221351](https://doi.org/10.5281/zenodo.23221351) | DataCite record read: creator and title | the author's own work | verified |
| `marola2026` | [10.5281/zenodo.23224155](https://doi.org/10.5281/zenodo.23224155) | DataCite record read: six creators and title | the author's work with five other people | verified |
| `hoffmann2026picasso` | [10.5281/zenodo.23311208](https://doi.org/10.5281/zenodo.23311208) | DataCite record read: creator and title | the author's own work | verified |
| `hoffmann2026closedsource` | [10.5281/zenodo.23333656](https://doi.org/10.5281/zenodo.23333656) | Zenodo record read: v0.3.0, type Book | the author's own work | verified |
| `pekko` | <https://github.com/apache/pekko> | GitHub's record of the repository read: its description and its licence, Apache-2.0 | what Pekko is, in its own words | verified |
| `besom` | <https://github.com/VirtusLab/besom> | GitHub's record and the repository's README read: "Besom Scala SDK for Pulumi", "Scala support is currently in Public Beta", licence Apache-2.0, latest release v0.5.2 of 18 September 2026 | what Besom is, that it is a beta, its latest release | verified |
| `pulumi` | <https://github.com/pulumi/pulumi> | GitHub's record read: "Infrastructure as Code in any programming language", Apache-2.0 | what Pulumi is | verified |
| `speckit` | <https://github.com/github/spec-kit> | GitHub's record read: "Toolkit to help you get started with SDD or any other process!", MIT | that a toolkit for SDD with this name exists. Not checked: that MIP-0091's field "Spec-kit" means this one | verified |
| `reactivemanifesto` | <https://www.reactivemanifesto.org/> | the page was fetched and read: the four properties and the sentence quoted for each | the four properties, in its words | verified. Its authors and its year (2014, version 2.0) are in the entry from memory, not from the page: not checked |
| `pekkosharding` | [Pekko docs, Cluster Sharding](https://pekko.apache.org/docs/pekko/current/typed/cluster-sharding.html) | the page was fetched and read for "Passivation": "If the state of the entities are persistent you may stop entities that are not used to reduce memory consumption." | passivation, in its words | verified |
| `pekkopersistence` | [Pekko docs, Event Sourcing](https://pekko.apache.org/docs/pekko/current/typed/persistence.html) | the page answered 200 and its title is "Event Sourcing"; its text was not read | that Pekko has event-sourced actors | page and title only |
| `pekkofault` | [Pekko docs, Fault Tolerance](https://pekko.apache.org/docs/pekko/current/typed/fault-tolerance.html) | the page answered 200 and has a section "Supervision"; its text was not read | that Pekko has supervision | page and title only |
| `pekkostreams` | [Pekko docs, Basics and working with Flows](https://pekko.apache.org/docs/pekko/current/stream/stream-flows-and-basics.html) | the page answered 200 and has a section "Back-pressure explained"; its text was not read | that Pekko Streams has back-pressure | page and title only |
| `pekkosbr` | [Pekko docs, Split Brain Resolver](https://pekko.apache.org/docs/pekko/current/split-brain-resolver.html) | the page answered 200; its text was not read | that Pekko has a split brain resolver | page and title only |
| `gcpspot` | [Compute Engine docs, Spot VMs](https://cloud.google.com/compute/docs/instances/spot) | the page was fetched and read for the sentence quoted | that Spot VMs are discounted and can be preempted at any time, in its words | verified |
| `smith2016software` | [10.7717/peerj-cs.86](https://doi.org/10.7717/peerj-cs.86) | Crossref record read; the text is checked in h0ffmann/closed-source's own reference log | that software should be cited with a permanent identifier | verified, through that log |

## Checked in a repository, not a reference

- `marola-dev/marola-app`, `build.sbt` at commit `f769245`, read through GitHub's API on 13
  October 2026: `scalaVersion := "3.9.0"`, `kyoVersion = "1.0.0-RC7"`, and no line that names
  Pekko. This supports the two "(v)" marks under hard rule 1.

## Looked for and not cited

- The algorithms named in the paper (Hedge, Thompson sampling with a knapsack, the paired block
  bootstrap, the fair and the threshold-weighted CRPS) have no reference of their own here. They
  are named as MIP-0091 names them. Their sources are in the policy note that the MIP cites,
  which is not public. A v1 needs a public reference for each.
- The Brazilian Navy's buoy programme page (`marinha.mil.br/chm/dados-do-goos-brasil/pnboia`)
  answered 403 to a fetch. It is not cited. The paper says "the national programme" where MIP-0091 says PNBOIA.
- SiMCosta (<https://simcosta.furg.br/>) and INMET (<https://portal.inmet.gov.br/>) answered 200.
  Their pages were not read for what they measure or under which licence, so the paper does not
  name them. They are candidates for the first inventory of open instruments.

## Before v1

Read the text of each "record only" and "page and title only" reference, and change its claim in the paper from
"(v, title only)" to "(v)" with the section or page that supports it.
