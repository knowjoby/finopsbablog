---
layout: post
title: "The Snowflake Credit Overrun Nobody Saw Coming"
date: 2026-05-09 15:30:00 +0530
categories: [case-studies]
---

On a Tuesday in March, a data engineering team at a 200-person fintech opened their Snowflake console and found they'd burned through 60% of their monthly credit allocation in four days. Twenty-six days left in the billing cycle. Something had gone badly wrong, and nobody had been alerted.

Snowflake bills in credits — its internal unit of compute consumption, roughly $2–4 each depending on your contract tier. Credits are consumed by virtual warehouses, the compute clusters that run queries. An XL warehouse burns 16 credits per hour while active. Leave one running over a long weekend and you've spent $256 before anyone opens a laptop on Monday.

The culprit was a single SQL pipeline. A data analyst had built a scheduled job that joined three fact tables — roughly 800GB each — without clustering keys or date filters. Every run scanned all three tables in full. On Snowflake, cost scales with data scanned, not rows returned. A query that scans 2.4TB and returns 500 rows costs the same as one that returns 500 million. The pipeline ran every four hours: 47 credits per run, 282 per day, against a monthly allocation sized for 400 total.

Detection took ten minutes once someone looked. Snowflake's Query History tab shows credit consumption per query, sortable by cost. The offending query was at the top. The fix took a morning: adding a date filter reduced the scan from 800GB to roughly 4GB per table. Credit consumption dropped 94% overnight.

The organizational failure was the absence of Resource Monitors — Snowflake's native guardrail feature. A Resource Monitor lets you set a credit threshold per warehouse, per week, or per month, then trigger an alert or auto-suspend when it's hit. The team had none configured. Their first alert was the bill. A basic setup would have caught this: alert the data platform lead at 50% of monthly allocation; auto-suspend non-production warehouses at 80%; auto-suspend everything and escalate at 95%. Four fields in the Snowflake console. No engineering sprint required.

The reason it wasn't configured: nobody had made it somebody's job. The data platform lead assumed it was already set up. The analyst who built the pipeline had never been told cost guardrails were a concern. The gap wasn't technical — it was a conversation that hadn't happened.

The team ended the quarter 40% over their Snowflake allocation. Snowflake doesn't penalize overages — they billed at the contracted per-credit rate — but the variance required a budget reforecast that took two weeks to resolve and created friction between the data team and finance that lasted longer.

One poorly structured query. One missing configuration. Forty percent budget overrun. The math is stark enough that it's worth asking the question before it happens rather than after.

For a PO: if your product uses Snowflake, ask whether Resource Monitors are configured and what thresholds trigger alerts versus auto-suspension — if nobody can answer that quickly, they're probably not set up.
