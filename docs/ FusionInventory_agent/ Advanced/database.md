# Agent database

## Overview

The agent database is located in agent data directory. It consist of the following files:

* `pci.ids` is a database of PCI devices, used by local inventory module
* `usb.ids` is a database of USB devices, used by local inventory module
* `edid.ids` is a database of Screen manufacturer, used by local inventory module
* `sysobject.ids` is a database of SNMP devices, used by network discovery and
  network inventory modules
  * For Linux servers (when `SNMPv2-MIB::sysObjectID.0 = OID:
  NET-SNMP-MIB::netSnmpAgentOIDs.10`), an additional check is done by [`LinuxAppliance.pm`](https://github.com/fusioninventory/fusioninventory-agent/blob/develop/lib/FusionInventory/Agent/SNMP/MibSupport/LinuxAppliance.pm).

Those files can easily be customized if needed, as their format is
self-documented. However, local modifications will get lost on upgrade.

## SNMP device database

The `sysobject.ids` file is a database of known SNMP devices, indexed by the
discriminant part of their SysObjectID value:

    9.1.1111    Cisco   NETWORKING      Catalyst 3500
    +           +       +               +
    |           |       |               |
    |           |       |               +-> device model
    |           |       |
    |           |       +-----------------> device type
    |           |
    |           +-------------------------> device manufacturer
    |
    +-------------------------------------> SysObjectID model-specific suffix

The SysObjectID suffix is the last part of the full SysObjectID value, ie:

    .1.3.6.1.4.1.9.1.111
    +            +
    |            |
    |            +-----> model-specific suffix
    |
    +------------------> shared prefix

The SysObjectID value for any SNMP device can be retrieved by any SNMP client,
using its OID (.1.3.6.1.2.1.1.2.0), or with either
[fusioninventory-netinventory](../ Manpage/fusioninventory-netinventory.md) or
[fusioninventory-netdiscovery](../ Manpage/fusioninventory-netdiscovery.md) command-line
tools, with --debug option.
