# Network inventory


## Purpose

A network inventory task aims to retrieve exhaustive informations from
SNMP-compatible devices, such as network devices or printers, already part of
the list of known assets.

This task can only be performed on devices already part of the list of known
assets, either as a result of a previous [network discovery
task](networkdiscovery.md), or manually created, with proper SNMP
credentials.

## Overview

This task uses SNMP to retrieve various information from a device, so as to
update it in GLPI:

* consumable levels and print counter on printers
* vlans definition, network topology, network ports status on network devices

## Running

### Pre-requisite

The agent performing the task needs to have the network inventory module
installed. Many Linux distributions ships agent modules in distinct packages,
to reduce the burden of dependencies.

The agent performing the task needs network access the target devices, with
proper access control: just being able to send UDP packets to a device is not
enough, if this device is configured to ignore them.

The target device should be associated with proper SNMP credentials in GLPI.

As for any other server-controled task, the agent should use either managed or
half-managed mode, as explained in [agent usage](../ FusionInventory_agent/  Configuration/usage.md). If
the task is server-triggered, the agent must run in managed mode, and
its HTTP port should be reachable from the server.

### Server execution

See [network discovery task documentation](networkdiscovery.md#server-execution).

### Command-line execution

A network inventory task can be also performed without a GLPI server, allowing
easier control and troubleshooting, with the
[fusioninventory-netinventory](../ FusionInventory_agent/ Manpage/fusioninventory-netinventory.md)
command-line tools. However, there is no way currently to inject the result
in GLPI.

## Troubleshooting

See [network discovery task documentation](networkdiscovery.md#troubleshooting).

