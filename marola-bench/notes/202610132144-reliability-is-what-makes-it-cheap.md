---
id: "202610132144"
title: "Reliability is what makes it cheap"
type: permanent
status: partial
source: "Claude, from the owner's two hard requirements (cheap, reliable), 2026-10-13; Google Cloud, Spot VMs, https://cloud.google.com/compute/docs/instances/spot, read 2026-10-13"
tags: [reactive, gcp, cost]
created: 2026-10-13
---

# Reliability is what makes it cheap

The owner asked for a deployment that is cheap and reliable, as two hard requirements. They are
one piece of work.

Cheap capacity on a cloud is the kind that can be taken away. Google's page says: "Spot VMs have
significant discounts, but Compute Engine might preemptively stop or delete (preempt) Spot VMs
to reclaim the capacity at any time." A cluster that survives the loss of any node can use that
capacity. So: first survive the loss of a node, then buy the cheap nodes.

What it needs from the actors of [[202610132142-an-actor-for-each-observation-point]]: state
that is stored as events, writes that can be repeated, and an idle actor that is stopped.

**Status: partial.** The sentence of Google's page was read. That the saving is large enough for
this cluster was not: nothing has been priced, and no cluster exists.
