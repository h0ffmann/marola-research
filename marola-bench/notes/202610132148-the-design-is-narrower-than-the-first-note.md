---
id: "202610132148"
title: "The design is narrower than the first note"
type: permanent
status: verified
source: "MIP-0091 at marola-dev/marola cf7bd4f, R8; the owner's note 202610122357 in h0ffmann/closed-source at c52ff71"
tags: [bandit, hedge, mip]
created: 2026-10-13
---

# The design is narrower than the first note

The owner's first note calls the forecaster "a contextual bandit over forecast models". The
design he accepted a day later says: "Never a bandit over arms whose loss is observed in all
cases."

The reason is what is seen. A forecast that others publish is scored every cycle, so its loss
is always seen: that is prediction with experts, and the rule is Hedge. Only a wave run that
costs compute is a bandit, because only the runs that were made are seen.

The paper follows the design. A paper gives an account of a design; it does not make one.

How the scores are kept either way: [[202610132140-the-bench-is-the-score-series]].
