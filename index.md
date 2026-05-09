---
layout: default
title: FinOps for POs
---
<h1>FinOps for POs</h1>
<p>Plain-language writing on cloud cost management and invoice intelligence, from a Product Owner at EY.</p>
<p>[ <a href="/about/">About</a> ]</p>
<hr>
<h2>All Posts</h2>
<ul>
{% for post in site.posts %}
<li><a href="{{ post.url }}">{{ post.title }}</a> &mdash; {{ post.date | date: "%Y-%m-%d" }} ({{ post.categories | join: ", " }})</li>
{% endfor %}
</ul>
