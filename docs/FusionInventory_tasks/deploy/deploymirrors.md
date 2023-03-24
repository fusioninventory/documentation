# Deploy with mirrors

You can deploy with p2p, but if you can't or don't want to use this on multi-sites, you can use _mirrors_.


## What is mirrors?

A mirror as a HTTP server where an agent try to get the file(s) required to deploy a software.


## How it works ?

### In GLPI

In GLPI, add a mirror in menu *Plugins* > *FusionInventory* > *Deploy* > *Mirror servers*

Add in field *Mirror server address* the url of your HTTP server on the remote site (think to create the mirror server in the right entity).

!!! example
    http://192.168.43.1/


### The mirrors

Install your favorite HTTP server (apache, nginx...) in the remote site.

Copy / synchronize the folder (and sub-folders) *glpi/files/_plugins/fusioninventory/files/repository* in the HTTP server (to the server root in our example).


### The Agent

The agent will receive a list of mirror servers from GLPI.

It will try it (them if defined many) with the file(s) required for deploy the software. If it not find it, at the end it get it from GLPI.
