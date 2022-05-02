---
layout: single
title: fusioninventory-win32-service
---
<style>
.post-content h2 { font-weight: bold ; margin: 1.5rem 0; }
.post-content h1:before { content: ''; }
.post-content h2:before { content: ''; }
.post-content h3:before { content: ''; }
</style>
<!-- begin man -->

# NAME

fusioninventory-win32-service - FusionInventory Agent service for Windows


# SYNOPSIS

<pre>fusioninventory-win32-service [--register|--delete|--help] [options]

  Options are only needed to register or delete the service. They are handy
  while using Fusioninventory agent from sources.

  Register options:
    -n --name=NAME                  unique system name for the service
    -d --displayname=&#34;Nice Name&#34;    display name of the service
    -l --libdir=PATH                full path to agent perl libraries use it if
                                    not found by the script
    -p --program=&#34;path to program&#34;  perl script to start as service

  Delete options:
    -n --name=NAME                  unique system name of the service to delete

  Samples to use from sources base:
    perl bin/fusioninventory-win32-service --help
    perl bin/fusioninventory-win32-service --register
    perl bin/fusioninventory-win32-service --delete
    perl bin/fusioninventory-win32-service --register -n fia-test -d &#34;[TEST] FIA Service&#34;
    perl bin/fusioninventory-win32-service --delete -n fia-test</pre>

<em class='post-meta'>Last source update: Tue Dec 12 19:12:41 2017</em>
<!-- end man -->
