---
id: "202610132141"
title: "Five hard rules"
type: permanent
status: verified
source: "Matheus Hoffmann, Claude Code session, 2026-10-13, four messages"
tags: [rules, pekko, gcp, besom]
created: 2026-10-13
---

# Five hard rules

1. Apache Pekko, Scala 3.
2. GCP, developed with Claude Code, with an SDD framework.
3. Infrastructure as code with Besom.
4. It lives in `marola-research/marola-bench`.
5. The deployment of the cluster is cheap and reliable.

Four of the five change the accepted design, MIP-0091: it has Kyo, zero cloud spend, modules in
marola-app and a cycle on GitHub Actions. The rules are the later word. A MIP must say how the
two meet: [[202610132147-zero-spend-meets-a-paid-cloud]].

Rule 2 does not name the framework. The candidates are listed in the pull request that added the
paper (marola-dev/marola-research#2).

**Status: verified** that the owner gave each rule, on that date.
