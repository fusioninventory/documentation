# fusioninventory-esx

## Name

fusioninventory-esx - vCenter/ESX/ESXi remote inventory from command line


## Synopsis

<pre>fusioninventory-esx --host &#60;host&#62; --user &#60;user&#62; --password &#60;password&#62; --directory &#60;directory&#62;

  Options:
    --help                 this menu
    --host hostname        ESX server hostname
    --user username        user name
    --password xxxx        user password
    --directory directory  output directory
    --tag tag              tag for the inventoried machine</pre>

## Examples

<pre>    % fusioninventory-esx --host myesx --user foo --password bar --directory /tmp</pre>

You can import the .ocs file in your inventory server with the fusioninventory-injector tool.

<pre>    %fusioninventory-injector -v --file /tmp/*.ocs -u https://myserver/plugins/fusioninventory/</pre>

## Description

_**fusioninventory-esx**_ creates inventory of remote ESX/ESXi and vCenter VMware. It uses the SOAP interface of the remote server.


Supported systems:


* _**ESX and ESXi 3.5**_
* _**ESX and ESXi 4.1**_
* _**ESXi 5.0**_
* _**vCenter 4.1**_
* _**vCenter 5.0**_


Active Directory users, please note the AD authentication doesn't work. You must create a account on the VMware server.


## Limitation

So far, ESX serial number are not collected.


## Security

The SSL hostname check of the server is disabled.


<em class='post-meta'>Last source update: Tue Dec 12 18:47:53 2017</em>
