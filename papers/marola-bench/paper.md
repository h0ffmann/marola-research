---
title: "marola-bench: a proposal for a WeatherBench for Brazil"
subtitle: "One scorer, Brazilian truth, and a ranking rule written before the scores"
author: "Matheus Hoffmann"
status: draft
version: "v0 (a proposal, not peer reviewed; no score has been computed)"
date: 2026-10-13
related: [REFERENCES.md, refs.bib, ../../.claude/skills/ouro-paper/SKILL.md, "https://github.com/marola-dev/marola/blob/cf7bd4f/docs/MIPs/MIP-0091-marola-forecaster-architecture.md"]
style: research
---

# marola-bench: a proposal for a WeatherBench for Brazil

> **What this is.** A proposal, for a reader outside marola. It says what the benchmark is for,
> what it copies, and what it adds. It reports no result: no wave forecast has been scored.
>
> **Where the design is.** The design is marola's MIP-0091, accepted by the owner on 13 October
> 2026 with the note "needs refinement" [@mip0091]. This paper is the short public account of
> it. If the two disagree, the MIP is right and this paper is out of date.
>
> **How to read the marks.** **(v)** means that the claim was checked while this paper was
> written, and [`REFERENCES.md`](REFERENCES.md) says how. **(MIP §n)** means that the claim is
> the design's, from that section of MIP-0091; the MIP keeps its own list of what it checked and
> what it did not. **⚠** means not checked by anyone yet.

## Hard rule: the implementation

> **marola-bench will be implemented in Apache Pekko, in Scala 3.**
>
> This is the owner's rule (Hoffmann, 13 October 2026). It is not a proposal and it is not open
> to an agent's choice. Code for marola-bench in another language or on another runtime is wrong,
> even when it works.

What the rule meets today, read on 13 October 2026:

- **Scala 3 is already the language.** marola-app's build sets Scala 3.9.0 (`build.sbt` at
  commit `f769245`) **(v)**.
- **Pekko is new.** That build uses Kyo 1.0.0-RC7 and has no Pekko dependency **(v)**. MIP-0091
  describes the forecaster as a module on "the same toolchain (Scala 3, Kyo RC7, JDK 25)"
  **(MIP §4.4)**.
- So the rule changes the accepted design in one place: the runtime. By marola's own rule, a
  change like that is written in a MIP first. Until MIP-0091 is amended or a new MIP says how
  Pekko and the existing Kyo module live together, this paper states the rule and the design
  states Kyo. The rule is the owner's later word, so the rule wins.

The rule does not say which parts of Pekko (actors, streams, cluster), and this paper does not
guess. That is for the MIP.

## 1. Summary

Public benchmarks made weather forecast models comparable. WeatherBench is a benchmark data set
for data-driven weather forecasting [@rasp2020weatherbench] **(v, title only)**. WeatherBench 2
is a benchmark for the next generation of data-driven global models [@rasp2024weatherbench2]
**(v, title only)**. Operational WeatherBench scores operational models as they run
[@brightband2026owb] **(v)**.

For a person on a Brazilian beach, three things are missing in them **(MIP §4.1)**:

1. **No region is Brazil.** Operational WeatherBench shows the global mean, the tropics, the two
   hemispheres, North America and Europe **(v)**.
2. **No score is for waves.** Its variables are of the atmosphere **(v)**. marola forecasts sea
   conditions [@marola2026].
3. **No truth is an instrument.** Each model is scored against its own analysis **(v)**. Over an
   ocean with few observations, that favours agreement with the analysis, not with the sea
   **(MIP §4.2)**.

marola-bench is the proposal to keep the method of those benchmarks and change those three
things: Brazilian regions, wave variables, and instruments on the Brazilian coast as the truth.

## 2. What is copied, and from whom

The method is not new and this proposal does not claim it. It is the discipline of Operational
WeatherBench's methodology page **(v)**:

- **One scorer.** Every model is scored by the same code. Operational WeatherBench uses Google
  Research's WeatherBench-X, which is open under Apache-2.0 [@weatherbenchx] **(v)**.
- **A truth that is stated one time.** There, each model against its own analysis, and
  precipitation against ERA5 [@hersbach2020era5] **(v)**.
