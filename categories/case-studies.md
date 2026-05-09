---
layout: page
title: Case Studies
permalink: /categories/case-studies/
---

Real-world cloud cost scenarios — what went wrong, what fixed it, and what you can take back to your team.

{% assign cs_posts = site.categories['case-studies'] %}
{% if cs_posts %}{% assign cs_posts = cs_posts | sort: 'date' | reverse %}
{% for post in cs_posts %}
- **[{{ post.title }}]({{ post.url | relative_url }})** — {{ post.date | date: "%B %-d, %Y" }}
{% endfor %}{% endif %}
