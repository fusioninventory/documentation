# FAQ


## Configuration and deployment

### On which platforms is the FusionInventory agent available?

The agent is available on:

* [x] Windows
* [x] OSX
* [x] Linux distributions (Debian, Ubuntu, Centos...)
* [x] *BSD (FreeBSD, OpenBSD, NetBSD...)
* [x] AIX
* [x] Solaris
* [x] HP-UX
* [x] Android
* [ ] Iphone

The agent shares the same codebase on all these platforms.

### Is FusionInventory agent compatible with OCS Inventory NG Server?

It was compatible in begin of 2010 years, but now not sure, so **we don't recommand it**.


### How to redirect OCS agent with Apache?

You can use an [alias](http://httpd.apache.org/docs/2.2/mod/mod_alias.html) directive to
redirect traffic from /ocsinventory to FusionInventory.

``` apacheconf
Alias /ocsinventory "/var/www/html/glpi/plugins/fusioninventory/front/communication.php"
```

Take care to declare this directive before an `Alias / XXX` or it will be ignored.

For example:

``` apacheconf
Alias /ocsinventory "/var/www/html/glpi/plugins/fusioninventory/front/communication.php"
Alias / /var/www/html/glpi/

<Directory /var/www/html/glpi>
    Options None
    AllowOverride Limit Options FileInfo

    php_value memory_limit 256M

    Order Deny,Allow
    Allow from all
</Directory>
```
It's also possible to use a regular expression for that.


### How can I configure two or more servers?

In the agent configuration file, you can define **several servers** to
communicate with. For example to communicate with two servers:
FusionInventory Server for GLPI 0.80 and 0.83:

!!! tip
    server = http://glpi080/plugins/fusioninventory/front/communication.php,http://glpi083/plugins/fusioninventory/

The agent will contact each server in the order defined in the configuration file, and perform the actions requested from each of them.

### How can I use a mastering software like Ghost to deploy my agent?

Yes. However, **take care to not duplicate agent state directory**, otherwise
multiple agents will use the same identifier.


### How can I inventory my virtual machines ?

As for every other machine: install an agent on it.

Running a local inventory on a host doesn't actually perform an actual
inventory of its guests, it just retrieve minimal information, such as virtual
machine identifier, so as to compute the relationship between the guest and the
host.

### How can I inventory my printers ?

For local (USB) printers, run a local inventory on the host.

For network printers, run a network inventory from any agent able to
communicate through SNMP with the printer.

### How can I debug agent ssl issue ?

With FusionInventory Agent 2.3.20, you can diagnostic agent to server SSL communications
by starting the agent from a command line with the following parameters:

!!! example
    fusioninventory-agent --logger=Stderr --debug --debug --server=https://[your-server]/plugins/fusioninventory/

You will obtain very verbose SSL library messages from which you can better understand
what's going on like wrong server certificate, missing CA certificate on agent side, ...

## Usual issues

### *Task X is not enabled* message

!!! info
    Task NetInventory is not enabled

    Task NetDiscovery is not enabled

These messages show up in the agent log when the server do not ask for an Network
Discovery or a Network Inventory.

### *Unable to find agent to run this job* message

You will get *Unable to find agent to run this job* message when the server can't find an agent
to run a task in push mode:

* Ensure an agent is running as service or daemon
* The server can contact http://[agentIP]:62354 directly
* Check in http://glpi/plugins/fusioninventory/front/agent.php if the agent has *Network discovery*
  and *Network inventory (SNMP)* modules turned on

### *Bad token* message

"Bad token" problems means the agent and the server are not synchronized anymore. You can resolve the situation either:
* just by running an inventory
* by using `httpd-trust` parameter to allow request from the server IP.

!!! warning

    A bug fixed in 2.2.7 prevent the use of **rpc-trust-localhost** and **httpd-trust**

### *end_request: I/O error, dev fd0, sector 0* message

This can append on Linux box with floppy driver like most of the VMware virtual machine. You can
work around the problem by unloading the floppy kernel module:

```
rmmod floppy
```

The error is generated when the agent launch the following command `fdisk -l`.

### Duplicated computers in inventory

With the default settings, FusionInventory for GLPI use the follow criteria to identify computer:

* MAC addresses
* serial number
* UUID

One of this information is probably duplicated.

### Missing information when called from cron

Most of the time, cron do not define a default PATH. In this case the agent won't
find important tools like `dmidecode`, `lspci`, etc ( See old [Fusioninventory forge issue 1747](http://forge.fusioninventory.org/issues/1747) ).

Just define the PATH in the crontab:

```
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
```

### Strange agent token “12345678”

Since the agent 2.3.0, the agent doesn't use any token anymore to authenticate
server messages. Any target server is automatically trusted, as well as any
other IP address given through httpd-trust configuration directive.

### FusionInventory Agent WakeOnLan task fails on windows

WakeOnLan agent task requires a system library (DLL) provided by [WinPcap](https://www.winpcap.org).

Just download and install the [lastest WinPcap package](https://www.winpcap.org/install/default.htm) before being able to use WOL from a win32 agent.

_See also: [issue #392](https://github.com/fusioninventory/fusioninventory-agent/issues/392) solved by tabad_

