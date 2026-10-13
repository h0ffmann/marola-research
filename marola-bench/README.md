# marola-bench

A WeatherBench for Brazil: the method of the public weather benchmarks, applied to the Brazilian
coast and to ocean waves, with instruments as the truth.

- **The paper:** [`marola-bench.pdf`](marola-bench.pdf), rendered from
  [`paper/paper.md`](paper/paper.md). A proposal, v0, draft. It reports no result.
- **The design:** marola's
  [MIP-0091](https://github.com/marola-dev/marola/blob/cf7bd4f/docs/MIPs/MIP-0091-marola-forecaster-architecture.md),
  accepted on 13 October 2026. If the paper and the MIP disagree, the MIP is right.
- **The code:** none yet.

## Hard rules

The owner's rules (Hoffmann, 13 October 2026). They are not open to an agent's choice.

1. marola-bench is implemented in **Apache Pekko**, in **Scala 3**.
2. marola-bench is implemented on **GCP**, and developed with **Claude Code**, with an **SDD**
   (spec-driven development) framework.
3. Its infrastructure as code is defined with **Besom**.
4. marola-bench lives **here**, in `marola-research/marola-bench`. The first rendered paper is
   here.
5. The deployment of the Pekko cluster is **cheap** and **reliable**. Both are hard
   requirements, and so is its infrastructure on GCP.

## The bench, in the owner's words

"The bench are the score series performed by any Forecaster, Registered by an Actor." The bench
is the final goal.

- Observation points are added by hand, through a CRUD API specified in Apache Pekko and Scala.
- An actor for each point monitors it, asks the providers, and in the future asks marola's
  forecaster.
- The design principles for a cheap and reliable cluster are in section 4.4 of the paper.

Rules 1, 2, 4 and 5 change the accepted design, which has Kyo, zero cloud spend, modules in
marola-app and a cycle on GitHub Actions. The paper's section "Hard rules" says what each rule meets. A MIP must settle the
rest before code is written: which parts of Pekko, what runs on GCP and its budget, which SDD
framework, and whether the code moves here.

## Files

| File | What it is |
|---|---|
| `marola-bench.pdf` | the rendered paper |
| `paper/paper.md` | the text, with a mark on every claim |
| `paper/refs.bib` | the references |
| `paper/REFERENCES.md` | how each reference was checked |
