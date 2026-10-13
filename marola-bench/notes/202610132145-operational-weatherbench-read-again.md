---
id: "202610132145"
title: "Operational WeatherBench, read again"
type: literature
status: verified
source: "Brightband, Operational WeatherBench: Methodology, https://owb.brightband.com/methodology, read 2026-10-13"
tags: [benchmark, owb]
created: 2026-10-13
---

# Operational WeatherBench, read again

A second reading of the page corrected two things that the first draft of the paper said.

- **Regions.** The selector "offers the global mean plus the tropics, the northern and southern
  hemispheres, North America, and Europe". But "Scores are computed for a wider set of regions
  than the dashboard exposes". So the true claim is that no South American region is offered,
  not that none is computed.
- **Climatology.** "A plain climatology forecast is scored as a reference 'no-skill' curve", and
  the page adds that the curve is hidden by default. The draft had said "always on the chart".

The first reading is the owner's note in h0ffmann/closed-source,
<https://github.com/h0ffmann/closed-source/blob/c52ff71/notes/202610122356-operational-weatherbench.md>.

What the bench adds to this method: [[202610132140-the-bench-is-the-score-series]].
