---
layout: single
title: Installation on Gentoo
---

# Maintained Gentoo version

*fusioninventory-agent* is not yet part of the official repository.

# Required Ebuilds:

- app-admin/fusioninventory-agent, a minimal version is provided in the [forum](http://forums.gentoo.org/viewtopic-p-7351720.html#7351720),
- dev-perl/XML-TreePP, from the [Gentoo Perl Overlay](http://www.gentoo.org/proj/en/perl/).

# Agent installation

    # emerge app-admin/fusioninventory-agent

# Agent configuration

The configuration file is located at `/usr/local/etc/fusioninventory/agent.cfg`.
