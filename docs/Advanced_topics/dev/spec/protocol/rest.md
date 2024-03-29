# Agent/server communication protocol

##  The disadvantage of the current situation

For the moment, the communication exchange between the agent and the server is inherited from OCS Inventory.
Basically, the agent POST XML over HTTP to server and get answer in XML. The XML has a unusual structure similar to the one generated by XML::Simple.
The agent get the parameters from the server during a first contact (the prolog). This query is done once, after that every module are launch in a row and are supposed to have enough information to do the job.

During the last year we developed what was supposed to be an abstraction layer on top of this. This lib cost us a lot of time and energy for very poor advantage.

##  The proposal

###  Introduction

##  URL

The agent will sent its first query to $URL like usual by with a GET and a POST

* $URL: the server URL, for example,
    http://glpiserver/glpi/plugins/fusioninventory?action=getConfig&&machineid=$machineid
* $machineid: the machine ID


##  The URL format

This is the recommend URL format:

    http://server/glpi/plugins/fusioninventory/$task?action=$action&machineid=$machineid

* $action: the method name
* $machineid: the machine uniq ID
* $protocol: the protocol revision used, unused for the moment
* additional can be added, it's also possible to push more information through a HTTP POST

##  Error handling

We reuse HTTP error code (400, 500, etc).

##  Initial contact: /?action=getConfig

The config $task will replace the prolog. It goal is:

* inform the agent when each task must be launched or disabled
* when the next /config request must be done

###  Request

To request a new config, the agent use the getConfig method. It also needs to declare what modules are avalaible on this URL:
http://server/glpi/plugins/fusioninventory/?action=getConfig&machineid=$machineid&task[Inventory]=2.18&task[SNMPQuery]=1.3&task[ESX]=1.0.1

* $action: getConfig, the name of the method
* $machineid: machineid
* $task: a key/value array with the modules and their version

###  Answer

Only module in the 'tasks' list are enabled. In this example netdiscovery and snmpquery are turned off. Deploy will be run every 600 second and the inventory task will be started every 10 hours.
The global section is a hash of settings. Here 'global' is defined to give the root directory of the server.

    {
       "schedule" : [
          {
             "periodicity" : 3600,                     ← time in seconds to wait between to call
             "delayStartup" : 600,                   ← time in seconds to wait before the first startup, default is now+periodicity
             "task" : "Inventory",                        ← Task name
             "remote" : "https://server1/plugins/fusioninventory/b"   ← Remote backend URL to contact
          },
          {
             "periodicity" : 600,
             "task" : "Deploy",
             "remote" : "https://server2/deploy"
          },
          {
             "periodicity" : 700,
             "task" : "ESX",
             "remote" : "https://server1/plugins/fusioninventory/b"
          },
          {
             "periodicity" : 5600,
             "task" : "Inventory",
             "remote" : "https://server1/plugins/fusinvinventory/b"
          },
          {
             "periodicity" : 5600,
             "task" : "FooBarAMQPService",
             "remote" : "amqp://server1/plugins/fusinvinventory/b" ← draft for an AMQP interface
          }
       ],
    
       "httpd" : {
          "ip" : "0.0.0.0",
          "trust" : [
             "127.0.0.1"
          ],
          "port" : 62354
       },
       "configValidityPeriod" : 600,   ← How long the agent should keep this configuration
       "requireSSLClientCert" : 1 ← 1 if the agent must ask a SSL cert to the server, in this case it will request a cert from the server See: http://forge.fusioninventory.org/projects/fusioninventory-agent/wiki/API-REST-strong-SSL-support 
    }


##  /wait

Sometime, it's important for the server to be able to contact the agent immediately. For example to request installation at a given time. The method so far is to use the port 62354 
when the agent is behind a NAT connection or a firewall is not possible to use this method

###  Request

The /wait task will be used to keep the agent connected when need. 

http://server/glpi/plugins/fusioninventory?action=wait&machineid=$machineid

###  Answer

The server will send a '@' character to the agent every 25 secondes to keep the connection open. This character has to be ignored by the agent.
If the connection get closed, the agent will retry a connection with the server at a random moment between the disconnection and 10 minutes after. This in order to preserve the server
resource. When the server need to awake the agent it will sent such JSON structure:

    {
       "awake" : {
          "tasks" : [
             "ocsdeploy",
             "inventory"
          ]
       }
    }

In this example, the server asks the agent to run the ocsdeploy task followed by the inventory.

##  Transition

We must keep the compatiblity with the OCS agent. To do so, we need to continue to accept agent on the legacy backend (/ocsinventory).

The legacy agents will continue to use the /ocsinventory back as usual.

The goal here is to migrate the following modules to the REST protocol:

* snmpquery
* netdiscovery

The ocsdeploy module will continue to use the legacy interface. This because there is no plan to use it from GLPI.

###  Inventory

This is a special case. We want to remains compatible with OCS Inventory.
The module works this way:
We use the OCS/XML backend in these cases:

* If the /config gives an errro (HTTP code != 200).
* If inventory is not in the list returned by inventory

##  Example

This is an example of server/agent exchange.

* agent create a deviceid
* agent contact the server (/config) to know each tash must be started and when
* agent planify the tashs executions


##  Advantages

* Easy to redirect requests to a third party applications. For example, data to http://server/glpi/plugins/fusioninventory/toto can be redirected to a third party application writen in Python simply throught a webserver configuration
* Easy to use YAML to send inventories : better performances especially where we currenlty have big XML files
* Easy to make evolutions on some parts of the communication process. For the moment, it's something that is badly missing
* Server can be debbuged using a simple browser
* Test suites will be simplier to implement and maintain
* The whole FusionInventory::Agent::XML could be, in the mid term, moved to the modules that need it

##  Questions / Other

* Guillaume suggested to use a similar mechanism for the agent internal web server.
* If may be interesting to extend the /config to pass a full configuration tree to the agent.
