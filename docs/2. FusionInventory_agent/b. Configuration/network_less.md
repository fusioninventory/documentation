---
layout: single
title: FusionInventory without network connection
---

FusionInventy without network connection
=======================================

The agent is able to create an file with the inventory:

    fusioninventory-agent --local /tmp
    
On Windows, you can add the 'local' key in the the registry and associate it with a directory.

You can get the full documentation of the agent in the [reference](http://www.fusioninventory.org/documentation/references/) page.

Push my inventories in the server
=================================

Through FusionInventory for GLPI Interface
------------------------------------------

Go in Plugins > FusionInventory > Import agent XML Menu and upload the XML.

fusioninventory-injector
------------------------

    fusioninventory-injector -v -f myfile.xml -u http://glpi083/plugins/fusioninventory/

You can get the full documentation of fusioninventoy-injector in the [reference](http://www.fusioninventory.org/documentation/references/) page.

curl
----

You can also use curl to push an inventory. This can be useful for example if your perl installation has no SSL support and so you can not use the fusioninventory-injector command with a HTTPS only server:

    curl --header "Content-Type: Application/x-compress" --cacert your-ca.pem -u username:password --data @/tmp/lazer.local-2011-10-04-12-21-23.ocs https://glpi/plugins/fusioninventory/

With no SSL check and no authentification :

    curl --header "Content-Type: Application/x-compress" -k --data @/tmp/monposte.local-2012-10-04-12-21-23.ocs https://myglpiserver/plugins/fusioninventory/


