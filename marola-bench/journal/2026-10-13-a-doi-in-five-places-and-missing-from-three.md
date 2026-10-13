---
title: "A DOI in five places and missing from three"
date: 2026-10-13
tags: [doi, citation, checks]
status: closed
---

# A DOI in five places and missing from three

## Challenge

After the first release the owner said: the DOI is not properly propagated.

## Context

The pull request that followed the release wrote the DOI into the research's page, the index,
the terms and the rules for agents. It did not write it into the paper, the rendered PDF or the
website, and there was no citation file for GitHub's "Cite this repository". A reader who
opened the PDF or the site could not cite the work from what was in front of him.

Nothing checked it. The places were a list in somebody's head.

## Options

- Add the DOI to the three places by hand.
- Add it, and make a check that fails when a place is missing.

## Decision

The second, as the owner's profile repository does. `<research>/doi.tsv` is the one place where
the DOIs are written. `just doi <research>` fails unless the DOI is in the index, the research's
page, the terms, the rules, the citation file, the paper and its PDF. The site reads the same
table when it is built, and a test checks that the DOI is on the page.

## Result

The first run of the check failed on two places, the paper and its PDF, which is what it is for.
Both have the DOI now, with the citation file and the site.

## Lessons

- A list of places that must agree is a check that has not been written yet.
- The first thing a new check should do is fail on the state that made you write it.
