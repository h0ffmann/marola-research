---
title: "A paper written before its design was found"
date: 2026-10-13
tags: [paper, mip, verification]
status: closed
---

# A paper written before its design was found

## Challenge

The first draft of the paper was written from five notes. An accepted design for the same thing
already existed, and it said something else on one point.

## Context

The owner asked for a proposal paper. The notes were at hand, in another repository. The design,
MIP-0091, was accepted the same day in marola's main repository, and nobody had said so in the
request. A helper agent that was sent to read marola's rules found it.

The draft called the forecaster a contextual bandit, as the first note does. The design says
that forecasts which others publish are experts with full information, and only computed runs
are a bandit.

## Options

- Keep the draft and add a note about the design.
- Write the paper again as an account of the design.

## Decision

The second. A paper gives an account of a design; it does not make one. The paper now says where
the notes and the design differ, and follows the design.

## Result

The paper was written two times. Then every reference was read against its own text, and that
reading corrected four more claims: the regions a dashboard offers are not the regions it
computes; a climatology curve that is hidden by default is not "always on the chart"; a paper
that counts ten buoys does not name their programme in its abstract; and an actor with no
supervision strategy is stopped, not restarted.

One fault of the build was found by its own check: the first PDF took a font from the machine
that built it. The fonts now come by file name from the pinned toolchain.

## Lessons

- Look for the design before the first sentence. Search the organisation, not only the
  repository you were sent to.
- A title is not a text. Four of the claims that were wrong had passed a check of titles.
- A wrong claim is cheap to fix when the log says how each claim was checked. It would have been
  expensive if "verified" had meant "seems right".
