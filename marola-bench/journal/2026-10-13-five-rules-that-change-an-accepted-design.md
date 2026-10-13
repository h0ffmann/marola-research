---
title: "Five rules that change an accepted design"
date: 2026-10-13
tags: [rules, mip, pekko, gcp]
status: open
---

# Five rules that change an accepted design

## Challenge

The owner gave five hard rules for the bench on the day he accepted a design that four of them
change.

## Context

The design has Scala 3 with Kyo, no cloud spend, no infrastructure as code, modules in
marola-app and a cycle on GitHub Actions. The rules ask for Pekko, GCP, Besom, a home in this
repository and a cluster that is cheap and reliable. marola's own rule is that a change of
design is written in a MIP first.

## Options

- Change the paper to match the rules and say nothing of the design.
- Refuse the rules until a MIP exists.
- State the rules as the owner's later word, say for each one what it meets, and leave the rest
  to a MIP.

## Decision

The third. The rules are the owner's and they win. The conflict is his to settle too, so it is
written down and not hidden: one paragraph for each rule, with what agrees today and what
changes.

## Result

Open. The paper and this research's page state the rules. No MIP amends the design yet. No code
exists, so nothing is built against either.

## Lessons

- A rule and a design can both be right on the day and still disagree. Say so in the same place
  where the rule is stated.
- Do not guess the part a rule leaves out: which parts of Pekko, which products of GCP, which
  SDD framework.
