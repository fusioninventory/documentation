---
layout: single
title: fusioninventory-inventory
---
<style>
.post-content h2 { font-weight: bold ; margin: 1.5rem 0; }
.post-content h1:before { content: ''; }
.post-content h2:before { content: ''; }
.post-content h3:before { content: ''; }
</style>
<!-- begin man -->

# NAME

fusioninventory-inventory - Standalone inventory


# SYNOPSIS

<pre>fusioninventory-inventory [options]

  Options:
    --scan-homedirs                scan use home directories (false)
    --scan-profiles                scan user profiles (false)
    --html                         save the inventory as HTML (false)
    --no-category=CATEGORY         do not list given category items
    -t --tag=TAG                   mark the machine with given tag
    --backend-collect-timeout=TIME timeout for inventory modules
                                     execution (30)
    --additional-content=FILE      additional inventory content file
    --verbose                      verbose output (control messages)
    --debug                        debug output (execution traces)
    -h --help                      print this message and exit
    --version                      print the task version and exit</pre>

# DESCRIPTION

_**fusioninventory-inventory**_ can be used to run an inventory task without a GLPI server.


<em class='post-meta'>Last source update: Tue Dec 12 19:23:02 2017</em>
<!-- end man -->
