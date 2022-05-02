---
layout: single
title: fusioninventory-netdiscovery
---
<style>
.post-content h2 { font-weight: bold ; margin: 1.5rem 0; }
.post-content h1:before { content: ''; }
.post-content h2:before { content: ''; }
.post-content h3:before { content: ''; }
</style>
<!-- begin man -->

# NAME

fusioninventory-netdiscovery - Standalone network discovery


# SYNOPSIS

<pre>fusioninventory-netdiscovery [options] --first &#60;address&#62; --last &#60;address&#62;

  Options:
    --first &#60;ADDRESS&#62;      IP range first address
    --last &#60;ADDRESS&#62;       IP range last address
    --community &#60;STRING&#62;   SNMP community string (public)
    --credentials &#60;STRING&#62; SNMP credentials (version:1,community:public)
    --timeout &#60;TIME        SNMP timeout, in seconds (1)
    --entity &#60;ENTITY&#62;      GLPI entity
    --threads &#60;COUNT&#62;      number of discovery threads (1)
    --control              output control messages
    --debug                debug output
    -h --help              print this message and exit
    --version              print the task version and exit</pre>

# DESCRIPTION

_**fusioninventory-netdiscovery**_ can be used to run a network discovery task without a GLPI server.


# OPTIONS

### **\--first** _ADDRESS_

Set the first IP address of the network range to scan.


### **\--last** _ADDRESS_

Set the last IP address of the network range to scan.


### **\--community** _STRING_

Use given string as SNMP community (assume SNMPv1).


### **\--credentials** _STRING_

Use given string as SNMP credentials specification. This specification is a comma-separated list of key:value authentication parameters, such as:

* version:2c,community:public
* version:3,username:admin,authprotocol:sha,authpassword:s3cr3t
* etc.


### **\--timeout** _TIME_

Set SNMP timeout, in seconds.


### **\--entity** _ENTITY_

Set GLPI entity.


### **\--threads** _COUNT_

Use given number of inventory threads.


### **\--control**

Output server-agent control messages, in addition to inventory result itself.


### **\--debug**

Turn the debug mode on. Multiple usage allowed, for additional verbosity.




# EXAMPLES

Run a discovery against a network range, using SNMP version 1:


<pre>    $&#62; fusioninventory-netdiscovery --first 192.168.0.1 --last 192.168.0.254 \
    --community public</pre>

Run a discovery against a network range, using multiple SNMP credentials:


<pre>    $&#62; fusioninventory-netdiscovery --first 192.168.0.1 --last 192.168.0.254 \
    --credentials version:2c,community:public \
    --credentials version:3,username:admin,authprotocol:sha,authpassword:s3cr3t</pre>

<em class='post-meta'>Last source update: Tue Dec 12 19:25:05 2017</em>
<!-- end man -->
