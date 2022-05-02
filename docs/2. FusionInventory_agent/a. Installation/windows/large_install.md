---
layout: single
title: Windows large installation
---

# Silent installation

{% include info.html param="Warning, this page is outdated and needs to be refresh for the 2.3.0 agent." %}

## fusioninventory.vbs

[fusioninventory.vbs](https://raw.githubusercontent.com/fusioninventory/fusioninventory.github.io/master/_documentation/agent/installation/windows/fusioninventory.vbs) is a VBS script used to:

* Download the fusioninventory Windows installer
* Remove OCS Inventory Agent
* Install or upgrade FusionInventory

To use this script, you must first download the script and then edit it. The first lines of the script
must be adjusted for your configuration:

    versionverification = "2.2.6-1"
    fusionarguments = "/S /server=http://server1/glpi/plugins/fusioninventory/ /rpc-trust-localhost /runnow"
    ' Depending on your needs, you can use either HTTP or Windows share
    'fusionsetupURL = "\\server1\data\fusioninventory-agent_windows-i386_" & versionverification & ".exe"
    fusionsetupURL = "http://prebuilt.fusioninventory.org/stable/windows-i386/fusioninventory-agent_windows-i386_" & versionverification & ".exe"
    uninstallocsagent = "yes"

* versionverification: the version of fusioninventory to install
* fusionarguments: the command line argument for the [Windows installer]({{ site.baseurl }}/documentation/agent/installation/windows/))
* fusionsetupURL: the location of the Windows installer binary (either HTTP or Windows share)
* uninstallocsagent: "yes" if OCS Agent has to be removed


You can use this  script to:

* run a silent installation on a given machine
* deploy the agent on your network using psexec
* prepare a GPO to deploy the agent on all the machines of the Windows domain

## Run a silent installation on a given machine

Just double clic on the script or run from a command console:

    cscript fusioninventory.vbs

## Deploy the agent on your network using psexec

To run the fusioninventory.vbs script on a machine computer1

    psexec -u domain\user \\computer1 cscript \\foo\share\script.vbs


Or if you want to run the install on all the computer of your domain:

    psexec -u domain\user \\* cscript \\foo\share\script.vbs

## GPO to deploy the agent on all the machines of the Windows domain

Create a GPO and copy the script within and associate the fusioninventory.vbs script. The GPO has to be configured to run during machine start up.

You may be interested by these two GPO templates:

* [FusionInventory.adml](https://raw.githubusercontent.com/fusioninventory/fusioninventory.github.io/master/_documentation/agent/installation/windows/FusionInventory.adml)
* [FusionInventory.admx](https://raw.githubusercontent.com/fusioninventory/fusioninventory.github.io/master/_documentation/agent/installation/windows/FusionInventory.admx)

# Alternative VBS script

An [alternative script](https://raw.githubusercontent.com/fusioninventory/fusioninventory.github.io/master/_documentation/agent/installation/windows/fusioninventory-alternative.vbs) maintained
by ZenAdm also exists.

This script is still *experimental* but it is already much easier to understand.
