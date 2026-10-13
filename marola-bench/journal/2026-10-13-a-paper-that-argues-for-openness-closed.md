---
title: "A paper that argues for openness, closed"
date: 2026-10-13
tags: [licence, rules, zenodo]
status: open
---

# A paper that argues for openness, closed

## Challenge

The owner asked for the first release of the paper, and then for the most restrictive terms for
marola-bench: all the credit his, no sharing outside two organisations, and a rule that whoever
uses it cites it. The paper has a section named "Why this is open".

## Context

Three things were already true. The texts of the research had been under CC BY 4.0 for some
hours, and a CC BY licence cannot be taken back for a copy that was taken. The accepted design
asks for scorecards under CC BY 4.0. And Zenodo keeps the licence of a version as it was when
the version was minted.

The request put the release before the new terms. In that order the first DOI would have been
minted for an open text, for ever.

## Options

- Do it in the order asked: mint, then restrict. The first version stays open.
- Put the terms in the same pull request as the release's metadata, so that the first record
  is made under them, and say so.
- Refuse, because the paper argues the other way.

## Decision

The second. The owner's aim was the restrictive terms; the order would have defeated the aim,
and a restriction can be loosened later while an open release cannot be closed. The pull request
says that the order changed and why, and the owner decides by merging it.

The paper keeps its argument and gains two notes: its section on openness is the design's
argument about the benchmark's method and scores, and the paper itself is all rights reserved.

## Result

Open. The terms, the metadata and the release tooling are in one pull request. No tag exists.
The Zenodo webhook is not switched on for this repository, so nothing can be minted until the
owner switches it on.

## Lessons

- When an order of steps defeats what the steps are for, change the order and say it aloud.
- A licence is a one-way door in one direction only: opening cannot be undone, closing can.
- A text may argue for openness and still be its author's to keep. Say which is which, in the
  text itself.
