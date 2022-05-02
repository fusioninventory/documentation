---
layout: single
title: fusioninventory-netinventory
---
<style>
.post-content h2 { font-weight: bold ; margin: 1.5rem 0; }
.post-content h1:before { content: ''; }
.post-content h2:before { content: ''; }
.post-content h3:before { content: ''; }
</style>
<!-- begin man -->

# NAME

fusioninventory-netinventory - Standalone network inventory


# SYNOPSIS

<pre>fusioninventory-netinventory [options] [--host &#60;host&#62;|--file &#60;file&#62;]

  Options:
    --host &#60;HOST&#62;          target host
    --file &#60;FILE&#62;          snmpwalk output file
    --community &#60;STRING&#62;   community string (public)
    --credentials &#60;STRING&#62; SNMP credentials (version:1,community:public)
    --timeout &#60;TIME&#62;       SNMP timeout, in seconds (15)
    --type &#60;TYPE&#62;          force device type
    --threads &#60;COUNT&#62;      number of inventory threads (1)
    --control              output control messages
    --debug                debug output
    -h --help              print this message and exit
    --version              print the task version and exit</pre>

# DESCRIPTION

_**fusioninventory-netinventory**_ can be used to run a network inventory task without a GLPI server.


# OPTIONS

### **\--host** _HOST_

Run an online inventory against given host. Multiple usage allowed, for multiple hosts.


### **\--file** _FILE_

Run an offline inventory against snmpwalk output, stored in given file. Multiple usage allowed, for multiple files.


### **\--communty** _STRING_

Use given string as SNMP community (assume SNMPv1)


### **\--credentials** _STRING_

Use given string as SNMP credentials specification. This specification is a comma-separated list of key:value authentication parameters, such as:

* version:2c,community:public
* version:3,username:admin,authprotocol:sha,authpassword:s3cr3t
* etc.


### **\--timeout** _TIME_

Set SNMP timeout, in seconds.


### **\--type** _TYPE_

Force device type, instead of relying on automatic identification. Currently allowed types:

* COMPUTER
* NETWORKING
* PRINTER
* STORAGE
* POWER
* PHONE


### **\--threads** _count_

Use given number of inventory threads.


### **\--control**

Output server-agent control messages, in addition to inventory result itself.


### **\--debug**

Turn the debug mode on. Multiple usage allowed, for additional verbosity.




# EXAMPLES

Run an inventory against a network device, using SNMP version 2c authentication:


<pre>    $&#62; fusioninventory-netinventory --host 192.168.0.1 \
    --credentials version:2c,community:public</pre>

Run an inventory against a network device, using SNMP version 3 authentication and forcing its type:


<pre>    $&#62; fusioninventory-netinventory --host my.device --type NETWORKING \
    --credentials version:3,username:admin,authprotocol:sha,authpassword:s3cr3t</pre>

<em class='post-meta'>Last source update: Tue Dec 12 19:24:50 2017</em>
<!-- end man -->