- **Fixed leads and fixed regions.**
- **A baseline that is always on the chart**: a climatology **(v)**.
- **A ranking rule that is written down.**

It also copies the licence: the dashboard and its scores are CC BY 4.0, and third-party data
keep their own terms **(v)**.

## 3. The proposal

Each item below is a requirement of MIP-0091 (its section 4.3, R1 to R20). The numbers and
names are the MIP's.

### 3.1 Truth is an observation at a point

Truth is what an instrument measured: weather stations, wave buoys and radiosondes on and off
the Brazilian coast. Each row of truth carries its instrument, its averaging, its quality flag
and its licence tier. A missing observation is a row that says "missing"; it is never replaced by
a model's value **(MIP R4)**.

Directional wave buoys have been operated off the southern Brazilian coast
[@pereira2017buoys] **(v, title only)**. They are few: the design counts at most about nine
buoys of the national programme at the same time **(MIP §4.2)**. The format of their files,
their averaging and their latency are **⚠ (MIP, "Not checked")**.

### 3.2 A licence tier on every row

Some truth is under terms that restrict redistribution. Scoring uses every tier; the published
export filters by tier; and the scorecard says which cells it cannot show **(MIP §4.2)**. A
reader can see which scores he can reproduce and which he cannot. The status of any technical
cooperation agreement is **⚠ (MIP, "Not checked")**, and none is claimed here.

### 3.3 Regions are marola's own cells

South, Southeast and Northeast, and inside them the buoy, the station and the beach. The
scorecard is a projection of those cells **(MIP §4.2)**. No page compares a score against
instruments with a score from Operational WeatherBench: the truths differ **(MIP R19)**.

### 3.4 Waves are first-class

Significant wave height, peak period and direction, with buoys as truth and their own
climatology floor. Wind rows and wave rows stay apart **(MIP R5)**.

### 3.5 Scores that the literature already defines

- A fair continuous ranked probability score with ensembles of 16 members **(MIP R2)**; the CRPS
  is a proper scoring rule [@gneiting2007scoring] **(v, title only)**.
- For waves, a threshold-weighted CRPS above 2.5 m, because the high sea is the one that hurts
  **(MIP R5)**.
- Always a climatology floor, and the reward is skill relative to it. A cell with no floor
  publishes no reward **(MIP R6)**.
- For 24-hour precipitation, Operational WeatherBench uses SEEPS **(v)**
  [@rodwell2010seeps] **(v, title only)**.

### 3.6 One fixed, versioned, public protocol

Leads every 6 hours to 360 hours; scorecard days 1, 3, 5, 7, 10 and 15; ranking on the 12Z
cycle; windows of 7, 30 and 90 days; a minimum number of cases. A change is a new version of the
protocol, never an edit **(MIP R2)**. The parameters of the decision (section 4) are committed
before the first replay: this is pre-registration **(MIP R3)**.

### 3.7 Few instruments, said honestly

With few buoys, most cells have too few cases for months. Such a cell names no winner. It
publishes the median of the admissible models and calls it model agreement. The design says:
"The fallback is the normal state", and the page must not make it look better than it is
**(MIP §8)**.

## 4. From a scoreboard to one forecast

A scoreboard ranks. A swimmer needs one number for one beach. So the design adds a forecaster on
top of the scores, and keeps it apart from them: the forecaster reads score cells and writes
nothing that the scorer reads **(MIP R1)**.

The candidates (the design calls them arms) are of two kinds, and each kind has its own
algorithm **(MIP R8)**:

- **Fetched arms** are forecasts that others publish. All of them are scored every cycle, so
  the loss of each is always seen. They are experts with full information, and the rule is
  Hedge.
- **Computed arms** are wave runs that cost compute, such as runs of the WW3 GPU port
  [@hoffmann2026ww3gpu]. Only the runs that were made are seen. They are a bandit with a budget
  [@li2010contextual] **(v, title only)**, and the rule is Thompson sampling with a knapsack.

The design is exact on one point: never a bandit over arms whose loss is observed in all cases
**(MIP R8)**. The owner's first note called the whole thing a contextual bandit (section 9);
the accepted design is narrower, and this paper follows the design.

