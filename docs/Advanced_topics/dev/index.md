# Resources for developpers

## Technical documentation

### Agent-server communication protocol

Current agent-server communication is a mix of legacy XML and new JSON messages.

Generic task-scheduling protocol:

* [Original task scheduling specification](./spec/protocol/rest.md)
* [Current task scheduling specification](./spec/protocol/scheduling.md)

Module-specific communication protocols:

* [ESX module](./spec/protocol/esx.md)
* [Deploy module](./spec/protocol/deploy.md)
* [Collect module](./spec/protocol/collect.md)
* [Inventory module](./spec/protocol/inventory.md)
* [Network discovery module](./spec/protocol/netdiscovery.md)
* [Network inventory module](./spec/protocol/netinventory.md)
* [Wake on lan module](./spec/protocol/wakeonlan.md)
* [Vocabulary](./spec/protocol/vocabulary.md)

### Currently in specification

* [New directory layout (partially implemented)](./spec/new-directory-layout.md)
* [Load configuration from external places](./spec/load_ext_cfg.md)
* [POIP inventory with HTTP](./spec/poip.md)
* [Switch stack inventory](./spec/switch_stack.md)


## Agent

* Branches: <br/>
  › [master](https://github.com/fusioninventory/fusioninventory-agent/tree/master)  › [![Build Status](https://travis-ci.org/fusioninventory/fusioninventory-agent.png?branch=master)](https://travis-ci.org/fusioninventory/fusioninventory-agent)

### Release process

* [Release process]({{ site.baseurl }}/documentation/agent/dev/release_process.html)

### Get the sources

* [Source]({{ site.baseurl }}/documentation/agent/installation/source.html)
* Git: [UNIX]({{ site.baseurl }}/documentation/agent/dev/git_unix.html), [Windows]({{ site.baseurl }}/documentation/agent/dev/git_windows.html)
* [Official download location]({{ site.baseurl }}/documentation/dev/official_download_location.html)

## Plugin FusionInventory for GLPI

* Branches: <br/>
  › [master](https://github.com/fusioninventory/fusioninventory-for-glpi/tree/master)  › [![Build Status](https://travis-ci.org/fusioninventory/fusioninventory-for-glpi.png?branch=master)](https://travis-ci.org/fusioninventory/fusioninventory-for-glpi) [![Coverage Status](https://coveralls.io/repos/fusioninventory/fusioninventory-for-glpi/badge.svg?branch=master&service=github)](https://coveralls.io/github/fusioninventory/fusioninventory-for-glpi?branch=master)

### Code documentation of plugin for GLPI

[Plugin FusionInventory for GLPI code documentation]({{ site.baseurl }}/documentation/dev/plugin_doc_code/index.html)

### Specifications coded

* [Task Redux](./plugin-glpi/task_redux.md)
* [New home page of plugin](./plugin-glpi/new_home_page.md)

### Run unit tests for GLPI plugin

* [How to run unit tests for plugin FusionInventory for GLPI](./pluginglpi_unit_test.md)

## Standalone server

* [Stand alone server](./standaloneserver.md)

## Developper's events

* [Mini Codecamp March 14](./events/2014-03-14_Mini_CodeCamp.md)
* [meeting 18 february 2015](./events/2015-02-18_meeting.md)
