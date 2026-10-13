---
id: "202610132147"
title: "Zero spend meets a paid cloud"
type: permanent
status: open-question
source: "MIP-0091 at marola-dev/marola cf7bd4f, header and R17; the owner's hard rule 2, 2026-10-13"
tags: [gcp, cost, mip]
created: 2026-10-13
---

# Zero spend meets a paid cloud

MIP-0091 says "Zero cloud spend" and "Zero spend by construction ... Nothing provisions". Hard
rule 2 puts the bench on GCP, and rule 5 asks that it be cheap. A cluster that runs all the time
on a paid cloud is not zero.

What can be kept from the design: a budget that is a value of the protocol, written before
anything is deployed, and a switch that makes the system do less before it costs more.

**Open:** what runs on GCP and what stays on GitHub Actions and on owned hardware; the budget in
money; which GCP products. One answer to "cheap" is in
[[202610132144-reliability-is-what-makes-it-cheap]]. The rules are in
[[202610132141-five-hard-rules]].
