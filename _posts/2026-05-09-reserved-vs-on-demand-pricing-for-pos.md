---
layout: post
title: "Reserved vs On-Demand Pricing for POs"
date: 2026-05-09 10:30:00 +0530
categories: [explainers]
---

Your platform team walks into October planning with a proposal: commit to three years of r6i.2xlarge instances in us-east-1, pay upfront, save 62% versus on-demand. The number looks good. You say yes. Eighteen months later, the product pivots. Those instances now run at 15% utilization. You're paying full freight for idle capacity, and the commitment has 18 months left on it.

That's the Reserved Instance trap — and it reliably catches teams where the PO wasn't part of the commitment conversation.

On-demand pricing is simple: you use it, you pay for it, you stop, you stop paying. AWS charges roughly $0.384 per hour for an on-demand m5.xlarge in us-east-1. You're buying flexibility. The trade-off is that flexibility costs 2–3x more per hour than committed pricing for equivalent compute. For bursty, experimental, or short-lived workloads, that premium is justified.

Reserved Instances and Savings Plans are commitments. You're telling AWS: I will use at least this much compute for the next one or three years — or at least spend a certain number of dollars per hour on compute. In exchange, AWS discounts you 30–60% depending on term length and payment method. Three-year, all-upfront gets the deepest discount. The catch: the discount runs whether or not the instance is processing real traffic.

Savings Plans are AWS's more flexible version. A Compute Savings Plan applies across instance families and regions — so if you move from m5 to c6g, or from us-east-1 to eu-west-1, the discount follows. You still commit to a minimum spend per hour, not to a specific instance type. For most teams building on EC2 or Lambda, a Compute Savings Plan is the right default commitment vehicle because it absorbs the architectural drift that Reserved Instances can't.

The decision rule is clear: reserve what's stable, run bursty or uncertain workloads on-demand. Stable means the workload has run for at least six months at consistent utilization, no major architectural changes are planned inside the commitment window, and someone has had a direct conversation with the PO about the product roadmap. That last step is what most platform teams skip — and it's what turns a sound financial decision into a liability.

Your platform team has visibility into utilization patterns. You have visibility into the roadmap. Neither view alone is sufficient. A wrong commitment on the wrong instance type in the wrong region isn't a platform team mistake in isolation — it's what happens when infrastructure planning and product planning don't share a calendar.

For a PO: before your platform team commits to any Reserved Instance or Savings Plan purchase, ask one question — what happens to this reservation if we deprioritize or sunset the workload it's attached to — and make sure the answer is documented somewhere before the purchase goes through.
