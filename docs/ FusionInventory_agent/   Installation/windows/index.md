# Installation on Windows

!!! warning
    Since 2.3.x release, FusionInventory Agent comes with a *new* Microsoft Windows installer. The documentation you have below concerns this new installer. If you are looking for documentation on FusionInventory Agent 2.2.x (or earlier) and its installer, see link.

You can find [documentation on FusionInventory Agent 2.2.x](archive/windows_before_2.3.0.md).


## Get the Installer



You can get the last [FusionInventory Agent installer for Microsoft Windows](https://github.com/fusioninventory/fusioninventory-agent/releases). The filename of the installer follows this pattern:



    fusioninventory-agent_windows-<platform>_<version>.exe
                                       |         |
                                       v         |
                                                 |
                                 'x86' | 'x64'   |
                                                 v
                                                  
                     <major>.<minor>.<release>[-<package>]



Some notes about the new FusionInventory Agent installer for Microsoft Windows.



* The installer for each *\<platform>*, integrates its native, although reduced, version of [Strawberry Perl](http://strawberryperl.com/ "http://strawberryperl.com/")



* Inside the *\<version>*, *\<package>* is optional and indicates the secuence of the installer for FusionInventory Agent *\<major>*.*\<minor>*.*\<release>*. A new *\<package>* may contain improvements regarding the installer itself, the agent (patches) or both.



* It's possible to install *fusioninventory-agent_windows_x86_\<version>.exe* on a 32-bit or 64-bit Microsoft Windows system but it's only possible to install *fusioninventory-agent_windows_x64_\<version>.exe* on a 64-bit Microsoft Windows system.


The old versions can be found [here](http://forge.fusioninventory.org/projects/fusioninventory-agent-windows-installer/files "http://forge.fusioninventory.org/projects/fusioninventory-agent-windows-installer/files").


## The Installer Manual



You can find the [manual of the FusionInventory Agent installer for Microsoft Windows]({{ site.baseurl }}/documentation/agent/installation/windows/windows-installer-2.3.x-command-line.html).



The manual is contained within the installer. You can get it in one of the following ways:



* `C:\> fusioninventory-agent_windows-<platform>_<version>.exe /help`


* `C:\> fusioninventory-agent_windows-<platform>_<version>.exe /help /S`


{% include info.html param="It's recommended that you read through this documentation each time a new version is released; the new FusionInventory Agent installer for Microsoft Windows is still young and it's in constant development, including its manual." %}


## Installation from Command Line and Silent Installation



The FusionInventory Agent installer for Microsoft Windows performs a *visual mode* installation unless you specify the ***/S*** option on the command line, in which case a *silent mode* installation is performed.



For more information about the use of the command line, please, see ***The Installer Manual*** section above.



## Visual Installation



As stated above, if the FusionInventory Agent installer for MS Windows is run without the ***/S*** option, it runs a *visual mode* installation. The easiest way to perform a *visual mode* installation is double-clicking on the *fusioninventory-agent_windows-\<platform>_\<version>.exe* file.



The fields and controls that appear in the *visual mode* installation are strictly related to the command line options. For that reason it's recommended that you read ***The Installer Manual*** section above before proceeding with the installation.



For more information about the *visual mode* installation, please, see the following gallery of [commented screenshots of FusionInventory Agent installer for Microsoft Windows]({{ site.baseurl }}/documentation/agent/installation/windows/windows-installer-2.3.x-visual-mode.html). (*still under construction*)



## Large Installations


### fusioninventory.vbs

[fusioninventory.vbs](https://raw.githubusercontent.com/fusioninventory/documentation/docs/ FusionInventory_agent/   Installation/windows/fusioninventory.vbs) is a VBS script used to:

* Download the fusioninventory Windows installer
* Remove OCS Inventory Agent
* Install or upgrade FusionInventory

To use this script, you must first download the script and then edit it. The first lines of the script
must be adjusted for your configuration:

```
versionverification = "2.6"
fusionarguments = "/S /server=http://server1/glpi/plugins/fusioninventory/ /rpc-trust-localhost /runnow"
' Depending on your needs, you can use either HTTP or Windows share
'fusionsetupURL = "\\server1\data\fusioninventory-agent_windows-i386_" & versionverification & ".exe"
fusionsetupURL = "http://prebuilt.fusioninventory.org/stable/windows-i386/fusioninventory-agent_windows-i386_" & versionverification & ".exe"
uninstallocsagent = "yes"
```

* versionverification: the version of fusioninventory to install
* fusionarguments: the command line argument for the [Windows installer](./windows-installer-2.3.x-command-line.md))
* fusionsetupURL: the location of the Windows installer binary (either HTTP or Windows share)
* uninstallocsagent: "yes" if OCS Agent has to be removed


You can use this  script to:

* run a silent installation on a given machine
* deploy the agent on your network using psexec
* prepare a GPO to deploy the agent on all the machines of the Windows domain

### Run a silent installation on a given machine

Just double clic on the script or run from a command console:

``` cmd
cscript fusioninventory.vbs
```

### Deploy the agent on your network using psexec

To run the fusioninventory.vbs script on a machine computer1

``` cmd
psexec -u domain\user \\computer1 cscript \\foo\share\script.vbs
```

Or if you want to run the install on all the computer of your domain:

``` cmd
psexec -u domain\user \\* cscript \\foo\share\script.vbs
```

### GPO to deploy the agent on all the machines of the Windows domain

Create a GPO and copy the script within and associate the fusioninventory.vbs script. The GPO has to be configured to run during machine start up.

You may be interested by these two GPO templates:

* [FusionInventory.adml](https://raw.githubusercontent.com/fusioninventory/documentation/docs/ FusionInventory_agent/   Installation/windows/FusionInventory.adml)
* [FusionInventory.admx](https://raw.githubusercontent.com/fusioninventory/documentation/docs/ FusionInventory_agent/   Installation/windows/FusionInventory.admx)

## Alternative VBS script

An [alternative script](https://raw.githubusercontent.com/fusioninventory/documentation/docs/ FusionInventory_agent/   Installation/windows/fusioninventory-alternative.vbs) maintained by ZenAdm also exists.

This script is still *experimental* but it is already much easier to understand.

