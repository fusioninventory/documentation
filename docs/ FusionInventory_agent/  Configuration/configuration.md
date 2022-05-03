# Agent configuration

## Location

On Unix, the agent reads its configuration from a configuration file, whose
location depends of the installation method:

* `/etc/fusioninventory/agent.cfg`: default
* `/opt/fusioninventory/agent.cfg`: OS X mpkg
* `/usr/local/etc/fusioninventory/agent.cfg`: FreeBSD port

It is highly recommanded not to change this file, it would prevent it to be updated (especially if you use a linux package).

Just ensure the `include "conf.d/"` is not commented (does not starts with a `#`).
Your specific configuration should then go to any `conf.d/*.cfg` file.

On Windows, the agent read its configuration from a registry key, whose
location depends on architecture:

* `HKEY_LOCAL_MACHINE\SOFTWARE\FusionInventory-Agent`: Windows
* `HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\FusionInventory-Agent`: 32bits agent on 64bits Windows

## Syntax

Most configuration parameters are single-valued. Multi-valued ones use a comma
field separator. For instance, `logger = Stderr, File`

## Available parameters

The only minimal requirement is an execution target, which can be either:

* `server`: a server URL, such as http://glpiserver/plugins/fusioninventory/
* `local`: a output directory, such /tmp/inventory

Warning: multiple targets doesn't mean "execute once, send results many times",
but "execute and send results many times", implying potentially different
results (see [bug 2335](http://forge.fusioninventory.org/issues/2335)).

See [agent.cfg man page](../ Manpage/agent.cfg.md) for full parameters list.

## Command line

All configuration parameters can be overriden by command-line options.

See various executable [man pages](../ Manpage/) for full options list.