The context of a decision is the region, the lead time, the variable and the state of ENSO, and
every feature of it is dated before the forecast was issued **(MIP R9)**.

## 5. Conservative, and safe outside the forecaster

- **A model is admitted for correctness, not for skill.** A wave run enters only with its
  regression tests passed and recorded; for the GPU port that means bit for bit **(MIP R15)**.
- **The quoted model changes slowly.** A new model replaces the incumbent only when the 95%
  interval of a paired block bootstrap is above zero, on two consecutive weekly runs
  **(MIP R10)**.
- **No live exploration.** A swimmer sees only a model that passed its gate. Exploration changes
  which computed runs are made, never what is shown **(MIP R11)**.
- **Safety reads nothing from the forecaster.** The swimming score and the warning for a
  dangerous sea do not depend on it **(MIP R12)**.
- **Disagreement is shown** beside the winner **(MIP R18)**.
- **Zero spend by construction.** Fetched forecasts are free, scoring runs on GitHub Actions,
  and computed runs use owned hardware under a budget that is a value of the protocol
  **(MIP R17)**.

## 6. Why this is open

*Closed Source: The God that Failed* argues that a result nobody can check is a result nobody
should trust [@hoffmann2026closedsource]. A benchmark is that argument at a small size: a
scoreboard with a hidden scorer asks for trust. So the design has a public chain **(MIP R20)**:

- the scorecards are CC BY 4.0, with each source's terms kept;
- each version of the protocol gets a dated data set on Zenodo, with a permanent identifier, as
  the software citation principles ask [@smith2016software] **(v)**;
- the reports and their sources are in this repository;
- the toolchain is pinned [@hoffmann2026picasso], so a score can be made again.

## 7. The order

The design's stages **(MIP §5.6)**, in order. No date is given, because the design gives none.

1. Wave truth goes into the evaluation that already runs for wind.
2. The forecaster is written and replayed on the wind record.
3. Computed wave runs enter, after their correctness gate.
4. The product shows the winner, after the gate passed.
5. The public copy, the reports and the Zenodo data sets come to this repository, after the
   owner approves the publication.

This paper is before stage 5. It publishes no score and no part of the private policy note that
the design cites.

## 8. What is not known

From the design's own lists **(MIP §8, §11, "Not checked")**:

- the format, averaging and latency of the buoy files, and the terms for each station;
- the status of any cooperation agreement, and what each partner can provide;
- which wave models are served for the Brazilian coast by the public source the design names;
- whether a skill learned in an El Niño season stays valid in a neutral year;
- which buoy is the first wave truth. The design's default is one off Santa Catarina with a
  continuous record.

From this paper:

- **Pekko beside Kyo.** How the Pekko implementation and the existing Kyo module of marola-app
  fit, and which parts of Pekko are used (the hard rule above).
- **The name.** The design calls the benchmark "marola-eval" **(MIP §11)**. The owner asked for
  this paper under the name "marola-bench". Which one the public sees is his decision.
- **The licence of this text.** This repository is MIT. The design wants CC BY 4.0 for what it
  publishes **(MIP R20)**. That is the owner's decision too.
- The claims marked "title only": the record of the paper was read, and its text was not. No
  claim here depends on a detail of one.

## 9. Where the thesis comes from

- MIP-0091, "The Marola forecaster's architecture", in `marola-dev/marola` at commit `cf7bd4f`
  [@mip0091]. Author: Hoffmann. Status: Accepted, 13 October 2026.
- Five notes of the owner in `h0ffmann/closed-source` at commit `bc1caaf`
  (<https://github.com/h0ffmann/closed-source/tree/bc1caaf/notes>), filed on 12 and 13 October
  2026: the method to copy and its gaps (`202610122356`), the forecaster as a contextual bandit
  (`202610122357`), Brazilian truth (`202610122358`), exploit in operations and explore in
  simulation (`202610122359`), and read, evaluate, adopt for forecast models (`202610130000`).

Left out on purpose: the private policy note that MIP-0091 cites, a future version of
WAVEWATCH III, and the names of the institutions behind the agreements. None has a public source.

## References

The list is [`refs.bib`](refs.bib); how each entry was checked is in
[`REFERENCES.md`](REFERENCES.md).
