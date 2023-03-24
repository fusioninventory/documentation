# fusioninventory-injector


## Name

fusioninventory-injector - A tool to push inventory in an OCS Inventory or compatible server.

## Synopsis

<pre>fusioninventory-injector [options] [--file &#60;file&#62;|--directory &#60;directory&#62;|--stdin|--useragent &#60;user-agent&#62;]

  Options:
    -h --help      this menu
    -d --directory load every .ocs files from a directory
    -R --recursive recursively load .ocs files from &#60;directory&#62;
    -f --file      load a speficic file
    -u --url       server URL
    -r --remove    remove succesfuly injected files
    -v --verbose   verbose mode
    --stdin        read data from STDIN
    --useragent    set used HTTP User-Agent for POST
    -x --xml-ua    use Client version found in XML as User-Agent for POST
    --no-ssl-check do not check server SSL certificate
    -C --no-compression don&#39;t compress sent XML inventories
</pre>

!!! example
    fusioninventory-injector -v -f /tmp/toto-2010-09-10-11-42-22.ocs --url https://login:pw@server/plugins/fusioninventory/
    
    fusioninventory-injector -v -R -d /srv/ftp/fusion --url https://login:pw@glpi-server/plugins/fusioninventory/

## Description

This tool can be used to test your server, do benchmark or push inventory from off-line machine.


<em class='post-meta'>Last source update: Tue Dec 12 19:18:04 2017</em>
