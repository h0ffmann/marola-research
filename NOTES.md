# Notes and journal

Every research keeps two records beside its paper. Both are plain Markdown that Obsidian reads
when you open the research's directory as a vault.

## Notes: `<research>/notes/`

A slip box, in the Zettelkasten way: one idea in one note, linked to other notes. A paper is
written from its notes, and a claim in a paper can be followed back to a note.

1. **One idea, one note.**
2. **Own words.** Quote only what must stay exact, in quotation marks, with its source.
3. **A permanent name.** `notes/<id>-<slug>.md`. The id is the UTC time the note was made,
   `YYYYMMDDHHMM`, and it never changes.
4. **Front matter:**

   ```yaml
   ---
   id: "202610132140"
   title: "The bench is the score series"
   type: fleeting | literature | permanent
   status: unverified | partial | verified | open-question | approved
   source: "who or what the idea came from, with the date"
   tags: [bench]
   created: 2026-10-13
   ---
   ```

   - *fleeting*: an idea as it came. *literature*: what one source says. *permanent*: a claim of
     this research, built from other notes.
   - *verified*: the source was fetched and says it. For a rule or a definition of the owner, the
     source is his message, quoted with its date. *partial*: part of it was checked.
     *approved*: the owner read the note and approved it for the paper; only he gives it.
5. **Links.** Every note links to another note with `[[<id>-<slug>]]`, and `notes/index.md`
   links to every note.
6. **Truth.** Never invent a source, a quotation or a number. A note may say "I could not verify
   this".

`just notes <research>` checks the front matter, the ids and the links.

## Journal: `<research>/journal/`

One entry for each challenge met, `journal/<date>-<slug>.md`, with six headings: Challenge,
Context, Options, Decision, Result, Lessons. Negative results are entries too. An entry is
appended and not rewritten: a later entry corrects an earlier one. No secret, no private name,
no raw transcript.

## Sources

Written for this repository; nothing is copied.

- The slip box and its rules are those of h0ffmann/closed-source's `SMART_NOTE_POLICY.md` at
  `c52ff71` (<https://github.com/h0ffmann/closed-source/blob/c52ff71/SMART_NOTE_POLICY.md>),
  which follows Luhmann's slip box as Sönke Ahrens describes it in *How to Take Smart Notes*.
- The six headings of a journal entry are the Ouroboric journal format, as
  h0ffmann/closed-source's `docs/6-journal/README.md` at `c52ff71` names it. "Append, never
  rewrite" and "negative results included" are from h0ffmann/ww3-gpu's `docs/log/README.md` at
  `fe472ab`.
