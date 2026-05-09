---
layout: page
title: Tool Reviews
permalink: /categories/tool-reviews/
---

Honest takes on FinOps tooling — who it's for, what it actually does, and whether a Product Owner needs to care.

{% assign tool_posts = site.categories['tool-reviews'] %}
{% if tool_posts %}{% assign tool_posts = tool_posts | sort: 'date' | reverse %}
{% for post in tool_posts %}
- **[{{ post.title }}]({{ post.url | relative_url }})** — {{ post.date | date: "%B %-d, %Y" }}
{% endfor %}{% endif %}
