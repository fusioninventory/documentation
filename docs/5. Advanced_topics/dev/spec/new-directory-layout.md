---
layout: single
title: Specs for new directory layout
---

# New directory layout

## git repository layout

    fusioninventory-agent/
    |- lib/
    |- etc/
    |  |- agent.cfg
    |- var/
    |  |- log/
    |  |- lib/
    |- share/
    |- resources/
    |- t/
    |- tools/
    |- fusioninventory-agent
    |- fusioninventory-win32-service

## Windows standalone distribution layout

    fusioninventory-agent/
    |- lib/
    |- var/
    |  |- log/
    |  |- lib/
    |- share/
    |- bin/
    |- perl/
    |- fusioninventory-agent
    |- fusioninventory-agent.bat
    |- fusioninventory-win32-service

## Unix standalone distribution repository layout

    fusioninventory-agent/
    |- lib/
    |- etc/
    |  |- agent.cfg
    |- var/
    |  |- log/
    |  |- lib/
    |- share/
    |- perl/
    |- fusioninventory-agent
    |- fusioninventory-agent.sh

