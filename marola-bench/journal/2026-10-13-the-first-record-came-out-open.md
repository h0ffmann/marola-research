---
title: "The first record came out open"
date: 2026-10-13
tags: [zenodo, licence, release]
status: open
---

# The first record came out open

## Challenge

The first release of marola-bench was meant to make a closed record on Zenodo, under "all rights
reserved". The record that Zenodo made is open, and it names the MIT licence.

## Context

The owner asked for the mint, from his fork, where Zenodo's switch is on. The metadata file,
`.zenodo.json`, said `"access_right": "closed"` and named no licence. The pull request that
carried it had said, under "Not checked": that Zenodo accepts closed access from a webhook.

Read from Zenodo's own record of the version, minutes after the release: the files are public,
and the record's rights are `mit`. Zenodo did not apply the access field to a GitHub release.
With no licence in the file, it took the one that GitHub shows for the repository, and the
fork's default branch still held the MIT `LICENSE` that the repository started with.

A record cannot be deleted. Its owner can restrict its files and change its licence on
zenodo.org; nobody else can, and the agent that cut the release has no access to that account.

## Options

- Leave it, and write the DOI into the pages as if nothing had happened.
- Say it at the top of the pull request, ask the owner to restrict the record, and write down
  what the next release must do.

## Decision

The second. The pull request leads with it. The metadata now names a licence, `other-closed`
("Other (Not Open)" in Zenodo's list), so that the next version does not take the repository's.
That field was not tested either: testing it makes a DOI.

## Result

Open. DOI of the work: 10.5281/zenodo.23352633. DOI of v0.1.0: 10.5281/zenodo.23352634. The
record is open under MIT until the owner edits it. Whoever downloaded the archive in that time
has a copy under the terms the record showed.

## Lessons

- "Not checked" beside a step that cannot be undone is not a warning. It is a reason to stop
  and test on something that can be thrown away.
- Zenodo's webhook reads the licence that GitHub shows for the default branch. Change the
  licence on the default branch first, then release.
- A field in a metadata file is a request. Read the record back, at once, and compare.
