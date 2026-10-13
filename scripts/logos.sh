#!/usr/bin/env bash
# logos: fetch the logos that a paper's first page shows, and write them for XeLaTeX.
# <research>/paper/logos.tsv lists them: name, the SVG's URL at a pinned commit, its sha256 and
# the address it links to. A logo is a trademark of its project and is not licensed here, so the
# SVG is never committed. This script downloads each one, refuses it if the hash differs,
# converts it to a PDF with rsvg-convert (a vector, so it is sharp at any size; XeLaTeX cannot
# include an SVG), and writes build/<research>/logos.tex, which defines the row of logos.
# The idea is h0ffmann/closed-source's `tools/fabric logos` (at bc1caaf); this is written here.
#   scripts/logos.sh <research>
set -euo pipefail
cd "$(git rev-parse --show-toplevel)"
research="${1:?logos: usage: scripts/logos.sh <research>}"
list="$research/paper/logos.tsv"
out="build/$research"
mkdir -p "$out/logos"
row=""
if [ -f "$list" ]; then
  while IFS=$'\t' read -r name url sha href; do
    case "$name" in "" | \#*) continue ;; esac
    svg="$out/logos/$name.svg"
    curl -fsSL --max-time 60 -o "$svg" "$url"
    got="$(sha256sum "$svg" | cut -d' ' -f1)"
    [ "$got" = "$sha" ] || { echo "logos: $name: sha256 is $got, not $sha; the file at the pinned commit changed" >&2; exit 1; }
    rsvg-convert -f pdf -o "$out/logos/$name.pdf" "$svg"
    [ -z "$row" ] || row+='\hspace{10mm}'
    row+="\\href{$href}{\\includegraphics[height=9mm]{$PWD/$out/logos/$name.pdf}}"
    echo "logos: $out/logos/$name.pdf" >&2
  done <"$list"
fi
# Empty when the research has no logos: the title page then has none.
printf '\\newcommand{\\paperlogos}{%s}\n' "$row" >"$out/logos.tex"
