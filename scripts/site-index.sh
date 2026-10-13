#!/usr/bin/env bash
# site-index: the first page of the published site, which lists every research that has a site.
# GitHub Pages gives one site to a repository, so each research's site is one directory of it:
# <pages>/<research>/. This writes <pages>/index.html from each research's paper front matter.
#   scripts/site-index.sh <pages directory>
set -euo pipefail
cd "$(git rev-parse --show-toplevel)"
out="${1:?site-index: usage: scripts/site-index.sh <pages directory>}"
mkdir -p "$out"
esc() { sed -e 's/&/\&amp;/g' -e 's/</\&lt;/g' -e 's/>/\&gt;/g'; }
field() { awk -v k="$2" 'NR==1 && $0=="---" {on=1; next} on && $0=="---" {exit} on && index($0, k": ")==1 {sub("^"k": ", ""); gsub(/^"|"$/, ""); print; exit}' "$1"; }
items=""
for f in */site/gleam.toml; do
  [ -f "$f" ] || continue
  r="${f%%/*}"
  title="$(field "$r/paper/paper.md" title | esc)"
  version="$(field "$r/paper/paper.md" version | esc)"
  items+="<li><a href=\"$r/\">${title:-$r}</a><span>$version</span></li>"
done
cat >"$out/index.html" <<HTML
<!doctype html>
<html lang="en">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>marola research</title>
<meta name="description" content="The science of marola: one page for each research.">
<style>
  :root { color-scheme: light dark; }
  body { margin: 0; background: #0B2A3F; color: #EAF2F5; font: 400 19px/1.55 'Source Sans 3', 'Segoe UI', system-ui, sans-serif; }
  main { max-width: 860px; margin: 0 auto; padding: 72px 24px; }
  h1 { margin: 0; font: 800 clamp(44px, 9vw, 96px)/.95 Georgia, serif; letter-spacing: -.03em; color: #fff; }
  p { max-width: 34em; color: rgba(234, 242, 245, .86); }
  ul { list-style: none; margin: 40px 0 0; padding: 0; }
  li { border-top: 1px solid rgba(234, 242, 245, .22); padding: 18px 0; display: grid; gap: 4px; }
  a { color: #fff; font: 600 clamp(22px, 3.4vw, 30px)/1.2 Georgia, serif; text-decoration: underline; text-decoration-color: #F2B705; text-decoration-thickness: 2px; text-underline-offset: 4px; }
  a:focus-visible { outline: 3px solid #F2B705; outline-offset: 3px; }
  span { font: 400 14px/1.4 ui-monospace, monospace; color: rgba(234, 242, 245, .72); }
  footer { margin-top: 48px; font-size: 16px; }
  footer a { font: inherit; color: inherit; }
</style>
<main>
  <h1>marola research</h1>
  <p>The science of marola. One page for each research: its paper, its notes, its journal, and how each claim was checked.</p>
  <ul>$items</ul>
  <footer><a href="https://github.com/marola-dev/marola-research">The repository on GitHub</a></footer>
</main>
</html>
HTML
echo "site-index: $out/index.html" >&2
