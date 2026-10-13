# marola-research. One directory is one research; `just paper <research>` renders its paper.
# The tools come from picasso's paper lab through flake.nix, pinned in flake.lock. The recipes
# use no attribute, so the `just` of Ubuntu 24.04 (1.21) reads this file.

set shell := ["bash", "-euo", "pipefail", "-c"]

default:
    @just --list

# Render <research>/paper/paper.md to <research>/<research>.pdf, with the logos of
# <research>/paper/logos.tsv above the title. A pandoc warning stops it.
paper research:
    nix develop --extra-experimental-features 'nix-command flakes' --no-update-lock-file --command just _paper {{research}}

_paper research:
    [ -f "{{research}}/paper/paper.md" ] || { echo "paper: no {{research}}/paper/paper.md" >&2; exit 1; }
    scripts/logos.sh {{research}}
    cd "{{research}}/paper" && pandoc paper.md \
      --from markdown --citeproc --bibliography refs.bib --metadata link-citations=true \
      --lua-filter ../../format/title.lua \
      --pdf-engine=xelatex --fail-if-warnings \
      -H ../../build/{{research}}/logos.tex -H ../../format/header.tex \
      -V geometry:margin=2.6cm -V fontsize=11pt -V colorlinks=true \
      -o "../{{research}}.pdf"
    @echo "paper: {{research}}/{{research}}.pdf"

# Every entry of refs.bib has a row in REFERENCES.md.
refs research:
    for k in $(grep -oE '^@[a-z]+\{[^,]+' "{{research}}/paper/refs.bib" | cut -d'{' -f2); do grep -q "\`$k\`" "{{research}}/paper/REFERENCES.md" || { echo "refs: $k has no row in REFERENCES.md" >&2; exit 1; }; done
    @echo "refs: every entry of {{research}}/paper/refs.bib has a row"
