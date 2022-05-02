---
layout: single
title: Run unit tests for plugin FusionInventory for GLPI
---

How to run unit tests for plugin FusionInventory for GLPI

# Preprare installation
1. Have a glpi installation
2. URL to access this specific GLPI must be **http://127.0.0.1/fusion0.84** for version 0.84 of the plugin
3. Put plugin FusionInventory in glpi/plugins like standard install
4. Install a first time GLPI + plugin Fusion manually with web browser
5. Install last version of phpunit, and all optionnal packages : <http://www.phpunit.de/manual/current/en/installation.html>


# Run unit tests
Go in folder glpi/plugins/fuioninventory/phpunit/ and run : 
> phpunit AllTests.php
