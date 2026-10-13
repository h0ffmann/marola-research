---
id: "202610132142"
title: "An actor for each observation point"
type: permanent
status: verified
source: "Matheus Hoffmann, Claude Code session, 2026-10-13"
tags: [actors, pekko, points]
created: 2026-10-13
---

# An actor for each observation point

Observation points are added by hand, through a CRUD API specified in Apache Pekko and Scala.
"Actors should monitor observation points, ask providers, ask marola-forecaster in the future."

By hand, because a point is not only a position: it has an instrument, an averaging, a quality
flag and a licence tier, and a person must read the terms.

It is a change of shape. The accepted design runs a cycle every four hours that scores
everything. Here each point keeps its own time. The scores and their rules stay the same.

What the actors make: [[202610132140-the-bench-is-the-score-series]].

**Status: verified** that the owner said it. Which parts of Pekko carry it is open.
