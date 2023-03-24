# How to inventory in DMZ

*Ways to deal with inventories in DMZ...*

## Collect the inventories from DMZ agents

You can collect your DMZ inventories by using a limited script that get the POST
request of the agents.

Download [collect.php](https://raw.githubusercontent.com/fusioninventory/documentation/master/docs/FusionInventory_for_GLPI/dmz/collect.php) and copy it somewhere PHP is enabled. For example `/var/www` or `/var/www/html`.

Then, you can configure agents in DMZ machines this way:

``` shell
fusioninventory-agent --server=http://server/collect.php
```

where "server" is the name of the computer to which you copied the script (collect.php).

The inventory files will be generated in /tmp. This is the default, you can
adjust the $dumDir key at the begining of the script.

``` php
$dumpDir = '/tmp';
```

## Import results with fusioninventory-injector

Once the xml inventory files are written, you can move them outside of the DMZ and
finally import these files to GLPI using [fusioninventory-injector](../../FusionInventory_agent/manpage/fusioninventory-injector.md).
