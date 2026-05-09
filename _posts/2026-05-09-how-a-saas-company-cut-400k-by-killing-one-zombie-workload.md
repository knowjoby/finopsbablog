---
layout: post
title: "How a SaaS Company Cut $400k by Killing One Zombie Workload"
date: 2026-05-09 13:00:00 +0530
categories: [case-studies]
---

In February 2023, a FinOps team at a B2B SaaS company ran a routine utilization audit and found an EC2 cluster that had been running continuously since October 2019. CPU utilization: averaging 2.1% over the prior 90 days. No active traffic. No owner listed in the cost tags. Monthly bill: $34,200.

That's $410,400 over the life of the resource — though the team caught it before the next $400k rolled through. When they shut it down, no alerts fired. No one called asking what happened. Nobody noticed, because nobody was using it.

Zombie workloads — infrastructure that runs but serves no active purpose — accumulate in predictable ways. A project kicks off, gets deprioritized, and the team moves on without decommissioning anything. A proof-of-concept environment spun up for a sales demo never gets cleaned up. A deprecated microservice stays running because the shutdown task gets buried under higher-priority work. Individually, these are small misses. At scale, they add up to a budget line that no one owns.

Detection is straightforward once you know the signals. Near-zero CPU over a rolling 30-day window. No inbound or outbound network traffic above a minimal threshold — say, 500KB/day. No active database connections. And most telling: cost tags pointing to a team that no longer exists or that can't identify the resource when asked. AWS Trusted Advisor flags underutilized EC2 instances natively. Cost Explorer can be filtered the same way. Neither requires additional tooling.

Attribution is where zombie hunts stall. Without tags, there's no owner to contact. This is why the decommission workflow has to treat untagged resources as fair game by default. The SaaS company's approach: automated alert to the last IAM user who touched the cluster. No response in 72 hours triggered a decommission notice with a 7-day grace period and daily reminders. Still no response. The cluster was terminated.

The process that prevents recurrence doesn't require a platform overhaul. Tag every resource with owner, product, and environment at creation time — enforced via a tag policy in AWS Organizations, not a wiki page. Run an automated monthly job that flags resources above a cost threshold with no network activity in the past 30 days. Route the list to the tagged owner. No response in 14 days escalates to that team's PO. Still nothing means scheduled termination with a 48-hour final warning.

The $400k was gone — sunk cost. But the process change that came out of the audit saved the company an estimated $1.3 million over the following 18 months by catching the next wave before it aged into the same problem.

The root cause wasn't negligence. It was the absence of a decommission ritual — a forcing function that treats "we're done with this" as a step requiring the same intentionality as "we're launching this."

For a PO: each quarter, ask your platform team for a list of any infrastructure tagged to your product area with sub-10% utilization over the past 30 days — that list is your zombie audit and it costs nothing to run.
