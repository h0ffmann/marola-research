# Skills

Two kinds of skill are used here, and they are kept apart.

## Written here

| Skill | What it is for |
|---|---|
| [`ouro-paper`](ouro-paper/SKILL.md) | how a paper of this repository is written, checked and released. [`ouro-paper/REA.md`](ouro-paper/REA.md) says which ideas came from other people's skills |

## Other people's, by link

**No file of another person's skill is in this repository.** The owner's rule (13 October 2026):
the library "should be accessible as is using vendored skills. I don't want to import their
source code directly from this repository. Use smart links".

So a skill of somebody else is *vendored by link*:

- [`skills.lock`](skills.lock) pins it: the repository, the commit, the path, the Git tree of
  its directory and the Git blob of its `SKILL.md`. A link with a commit in it always opens the
  same text, so an index or a reader gets exactly what was read, and nothing has to be copied.
- `just skills fetch` brings the pinned directories into `.claude/skills/.vendor/`, which Git
  ignores. There a skill can be used as it is, with its scripts and its reference files. It is a
  copy on one machine, under its own licence; it is never committed.
- `just skills check` asks GitHub that each pinned file is still the one `skills.lock` names.
  CI runs it with the link check.

### Scientific Agent Skills, by K-Dense

> Kassis, T., Agarwal, V., He, Y., Patel, D., & Brueckner, A. M. (2026). *Scientific Agent
> Skills: A Library of Procedural Knowledge for Research Agents*. arXiv:2609.00065.
> <https://arxiv.org/abs/2609.00065>

The library is [K-Dense-AI/scientific-agent-skills](https://github.com/K-Dense-AI/scientific-agent-skills)
(it was `claude-scientific-skills`). Its licence is MIT, "Copyright (c) 2025 K-Dense Inc."; each
skill names its own licence in its frontmatter, and the six below say MIT. Its authors ask that a
work which one of its skills materially contributed to cites the paper above. This page, the
skill's sources and the first paper of this repository do.

Read at commit [`a1043ef`](https://github.com/K-Dense-AI/scientific-agent-skills/tree/a1043ef544e3a100c28e70a736b6cf32554d0677),
13 October 2026:

| Skill, pinned | What `ouro-paper` learned from it | Licence | `SKILL.md` blob |
|---|---|---|---|
| [`scientific-writing`](https://github.com/K-Dense-AI/scientific-agent-skills/blob/a1043ef544e3a100c28e70a736b6cf32554d0677/skills/scientific-writing/SKILL.md) | the evidence record: no claim without a recorded source; unresolved items stay listed | MIT | `446993fcd471` |
| [`peer-review`](https://github.com/K-Dense-AI/scientific-agent-skills/blob/a1043ef544e3a100c28e70a736b6cf32554d0677/skills/peer-review/SKILL.md) | a claim-to-evidence matrix, and comments with a fixed shape | MIT | `d4f3c3e3b5c1` |
| [`citation-management`](https://github.com/K-Dense-AI/scientific-agent-skills/blob/a1043ef544e3a100c28e70a736b6cf32554d0677/skills/citation-management/SKILL.md) | metadata from a registry, never invented; a preprint may have a published version | MIT | `b63b589d4d42` |
| [`literature-review`](https://github.com/K-Dense-AI/scientific-agent-skills/blob/a1043ef544e3a100c28e70a736b6cf32554d0677/skills/literature-review/SKILL.md) | a search that can be made again; identity, corrections and retractions of a reference | MIT | `5178dce6419c` |
| [`scientific-critical-thinking`](https://github.com/K-Dense-AI/scientific-agent-skills/blob/a1043ef544e3a100c28e70a736b6cf32554d0677/skills/scientific-critical-thinking/SKILL.md) | the kind of a claim; "not reported" is not "not done" | MIT | `2a2fc151b5b1` |
| [`statistical-analysis`](https://github.com/K-Dense-AI/scientific-agent-skills/blob/a1043ef544e3a100c28e70a736b6cf32554d0677/skills/statistical-analysis/SKILL.md) | the minimum to report for a statistic | MIT | `4ea7453a12e6` |

To use the whole library and not only these six, install it the way its own README says, and
not from here:

```sh
gh skill install K-Dense-AI/scientific-agent-skills            # browse and choose
gh skill install K-Dense-AI/scientific-agent-skills peer-review
npx skills add K-Dense-AI/scientific-agent-skills
```

### Rules

1. **Never copy.** Do not paste a file, a checklist or a script of a pinned skill into a tracked
   file of this repository. An idea is taken in our own words and credited in
   [`ouro-paper/REA.md`](ouro-paper/REA.md).
2. **Cite at the commit.** A link to a pinned skill has its commit in it.
3. **A new pin is a row** in `skills.lock`, with the licence read from the skill's own file, and
   a line in this page. To move a pin, read the skill again at the new commit first.
4. **A skill with no licence is cited and not fetched.**
