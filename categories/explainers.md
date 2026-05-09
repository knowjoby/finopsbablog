---
layout: page
title: Explainers
permalink: /categories/explainers/
---

Core FinOps and cloud billing concepts — explained without the jargon.

{% assign explainer_posts = site.categories.explainers %}
{% if explainer_posts %}{% assign explainer_posts = explainer_posts | sort: 'date' | reverse %}
{% for post in explainer_posts %}
- **[{{ post.title }}]({{ post.url | relative_url }})** — {{ post.date | date: "%B %-d, %Y" }}
{% endfor %}{% endif %}
