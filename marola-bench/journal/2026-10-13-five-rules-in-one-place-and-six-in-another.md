---
title: "Five rules in one place and six in another"
date: 2026-10-13
tags: [numbers, skill, checks]
status: closed
---

# Five rules in one place and six in another

## Challenge

The paper said "six hard rules" in its body and "five hard rules" in its abstract, in its list of
what is not known, in its easy Portuguese abstract, on the website and in a note.

## Context

The sixth rule came after the abstract was written. The pull request that added it changed the
places it knew, and no check compares a number that is written in more than one place. Every
check of the repository passed.

It was found the same day, by one step of the skill that had just been added to it: list each
number that is written in more than one place, and compare. That step was taken from other
people's skills for paper quality (`.claude/skills/ouro-paper/REA.md`), and this paper was the
first text it was tried on.

## Options

- Fix the five places.
- Fix them, and write a check that counts.

## Decision

The first, for now. A count of rules is one number among many, and a check for each number is a
check for none. The step stays a step that a writer does by hand, with the list in the pull
request. If the same kind of fault comes back, that is the reason to write the check.

## Result

Six, in every place. The note keeps its first file name and says why.

## Lessons

- A number that is written twice will be changed once.
- A step borrowed from somebody else's skill earns its place when it finds a fault here. This
  one did, on its first use.
