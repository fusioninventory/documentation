# ESX Inventory

## Introduction

FusionInventory can contact a ESX/ESXi/vCenter serveur using the VMware SOAP API.
It will identify the ESX server and the associated virtual machine. At the
end, it will push XML inventory of the machines to the server:

1. the agent contact the server
    * the server answer with a list of VMware servers to scan and some credentials
2. the agent scan each VMware servers and generate the associated XML content
3. the agent send the XML to the server much like a local inventory

FusionInventory *DO NOT* use VMware Perl library.


![](../../assets/fi4g/esx.png)

## Installation

To inventory ESX or Vcenter, there is no specific agent to be installed on the ESX. The Fusioninventory agent installed on Windows or Linux, will inventory remotely by a automatic task.
For Windows host, the Fusioninventory Agent comes with the module. For Linux distribution, you must install a additional package.

On Redhat/Centos, run 

``` shell
# yum install fusioninventory-agent-task-esx
```

On Debian/Ubuntu :

``` shell
# apt-get install libfusioninventory-agent-task-esx-perl
```

From Source, see the [agent source installation page](../../FusionInventory_agent/installation/source.md).

## From the Command line

You can use [fusioninventory-esx](../../FusionInventory_agent/manpage/fusioninventory-esx.md) and [fusioninventory-injector](../../FusionInventory_agent/manpage/fusioninventory-injector.md) to:

1. fetch the Inventories from the server
2. push the Inventories in GLPI

!!! example
    \# fusioninventory-esx --user root --password password --host esx-server --directory /tmp
    
    \# fusioninventory-injector -v --file /tmp/esx-server-2011-01-25-14-11-07.ocs -u https://myserver/plugins/fusioninventory/


## From GLPI

###  Reconfiguration FusionInventory agent

First, we must designate the fusion agents who will have to perform the inventory VMware (ESX or VCenter) host.

Go to Plugins → Home → FusionInventory → Agents management

Chose a agent and enable : VMware host remote inventory :

![](../../assets/tasks/esxinventory/01_inventory-ESX.png)

!!! warning
    Since some account credentials will be send by the agent, we strongly recommend the user of a known machine with SSL enabled.


### Task management

#### Add authentication for remote devices (VMware)

Add an authentification : 

Go to Plugins  → FusionInventory → Authentication for remote devices (VMware)

![](../../assets/tasks/esxinventory/02_authentification_vcenter.png)

!!! warning
    We strongly recommend the user of account with limited privilege.

#### Add remote devices to inventory (VMware)

Goto  Plugins → FusionInventory → Remote devices to inventory (VMware)

Click on + to add a device 

* Name : Add a description
* Type : "chose VMWARE Host"
* Add an Authentication
* IP : add an ip address

![](../../assets/tasks/esxinventory/03_vmware_devices.png)

#### Add a task 

Please see the [task creation](../../FusionInventory_for_GLPI/advanced/tasks.md) page.

Click on + to add a task :

* Configure the periodicity
* Chose Module : VMware host remote inventory
* Add Definition → Remote device inventory
* Select the agent earlier reconfigured 

![](../../assets/tasks/esxinventory/04_vmware_task.png)


