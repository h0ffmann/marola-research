# REA: other skills for paper quality

Read, Evaluate, Adopt, on the agent skills that other people wrote for the quality of a
scientific or technical paper. It is why `SKILL.md` has the steps it has, and it is the credit
for every idea that came from somewhere else.

**Date of record: 13 October 2026.** Each repository below was read at the commit named, which
was the head of its default branch that day. Its licence is what its own licence file says, read
from the file, not from a badge.

## The rule that was followed

1. **Read the licence first.** It decides what may be taken: text, or only an idea.
2. **Take ideas, in our own words.** Nothing of any of these skills is copied into this
   repository: no sentence, no checklist, no script. Each idea is credited to its source at a
   commit.
3. **Evaluate on our own terms.** An idea is adopted when it would have caught a fault that this
   repository really had (`marola-bench/journal/`), or when it closes a gap that the skill had.
   An idea that fits another kind of paper is cited and left.
4. **Say what was not read.**

## What was read

Twelve skills in seven repositories. "Read by" a helper agent means: an agent of the same session
read the files in a shallow clone and returned each rule as an exact quotation with its path; the
writer of this page checked each repository's licence and commit himself and did not open the
skill files a second time.

| Repository, at commit | Licence, from its file | Skills read | May we |
|---|---|---|---|
| [K-Dense-AI/scientific-agent-skills](https://github.com/K-Dense-AI/scientific-agent-skills/tree/a1043ef544e3a100c28e70a736b6cf32554d0677) at `a1043ef` (it was `claude-scientific-skills`; GitHub redirects) | MIT, "Copyright (c) 2025 K-Dense Inc."; each skill names its own licence, and these six say MIT | `skills/scientific-writing`, `skills/peer-review`, `skills/citation-management`, `skills/literature-review`, `skills/scientific-critical-thinking`, `skills/statistical-analysis` | adapt, with the notice. We took ideas only |
| [Imbad0202/academic-research-skills](https://github.com/Imbad0202/academic-research-skills/tree/a3ef8c79d888b90aaaaecce7f42fbc3fd082d5ab) at `a3ef8c7` | CC BY-NC 4.0, "Copyright (c) 2026 Cheng-I Wu". GitHub detects none | `academic-pipeline`, `academic-paper`, `academic-paper-reviewer` | adapt for non-commercial use only. So: ideas only |
| [SNL-UCSB/paper-writing-skill](https://github.com/SNL-UCSB/paper-writing-skill/tree/676f8520bba54208eb4fe1d41620e365d9af6a24) at `676f852` | MIT, "Copyright (c) 2026 Arpit Gupta" | `SKILL.md` (`paper-writing`) and its red-team protocol | adapt, with the notice. Ideas only |
| [claesbackman/AI-research-feedback](https://github.com/claesbackman/AI-research-feedback/tree/d12975697b8603ec4dd6f0e922fcc1251d5355d1) at `d129756` | MIT, "Copyright (c) 2026 claesbackman" | `Skills/review-paper`, `Skills/review-paper-checks`, `Skills/review-paper-code` | adapt, with the notice. Ideas only |
| [blader/humanizer](https://github.com/blader/humanizer/tree/225a6f39ac85f76ee48dbad772ea4abe4ed6c9d8) at `225a6f3` | MIT, "Copyright (c) 2025 Siqi Chen" | `SKILL.md` (`humanizer`) | adapt, with the notice. Ideas only |
| [obra/superpowers](https://github.com/obra/superpowers/tree/bb92a77741419a4ab5f06e711a283343f1ada0c3) at `bb92a77` | MIT, "Copyright (c) 2025 Jesse Vincent" | `skills/verification-before-completion`, `skills/writing-skills` | adapt, with the notice. Ideas only |
| [anthropics/skills](https://github.com/anthropics/skills/tree/dbd4588f9e1033efb41dad4bef2f7947c8993d44) at `dbd4588` | no licence file at the root. `skills/skill-creator` has Apache-2.0; `skills/doc-coauthoring` has no licence | `skills/doc-coauthoring`, `skills/skill-creator` | `doc-coauthoring`: cite only. `skill-creator`: adapt, with the notice. Ideas only |

K-Dense asks that work which one of its skills "materially contributed to" cite its paper:
Kassis, Agarwal, He, Patel and Brueckner, *Scientific Agent Skills: A Library of Procedural
Knowledge for Research Agents*, arXiv:2609.00065 (its record was read: published 30 August
2026). This page is that citation, for this skill. The six skills are also pinned in
[`../skills.lock`](../skills.lock), so that they can be used as they are, by link
([`../README.md`](../README.md)). And the first paper of this repository cites it: one step that
came from those skills, the comparison of a number in every place it is written, found a fault
in that paper on its first use (`marola-bench/journal/`).

## What each one says, and what was adopted

Each quotation is exact, from the file named, at the commit above.

| The idea | Where it is said | Adopted in `SKILL.md` as |
|---|---|---|
| A snippet, a summary, memory, or another work's bibliography may help find a source and does not verify a claim | K-Dense `scientific-writing`: "Search snippets, generated summaries, memory, and another work's bibliography may aid discovery but do not verify a claim." Imbad0202 `academic-pipeline`: "NEVER rely on AI memory/knowledge to verify a reference." | already a hard rule; now it names what does not count |
| A DOI that resolves can still be the wrong work; check identity, corrections and retractions | K-Dense `literature-review`: "A registered DOI can still identify the wrong work; check identity, claim support, corrections, and retractions" | step 3, the three checks of a reference |
| A cited preprint may have a published version | K-Dense `citation-management`, its list of pitfalls | step 3 |
| A reference has one of three verdicts, and doubt is a failure | Imbad0202 `academic-pipeline`: "Gray zone = FAIL. If you cannot confirm it exists, it does not go in the report" | step 3: verified, mismatch, not found |
| Keep the search itself: where, with what words, on what day, how many | K-Dense `literature-review`: "a review that cannot reproduce its own search is not systematic" | "Looked for" in `REFERENCES.md` gains the query and the date |
| Type a claim before you check it | K-Dense `scientific-critical-thinking`: classify the claim as descriptive, predictive or causal | step 2, with two kinds of our own: a design choice, and a claim of being first |
| "We are the first" is its own kind of claim, and nobody can check it by reading the paper | Bäckman `review-paper-checks`: "Flag every such claim as an *unverified priority assertion*" | step 2, and a Vale warning (`research.PriorityClaims`) |
| "Not reported" is not "not done" | K-Dense `scientific-critical-thinking`: "Keep missing reporting separate from evidence that a procedure was not performed." | hard rule on marks |
| A number that is written in two places is the same in both | K-Dense `scientific-writing`: a manifest of numbers reconciled between methods and results. Bäckman `review-paper-checks`: internal consistency | step 7, the numbers |
| A check mark is good only for the pass in which the check ran, and only for the words it was made for | superpowers `verification-before-completion`: "If you haven't run the verification command in this message, you cannot claim it passes." K-Dense `scientific-writing`: a hash of a claim's text bound to its evidence | hard rule: a reworded claim loses its mark |
| "Audited" with no output is not an audit | SNL-UCSB `paper-writing`: "\"Audited\" without pasted output is INVALID." | step 9: the pull request pastes what each check printed |
| A reviewer who has not seen the author's own opinion of the text | SNL-UCSB, its red-team protocol; Imbad0202 `academic-paper-reviewer`, seats blind to each other | step 8, the cold reader |
| A finding quotes the text it is about | Bäckman `review-paper-checks`: "Do not report an issue you cannot quote." K-Dense `peer-review`: location, observation, criterion, why it matters, requested action | step 8, the shape of a finding |
| Few findings that are certain, not many that are not | Bäckman: "It is better to return five issues you are certain of than thirty you are not." | step 8 |
| Ask a reader that has only the document, and see what it answers | Anthropic `doc-coauthoring`: "For each question, invoke a sub-agent with just the document content and the question." (no licence: cited, nothing taken but the idea) | step 8, the reader's questions |
| Write the opening again when the evidence exists | SNL-UCSB `paper-writing`: a draft-0 introduction, and a final one after the evaluation | step 6: the summary is written last |
| A pass for style must not change a fact | humanizer: "Do not add a fact, name, number, date, quote, or citation unless it comes from the source or the user." | step 7: after any edit for style, the facts are compared |
| Mechanical faults and editorial judgement are two jobs | Bäckman, two skills: `review-paper-checks` "Reports fixable errors, not editorial judgment." | steps 7 and 8 are apart |
| A skill is tested against the same task done without it | superpowers `writing-skills`: "If you didn't watch an agent fail without the skill, you don't know if the skill teaches the right thing." Anthropic `skill-creator`: one run with the skill and one without | `evals/evals.json`: three cases, written and **not yet run** |

## Read, and left

| The idea | Where | Why it is not adopted |
|---|---|---|
| Reporting guidelines by study design: CONSORT, PRISMA, STROBE, ARRIVE and others | K-Dense `scientific-writing`, `peer-review` | no paper here reports a trial or a review yet. `SKILL.md` says to name the guideline when one does |
| A minimum set for every statistic: n, exact p, effect size with its interval | K-Dense `statistical-analysis` | no paper here has a statistic yet. Kept as one line for when one does |
| A panel of five reviewers with personas, and a devil's advocate | Imbad0202 `academic-paper-reviewer` | one cold reader is what this repository can run and check today |
| Authorship roles, AI-use disclosure and confidentiality gates for a journal submission | K-Dense `scientific-writing` | a submission is not a step here yet. The author line is the owner's |
| Style rules as numbered ids that a grep can find | SNL-UCSB `paper-writing` | Vale already does it here, with named rules |
| Remove the text that tells how the document was made | humanizer, its pattern 25 | this is the one idea that pulls against ours. A mark on a claim *is* an account of how it was checked, and it is the point. The answer taken from it: a mark is short, and the account is in `REFERENCES.md`, not in the sentence |

## Found, and not read

Metadata from a search only; nothing is taken from them: Master-cai/Research-Paper-Writing-Skills
(MIT), serenakeyitan/citation-check-skill (MIT), yunshenwuchuxun/latex-paper-skills (MIT),
SNL-UCSB/literature-survey-skill (MIT), and three skills for ASD-STE100. Three "awesome" lists of
skills were searched by their README text and gave no source beyond K-Dense and humanizer.
