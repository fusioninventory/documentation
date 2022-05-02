---
layout: single
title: How to edit this wiki
---

The wiki is jekyll. It uses [Markdown syntax](http://daringfireball.net/projects/markdown/syntax).

# From HTTP

You can edit the documentation/* pages by yourself.
You have a button on each page to edit through github.

# From Git (advanced)

This site is hosted by [github](https://github.com/fusioninventory/fusioninventory.github.io).

# Version Control

This site is version controlled using [Git](http://git-scm.com/). Anyone can access its anonymous git repository:

    $ git clone https://github.com/fusioninventory/fusioninventory.github.io.git

Users with configured ssh keys can modify the git repository:

    git clone git@github.com:fusioninventory/fusioninventory.github.io.git

# How to publish a new (admin only)

    $ create a file _post/[year]-[month]-[day]-...md
    $ git add _post/[year]-[month]-[day]-...md
    $ git commit -m "this a great news"
    $ git push
