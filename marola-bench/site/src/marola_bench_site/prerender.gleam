//// `gleam run -m marola_bench_site/prerender > dist/index.html`: the first render, which the
//// client then takes over in place, so the page reads without JavaScript.

import gleam/io
import lustre/element
import marola_bench_site/app
import marola_bench_site/page

pub fn main() -> Nil {
  app.initial()
  |> app.view
  |> page.document
  |> element.to_document_string
  |> io.println
}
