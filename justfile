# marola-research. One directory is one research. A research is a directory at the root that has
# `paper/paper.md`. The tools come from picasso's paper lab through flake.nix, pinned in
# flake.lock. No recipe uses an attribute, so the `just` of Ubuntu 24.04 (1.21) reads this file.

set shell := ["bash", "-euo", "pipefail", "-c"]

nix := "nix develop --extra-experimental-features 'nix-command flakes' --no-update-lock-file"

default:
    @just --list

# The researches, one name on each line. CI builds its matrix from this.
researches:
    @for f in */paper/paper.md; do [ -f "$f" ] && echo "${f%%/*}"; done

# Render <research>/paper/paper.md to <research>/<research>.pdf, with the logos of
# <research>/paper/logos.tsv under the title. A pandoc warning stops it.
paper research:
    {{nix}} --command just _paper {{research}} "{{research}}/{{research}}.pdf"

# Render every research's paper.
papers:
    for r in $(just researches); do just paper "$r"; done

_paper research out:
    [ -f "{{research}}/paper/paper.md" ] || { echo "paper: no {{research}}/paper/paper.md" >&2; exit 1; }
    scripts/logos.sh {{research}}
    mkdir -p "$(dirname "{{out}}")"
    cd "{{research}}/paper" && pandoc paper.md \
      --from markdown --citeproc --bibliography refs.bib --metadata link-citations=true \
      --lua-filter ../../format/title.lua \
      --pdf-engine=xelatex --fail-if-warnings \
      -H ../../build/{{research}}/logos.tex -H ../../format/header.tex \
      -V geometry:margin=2.6cm -V fontsize=11pt -V colorlinks=true \
      -o "$OLDPWD/{{out}}"
    @echo "paper: {{out}}"

# Every entry of refs.bib has a row in REFERENCES.md.
refs research:
    for k in $(grep -oE '^@[a-z]+\{[^,]+' "{{research}}/paper/refs.bib" | cut -d'{' -f2); do grep -q "\`$k\`" "{{research}}/paper/REFERENCES.md" || { echo "refs: $k has no row in REFERENCES.md" >&2; exit 1; }; done
    @echo "refs: every entry of {{research}}/paper/refs.bib has a row"

# The committed PDF is the one its text makes: render to build/ and compare the words of the two.
current research:
    {{nix}} --command just _current {{research}}

_current research:
    [ -f "{{research}}/{{research}}.pdf" ] || { echo "current: {{research}}/{{research}}.pdf is not committed; run just paper {{research}}" >&2; exit 1; }
    just _paper {{research}} "build/{{research}}/{{research}}.pdf"
    diff <(pdftotext "{{research}}/{{research}}.pdf" -) <(pdftotext "build/{{research}}/{{research}}.pdf" -) > /dev/null \
      || { echo "current: {{research}}/{{research}}.pdf was not made from this text; run just paper {{research}} and commit it" >&2; exit 1; }
    @echo "current: {{research}}/{{research}}.pdf is the one its text makes"

# What CI runs for one research: its references, and its PDF built and compared.
check research:
    just refs {{research}}
    just current {{research}}

# Three analysers over the Markdown files: markdownlint-cli2, Vale, lychee.
# `just md-quality --online` also fetches every web link; `--self-test` gives each one a bad file.
md-quality *args:
    {{nix}} .#md --command scripts/md-quality.sh {{args}}
