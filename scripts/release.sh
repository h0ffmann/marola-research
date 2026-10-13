#!/usr/bin/env bash
# release: cut the release of ONE research, as a Git tag `<research>-vMAJOR.MINOR.PATCH`.
# The tag is all that records the version. .github/workflows/release.yml then publishes a GitHub
# release with the research's PDF, and Zenodo's webhook mints the DOI from `.zenodo.json`.
#
# A DOI cannot be deleted. So only the owner cuts a release, or an agent he asked for that
# release by name. This script refuses unless everything is in place:
#   - the tree is clean, on `main`, and level with origin/main;
#   - the version is MAJOR.MINOR.PATCH and higher than the research's last tag;
#   - `.zenodo.json` at the root is the research's own `<research>/zenodo.json`, byte for byte
#     (Zenodo reads only the root file, and a repository has one);
#   - `just check <research>` passes: the references, the build, the committed PDF.
# The shape is h0ffmann/closed-source's scripts/release.sh (at c52ff71); written here.
#   scripts/release.sh <research> <version>            # tag and push
#   scripts/release.sh <research> <version> --dry-run  # every check, no tag
set -euo pipefail
cd "$(git rev-parse --show-toplevel)"
research="${1:?release: usage: scripts/release.sh <research> <MAJOR.MINOR.PATCH> [--dry-run]}"
version="${2:?release: usage: scripts/release.sh <research> <MAJOR.MINOR.PATCH> [--dry-run]}"
dry="${3:-}"
version="${version#v}"
fail() { echo "release: $1" >&2; exit 1; }
[[ "$version" =~ ^(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)$ ]] || fail "'$version' is not MAJOR.MINOR.PATCH"
[ -f "$research/paper/paper.md" ] || fail "no research '$research' (no $research/paper/paper.md)"
tag="$research-v$version"

git fetch -q --tags origin main
[ -z "$(git status --porcelain)" ] || fail "the tree is not clean"
[ "$(git rev-parse --abbrev-ref HEAD)" = main ] || fail "not on main"
[ "$(git rev-parse HEAD)" = "$(git rev-parse origin/main)" ] || fail "main is not level with origin/main"
! git rev-parse -q --verify "refs/tags/$tag" >/dev/null || fail "$tag exists"
last="$(git tag -l "$research-v*" --sort=-v:refname | head -1)"
if [ -n "$last" ]; then
  [ "$(printf '%s\n%s\n' "${last#"$research"-v}" "$version" | sort -V | tail -1)" = "$version" ] || fail "$version is not higher than $last"
fi
[ -f "$research/zenodo.json" ] || fail "$research/zenodo.json is missing: the record's metadata"
cmp -s .zenodo.json "$research/zenodo.json" \
  || fail ".zenodo.json at the root is not $research/zenodo.json. Zenodo reads the root file: copy it in a pull request first"
python3 -c 'import json,sys; d=json.load(open(".zenodo.json")); bad=[k for k in ("version","publication_date","doi") if k in d]; sys.exit("release: .zenodo.json sets "+", ".join(bad)+"; Zenodo sets them" if bad else 0)'
just check "$research"

echo "release: $tag at $(git log -1 --format='%h %s')${last:+ (previous: $last)}" >&2
if [ "$dry" = --dry-run ]; then echo "release: dry run; no tag was made" >&2; exit 0; fi
git tag -a "$tag" -m "$research v$version"
git push origin "$tag"
echo "release: pushed $tag; release.yml publishes it and Zenodo mints the DOI a few minutes later." >&2
