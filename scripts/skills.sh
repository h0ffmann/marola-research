#!/usr/bin/env bash
# skills: other people's skills, used by link (.claude/skills/skills.lock, .claude/skills/README.md).
# No file of theirs is in this repository. This script lists the pins, checks them, and can bring
# the pinned directories to one machine, into a directory that Git ignores.
#   scripts/skills.sh list     # each pin, with the link that always opens the same text
#   scripts/skills.sh check    # GitHub still has, at each commit, the SKILL.md that the lock names
#   scripts/skills.sh fetch    # the pinned directories -> .claude/skills/.vendor/<name>/ (ignored)
# The lock is the idea of marola-dev/marola's and ouroboric-dev/havamal's skills.lock, with one
# difference: there the pinned files are also copied into the repository; here they are not.
set -euo pipefail
cd "$(git rev-parse --show-toplevel)"
lock=.claude/skills/skills.lock
vendor=.claude/skills/.vendor
rows() { grep -v '^#' "$lock" | grep -v '^$'; }
api() { # one GET of GitHub's API, with a token when there is one (CI), so the limit is not met
  if [ -n "${GITHUB_TOKEN:-}" ]; then curl -fsS --max-time 60 -H "Authorization: Bearer $GITHUB_TOKEN" -H 'User-Agent: marola-research' "$1"
  else curl -fsS --max-time 60 -H 'User-Agent: marola-research' "$1"; fi
}
case "${1:-list}" in
  list)
    while IFS=$'\t' read -r name upstream commit path _tree _blob licence; do
      echo "$name  ($licence)  https://github.com/$upstream/blob/$commit/$path/SKILL.md"
    done < <(rows)
    ;;
  check)
    bad=0; n=0
    while IFS=$'\t' read -r name upstream commit path _tree blob _licence; do
      n=$((n + 1))
      got="$(api "https://api.github.com/repos/$upstream/contents/$path/SKILL.md?ref=$commit" | python3 -c 'import json,sys; print(json.load(sys.stdin).get("sha",""))' || true)"
      [ "$got" = "$blob" ] || { echo "skills: $name: at $commit GitHub has SKILL.md ${got:-nothing}, the lock says $blob" >&2; bad=1; }
    done < <(rows)
    [ "$bad" = 0 ] || exit 1
    echo "skills: $n pins, each SKILL.md is the one the lock names" >&2
    ;;
  fetch)
    mkdir -p "$vendor"
    for upstream in $(rows | cut -f2 | sort -u); do
      commit="$(rows | awk -F'\t' -v u="$upstream" '$2 == u { print $3; exit }')"
      tmp="$(mktemp -d)"
      git clone -q --filter=blob:none --no-checkout "https://github.com/$upstream.git" "$tmp"
      git -C "$tmp" sparse-checkout init --cone >/dev/null
      # shellcheck disable=SC2046
      git -C "$tmp" sparse-checkout set $(rows | awk -F'\t' -v u="$upstream" '$2 == u { print $4 }') >/dev/null
      git -C "$tmp" checkout -q "$commit"
      while IFS=$'\t' read -r name up _commit path tree _blob _licence; do
        [ "$up" = "$upstream" ] || continue
        got="$(git -C "$tmp" rev-parse "$commit:$path")"
        [ "$got" = "$tree" ] || { echo "skills: $name: the tree is $got, the lock says $tree" >&2; rm -rf "$tmp"; exit 1; }
        rm -rf "${vendor:?}/$name"; cp -R "$tmp/$path" "$vendor/$name"
        echo "skills: $vendor/$name  (from $upstream at ${commit:0:7})" >&2
      done < <(rows)
      # The licence of the library travels with what was fetched.
      for f in LICENSE LICENSE.md; do [ -f "$tmp/$f" ] && cp "$tmp/$f" "$vendor/LICENSE.$(basename "$upstream").md"; done
      rm -rf "$tmp"
    done
    echo "skills: fetched into $vendor, which Git ignores. Never commit it." >&2
    ;;
  *) echo "skills: usage: scripts/skills.sh [list | check | fetch]" >&2; exit 1 ;;
esac
