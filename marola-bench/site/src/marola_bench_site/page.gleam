//// The HTML document around the application.

import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html
import marola_bench_site/content

pub fn document(body: Element(msg)) -> Element(msg) {
  let meta = fn(name, value) {
    html.meta([attribute.name(name), attribute.content(value)])
  }
  let stylesheet = fn(href) {
    html.link([attribute.rel("stylesheet"), attribute.href(href)])
  }
  html.html([attribute.lang("en")], [
    html.head([], [
      html.meta([attribute.charset("utf-8")]),
      meta("viewport", "width=device-width, initial-scale=1"),
      html.title([], content.title),
      meta("description", content.subtitle),
      html.link([
        attribute.rel("icon"),
        attribute.href("icons/favicon.svg"),
        attribute.type_("image/svg+xml"),
      ]),
      html.link([
        attribute.rel("preconnect"),
        attribute.href("https://fonts.googleapis.com"),
      ]),
      html.link([
        attribute.rel("preconnect"),
        attribute.href("https://fonts.gstatic.com"),
        attribute.crossorigin(""),
      ]),
      stylesheet(
        "https://fonts.googleapis.com/css2?family=Fraunces:opsz,wght@9..144,400;9..144,600;9..144,800&family=Source+Sans+3:ital,wght@0,400;0,600;1,400&family=IBM+Plex+Mono:wght@400;500&display=swap",
      ),
      stylesheet("style.css"),
      // A module script is deferred, so <body> is parsed before the app mounts on it.
      html.script([attribute.type_("module"), attribute.src("app.js")], ""),
    ]),
    html.body([], [body]),
  ])
}
