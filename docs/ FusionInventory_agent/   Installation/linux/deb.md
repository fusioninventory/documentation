# Installation on Debian and Ubuntu

## METHOD 1: manually install FusionInventory Sid packages

Latest FusionInventory Agent Debian and Ubuntu compatible packages are now integrated in Debian Sid.

At the time of this writing, fusioninventory-agent_2.5.2-1 is available from [github release](https://github.com/fusioninventory/fusioninventory-agent/releases).

The agent will be included in Debian Buster (Debian 10) planed to be released on 2019 jul 06.

!!! info
    <table>
    <thead>
        <tr class='header'>
            <th>Tested Debian version</th>
            <th>Agent version</th>
            <th>&nbsp;</th>
            <th>Tested Ubuntu version</th>
            <th>Agent version</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>Buster - Debian 10 - Stable</td>
            <td>2.5.2-1</td>
            <td>&nbsp;</td>
            <td>Ubuntu 18.04.1 LTS (bionic)</td>
            <td>2.5.2-1</td>
        </tr>
        <tr>
            <td>Stretch - Debian 9 - OldStable</td>
            <td>2.5.2-1</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
    </tbody>
    </table>

### Install dependencies as root :

For fusioninventory-agent, you'll need to install these dependencies:

``` shell
apt -y install dmidecode hwdata ucf hdparm
apt -y install perl libuniversal-require-perl libwww-perl libparse-edid-perl
apt -y install libproc-daemon-perl libfile-which-perl libhttp-daemon-perl
apt -y install libxml-treepp-perl libyaml-perl libnet-cups-perl libnet-ip-perl
apt -y install libdigest-sha-perl libsocket-getaddrinfo-perl libtext-template-perl
apt -y install libxml-xpath-perl libyaml-tiny-perl
```

For fusioninventory-agent-task-network, you'll need to install these other dependencies:

``` shell
apt -y install libnet-snmp-perl libcrypt-des-perl libnet-nbname-perl
```

If you need SNMPv3 support for network inventory, you should also install this one:

``` shell
apt -y install libdigest-hmac-perl
```

For fusioninventory-agent-task-deploy, you'll need to install these other dependencies:

``` shell
apt -y install libfile-copy-recursive-perl libparallel-forkmanager-perl
```

If you need to run WakeOnLan task, you'll need to instal this other dependency:

``` shell
apt -y install libwrite-net-perl
```

### Download desired packages from [Deb fusioninventory-agent tracker](https://tracker.debian.org/pkg/fusioninventory-agent) :

Packages|Included tasks
--------|--------------
[fusioninventory-agent_2.5.2-1_all.deb](https://github.com/fusioninventory/fusioninventory-agent/releases/download/2.5.2/fusioninventory-agent_2.5.2-1_all.deb)|Inventory - WakeOnLan
[fusioninventory-agent-task-collect_2.5.2-1_all.deb](https://github.com/fusioninventory/fusioninventory-agent/releases/download/2.5.2/fusioninventory-agent-task-collect_2.5.2-1_all.deb)|Collect
[fusioninventory-agent-task-network_2.5.2-1_all.deb](https://github.com/fusioninventory/fusioninventory-agent/releases/download/2.5.2/fusioninventory-agent-task-network_2.5.2-1_all.deb)|NetDiscovery - NetInventory
[fusioninventory-agent-task-deploy_2.5.2-1_all.deb](https://github.com/fusioninventory/fusioninventory-agent/releases/download/2.5.2/fusioninventory-agent-task-deploy_2.5.2-1_all.deb)|Deploy
[fusioninventory-agent-task-esx_2.5.2-1_all.deb](https://github.com/fusioninventory/fusioninventory-agent/releases/download/2.5.2/fusioninventory-agent-task-esx_2.5.2-1_all.deb)|ESX

### Install desired packages as root :

Only fusioninventory-agent deb package is mandatory

``` shell
dpkg -i fusioninventory-agent_2.5.2-1_all.deb
dpkg -i fusioninventory-agent-task-collect_2.5.2-1_all.deb
dpkg -i fusioninventory-agent-task-network_2.5.2-1_all.deb
dpkg -i fusioninventory-agent-task-deploy_2.5.2-1_all.deb
dpkg -i fusioninventory-agent-task-esx_2.5.2-1_all.deb
```

### Configure the agent :

Edit `/etc/fusioninventory/agent.cfg` setting at least one target

### Start the agent :

``` shell
systemctl restart fusioninventory-agent
```

### On configuration change, reload the agent :

``` shell
systemctl reload fusioninventory-agent
```

### To start an immediate run :

You can send USR1 signal to the process with the following command to start a run immediatly :

``` shell
pkill -USR1 -f -P 1 fusioninventory-agent
```

## METHOD 2: using FusionInventory Debian (and Ubuntu) packages:

These packages are based on deprecated source versions.

!!! info
    <table>
    <thead>
        <tr class='header'>
            <th>Debian version</th>
            <th>Agent version</th>
            <th>&nbsp;</th>
            <th>Ubuntu version</th>
            <th>Agent version</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>Wheezy - Debian 7 - OldStable</td>
            <td>2.2.3-8</td>
            <td>&nbsp;</td>
            <td>Ubuntu 16.04.2 LTS (xenial)</td>
            <td>2.3.16-1</td>
        </tr>
        <tr>
            <td>Jessie - Debian 8 - Stable</td>
            <td>2.3.10.1-1</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>Sid - Unstable</td>
            <td>2.3.16-1</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
    </tbody>
    </table>


### Install Agent 2.3.10 on Debian 7 using debian-backports repository

``` shell
echo "deb http://httpredir.debian.org/debian wheezy-backports main" >> /etc/apt/sources.list
apt-get update
apt-get install -t wheezy-backports fusioninventory-agent
```

### Install Agent 2.3.16 from old FusionInventory repository

!!! info
    Tested on Debian 7 - Wheezy, Debian 8 - Jessie, Debian 9 - Stretch/Testing
    
    Debian packaging for recent version is under developement" %}


The FusionInventory project maintained a debian package until 2.3.16 version, in a extra repository.

First, you need to import the repository GnuPG key, if apt-key is available you can use these command as root:

``` shell
apt-key adv --keyserver keyserver.ubuntu.com --recv 049ED9B94765572E
```

Otherwise this one will work:

``` shell
wget -O - http://debian.fusioninventory.org/debian/archive.key | apt-key add -
```

Now you can install the agent.

``` shell
apt-get install lsb-release
echo "deb http://debian.fusioninventory.org/debian/ `lsb_release -cs` main" >> /etc/apt/sources.list
apt-get update
apt-get install fusioninventory-agent
```

Note: On Debian Testing, you need to fix the `/etc/apt/sources.list` update so you use jessie repo. You can better replace the second line from the previous commands with:

``` shell
echo "deb http://debian.fusioninventory.org/debian/ jessie main" >> /etc/apt/sources.list
```

The content of the [dists](http://debian.fusioninventory.org/debian/dists/) pages can help you do identify support operating system.

### Install the additional packages

Network inventory tasks:

``` shell
apt-get install fusioninventory-agent-task-network
```

ESX inventory task:

``` shell
apt-get install fusioninventory-agent-task-esx
```

Deploy task:

``` shell
apt-get install fusioninventory-agent-task-deploy
```

## METHOD 3

!!! info
    <table>
    <thead>
        <tr class='header'>
            <th>Tested date</th>
            <th>Agent version</th>
            <th>Debian version</th>
            <th>Tested date</th>
            <th>Agent version</th>
            <th>Debian version</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>2017/06/07</td>
            <td>2.3.20</td>
            <td>Debian 8 minimal</td>
            <td>2017/05/22</td>
            <td>2.3.19</td>
            <td>Debian 8 minimal</td>
        </tr>
        <tr>
            <td>2017/06/07</td>
            <td>2.3.20</td>
            <td>Debian 9 minimal (stretch/testing)</td>
            <td>2017/05/22</td>
            <td>2.3.19</td>
            <td>Debian 9 minimal (stretch/testing)</td>
        </tr>
        <tr>
            <td>2017/06/07</td>
            <td>2.3.20</td>
            <td>Ubuntu 16.04.2 LTS (xenial)</td>
            <td>2017/05/22</td>
            <td>2.3.18</td>
            <td>Debian 9 minimal (stretch/testing)</td>
        </tr>
    </tbody>
    </table>

## Install from source

### Install dependencies :   

``` shell
apt-get -y install wget dmidecode make hwdata
apt-get -y install perl perl-modules libmodule-build-perl libmodule-install-perl
apt-get -y install libfile-which-perl libfile-copy-recursive-perl libuniversal-require-perl
apt-get -y install libtest-http-server-simple-perl libhttp-server-simple-authen-perl libhttp-proxy-perl
apt-get -y install libio-capture-perl libipc-run-perl libnet-snmp-perl
apt-get -y install libtest-compile-perl libtest-deep-perl libtest-exception-perl
apt-get -y install libtest-mockmodule-perl libtest-mockobject-perl libtest-nowarnings-perl
apt-get -y install libxml-treepp-perl libproc-daemon-perl
apt-get -y install libparallel-forkmanager-perl libnet-ip-perl libparse-edid-perl
apt-get -y install libdigest-sha-perl libtext-template-perl libsocket-getaddrinfo-perl
```

### Download

``` shell
wget https://github.com/fusioninventory/fusioninventory-agent/releases/download/2.4.2/FusionInventory-Agent-2.4.2.tar.gz
tar xvzf FusionInventory-Agent-2.4.2.tar.gz
cd FusionInventory-Agent-2.4.2
```

### Build and install

``` shell
perl Makefile.PL
make
make install
```

### Configure
- edit `/usr/local/etc/fusioninventory/agent.cfg`

### Install agent as service

#### Create systemd service
Edit `/etc/systemd/system/fusioninventory-agent.service` file setting this content:

``` ini
[Unit]
Description=FusionInventory agent
Documentation=man:fusioninventory-agent
After=syslog.target network.target
    
[Service]
ExecStart=/usr/local/bin/fusioninventory-agent --daemon --no-fork
ExecReload=/bin/kill -HUP $MAINPID
    
[Install]
WantedBy=multi-user.target
```

_P.S.: You can also fix and copy `contrib/unix/fusioninventory-agent.service` from source_

#### Enable the service

``` shell
systemctl enable fusioninventory-agent
```

#### Start the service

``` shell
    systemctl start fusioninventory-agent
```

_P.S.: The service will not start if no target is setup in `/usr/local/etc/fusioninventory/agent.cfg`_
