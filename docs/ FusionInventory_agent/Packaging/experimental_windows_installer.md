---
layout: single
title: FusionInventory agent Microsfot Windows installer
---

# FusionInventory Agent Microsoft Windows Installer

---

## Description

The FusionInventory Agent Microsoft Windows Installer is an open source project than has as goal to build the installer program of the FusionInventory Agent and its tasks for Microsoft Windows operative systems. It makes use of some others open source projects, like the [Nullsoft Scriptable Install System](http://nsis.sourceforge.net/) (in forward NSIS), [Strawberry Perl](http://strawberryperl.com/releases.html), [Curl](http://curl.haxx.se/), etcetera, to obtain its objective.

  It is born to cover a **basic goal**; be able to install new FusionInventory Agent versions based on the previous configuration in the system, whether it exists. In summary, it is born to be able to update the existing agent, and not only to install a new version from scratch.

  It has more purposes, of course. The following are some of them.


## Features

- Installs from scratch or from the current configuration.

- Uninstalls the previous agent, whether it exists.

- Prevents multiple installations simultaneously.

- Supports visual installation in multiple languages.  
(English and Spanish. French in construction.)

- Builds two different installers for x86 and x64 architectures.  
(Each platform uses its native distribution of Strawberry Perl)

- Builds installers for stable or development versions.

- Supports both installation methods; silent or unattended mode and graphical or visual mode.

- Allows to select the agent tasks to install.

- New visual appearance based on the NSIS Modern UI 2 plugin.

- Migrates the depreciated options to the new options and removes completely the obsolete ones from the Microsoft Windows registry.

- Now the Microsoft Windows registry used for agent configuration integrates all the options supported by the agent, and not only those that them values are different to the default.

- Allows a complete customization of all the options supported for the agent, either from the the command line, or from the visual installation.

- Each generated installer is identified uniquely by a BuildID.  
(Each architecture has its own BuildID sequence)

- Allows to execute the agent as a Windows Service, to plan its execution through a Windows Task or, simply, not to execute the agent.

- Allows to pull a SSL certificate from a URL at installation time. (ToDo)


## What do you need

This is than you need to build the installer

- Whether you use Microsoft Windows OS
  - NSIS 2.46

    You can get NSIS 2.46 from http://nsis.sourceforge.net/Download

- Whether you use a Unix OS
  - Curl
  - NSIS 2.46

    Check your distribution for more information about these packages

- In all of cases
  - An Internet connection


## Current state

Nowadays, the contents of the project is:

- FusionInventory Agent v2.3.x
  - FusionInventory Agent Task Deploy v2.0.4
    - FusionInventory Agent Task ESX v2.2.1
    - FusionInventory Agent Task Inventory v1.0
    - FusionInventory Agent Task WakeOnLan v2.0
    - FusionInventory Agent Distribution Network v1.0.2
      - FusionInventory Agent Task NetInventory v2.2.0
      - FusionInventory Agent Task NetDiscovery v2.2.0

  **Note than**, nowadays, FusionInventory Agent 2.3.x is still in development (main branch).

This is the current directory tree of the project.

     .
     |-- NSIS
     |   |-- FusionInventory-Agent
     |   |   |-- Contrib
     |   |   |   |-- Graphics
     |   |   |   |   `-- Icons
     |   |   |   |-- ModernUI2
     |   |   |   |   `-- Pages
     |   |   |   |       `-- Templates
     |   |   |   `-- Skins
     |   |   |       `-- Default
     |   |   |-- Include
     |   |   `-- INI
     |   `-- Plugins
     |-- Perl
     |   `-- Scripts
     `-- Tools
         |-- 7zip
         |   |-- x64
         |   `-- x86
         |-- curl
         |   `-- x86
         |-- dmidecode
         |   `-- x86
         |-- hdparm
         |   `-- x86
         |-- sed
         |   `-- x86
         `-- setacl
             |-- x64
             `-- x86

Inside of *./NSIS/Perl/Scripts* directory there is a set of scripts for download Strawberry Perl Portable Edition v5.16.3.1 (Mar 2013) for [x64](http://strawberryperl.com/download/5.16.3.1/strawberry-perl-5.16.3.1-64bit-portable.zip "Strawberry Perl Portable Edition v5.16.3.1 (Mar 2013) for x64") and [x86](http://strawberryperl.com/download/5.16.3.1/strawberry-perl-5.16.3.1-32bit-portable.zip "Strawberry Perl Portable Edition v5.16.3.1 (Mar 2013) for x86") architectures, update and install all the Perl modules dependencies for the previous FusionInventory Agent packages, and download them.

Please, read the file *./Perl/Scripts/Readme.txt* for more information about these scripts.


### How to generate the installers

Download fusioninventory-agent-windows-installer from GitHub using this URL pattern.

* *https://github.com/tabad/fusioninventory-agent-windows-installer/tarball/&lt;object&gt;*

where <object> may be a tag (or release) name, a branch name or a commit name.

To know the available tags, branches and commits available, please, visit these URL's in that order.

* *https://github.com/tabad/fusioninventory-agent-windows-installer/tags*
* *https://github.com/tabad/fusioninventory-agent-windows-installer/branches*
* *https://github.com/tabad/fusioninventory-agent-windows-installer/commits*

   **Note that**, in the last case, you should select after the wished branch name, or end up the URL with the name of that branch, like this *…-windows-installer/commits/&lt;branch_name&gt;*.

This is an example using cURL to download the last commit of *master* branch.

    $ curl --location --output fusioninventory-agent-windows-installer-master.tar.gz https://github.com/tabad/fusioninventory-agent-windows-installer/tarball/master

Once you have the **.tar.gz* file, uncompress and unpack it. This is an example, continuing the previous one, using tar.

    $ mkdir fusioninventory-agent-windows-installer-master
    $ tar -C fusioninventory-agent-windows-installer-master --strip-components 1 -xf fusioninventory-agent-windows-installer-master.tar.gz

You can also clone the repository whether do you prefer it using Git.

    $ git clone --branch <branch_name> https://github.com/tabad/fusioninventory-agent-windows-installer.git

**Note that** you should change <branch_name> for the name of branch you wish download.

I'm sure you don't need much more explications about Git whether you have chosen this last option.

The following steps depends of your operative system.


### Microsoft Windows

From your Microsoft Windows command interpreter executes

    > cd fusioninventory-agent-windows-installer
    > cd Perl\Scripts
    > .\install-gnu-utilities-collection.bat
    > .\install-strawberry-perl-package-for-fusioninventory-agent.bat
    > .\install-fusioninventory-agent.bat
    > .\patch-fusioninventory-agent.bat
    > .\update-ids-repositories.bat
    > cd ..\..\NSIS
    > .\FusionInventory-Agent.bat

You should be able to see the new installers in that directory.


### Unix OS

    $ cd fusioninventory-agent-windows-installer
    $ chmod 0744 NSIS/*.sh Perl/Scripts/*.sh
    $ cd Perl/Scripts
    $ ./install-strawberry-perl-package-for-fusioninventory-agent.sh
    $ ./install-fusioninventory-agent.sh
    $ ./patch-fusioninventory-agent.sh
    > ./update-ids-repositories.sh
    $ cd ../../NSIS
    $ ./FusionInventory-Agent.sh

You should be able to see the new installers in that directory.


## How to build the Strawberry Perl Portable Edition Package for FusionInventory Agent

**This task can be done only from Microsoft Windows OS (x64).**


### Microsoft Windows


From your Microsoft Windows command interpreter executes

    > cd fusioninventory-agent-windows-installer
    > cd Perl\Scripts
    > .\install-gnu-utilities-collection.bat
    > .\install-strawberry-perl.bat
    > .\install-perl-modules-and-dependencies.bat
    > .\delete-perl-modules-and-dependencies-temporary-files.bat
    > .\build-strawberry-perl-package-for-fusioninventory-agent.bat
    > .\uninstall-strawberry-perl.bat

The script *build-strawberry-perl-package-for-fusioninventory-agent.bat* will show to you where is the built package.

Please, read ***How to know whether is needed to build a new Strawberry Perl Portable Edition Package for FusionInventory Agent*** below for more information.


## How to upgrade the Strawberry Perl distribution

Let's look at an example.

Suppose has been released the new Strawberry Perl Nov 2012 Portable Edition (5.16.2.1-32/64bits). Nowadays (Nov 09, 2012), the installers are run on Strawberry Perl Aug 2012 Portable Edition (5.16.1.1-32/64bits) and you want to upgrade it. These are the steps you should carry out.

Update variables *strawberry_version* and *strawberry_release* of file *./Perl/Scripts/load-perl-environment* to reflect the new values.

    -declare -r strawberry_version='5.16.1.1'
    -declare -r strawberry_release='Aug 2012'
    +declare -r strawberry_version='5.16.2.1'
    +declare -r strawberry_release='Nov 2012'

   Update constant *STRAWBERRY_RELEASE* of file *./NSIS/FusionInventory.nsi* to adapt it to its new value:

    -!define STRAWBERRY_RELEASE "5.16.1.1"
    +!define STRAWBERRY_RELEASE "5.16.2.1"

And finally, rebuild the installers.

**Remember**, probably you also will need to build a new Strawberry Perl Portable Edition Package for FusionInventory Agent.


## How to upgrade the agent

Let's look at an example.

Suppose you know there are new stable release for FusionInventory-Agent. You have the builder ready to build the installers with FusionInventory-Agent v2.3.0 (it is also an assumption) so you want to change it to get the installers with the last releases.

In GitHub you can find all releases of FusionInventory-Agent. In <https://github.com/fusioninventory/> are registered most of the projects of FusionInventory but here we are only interested in one of them. It is, with its URL, the following

* FusionInventory-Agent  
<https://github.com/fusioninventory/fusioninventory-agent>

You can see the tag (or release) names, the branch names or the commit names of this project the same way you see them of this one. For more information, see section ***How to generate the installers*** above.

By taking a look at <https://github.com/fusioninventory/fusioninventory-agent/tags> you see that new release is v2.3.1 (it is also an assumption). These are the changes you should to carry out.

Edit the *./Perl/Scripts/load-perl-environment* file and change the value of variable *fusinv_agent_commit* to *2.3.1*. The other variables (*fusinv_agent_mod_name* and *fusinv_agent_repository*) should maintain its values, unless there are changes in GitHub.

    -declare +r fusinv_agent_commit='2.3.0'
    +declare +r fusinv_agent_commit='2.3.1'

**Note that**, in these cases, *2.3.1* is a *tag* in Git terminology; that is, in our case, stable releases. A tag makes reference, in last term, to a commit, therefore the name of the variable.

An important thing to take into account is that, probably, this new release require new, or simply different, Perl modules. Whether it is so, you should build a new Strawberry Perl Portable Edition Package for FusionInventory Agent. But before to do that, you should carry out two actions; a) to increase the package build identifier and b) to update the list of required and recommended Perl modules.

To do the first one is easy, you only need to edit the *.\Perl\Script\load-perl-environment* and to increment it in a unit.

    -declare -r strawberry_pepfia_build_id='1'
    +declare -r strawberry_pepfia_build_id='2'

**Note that** the variable *strawberry_pepfia_branch* is not necessary to change it in this case since the branch 2.3.x match with the branch of FusionInventory-Agent release 2.3.1.

**Remember that** you should reset *strawberry_pepfia_build_id* to *1* whether you upgrade the Strawberry Perl distribution.

The second one is, most of the times, more tedious. You should check whether there is new requirements or recommendations comparing the file *Makefile.PL* of the FusionInventory-Agent package you want to update. Then, whether there are changes, you must update the respective variable *fusinv_agent_mod_dependences* of *./Perl/Scripts/load-perl-environment* file to reflect these changes.

**Remember that**, probably, you also need to update these variables whether you have upgraded the Strawberry Perl distribution.

Let's look at an example for FusionInventory-Agent.

In <https://github.com/fusioninventory/fusioninventory-agent/tags> you can see all stable releases of FusionInventory-Agent. In that, below *2.3.1.zip - 2.3.1 release* appears the sequence *6f67b7d6f6* (it is an assumption); the short form for its SHA1 commit.  Do click on it, and after, do click on *Browse code* (up and right). In the list of files that appears, do click on file *Makefile.PL* and write down the list of required and recommended Perl modules (those lines started by *requires …* and *recommends …*, but not those lines started by *text_requires …*) commons to all operative systems and those specific for Microsoft Windows (those lines under the condition *($OSNAME eq 'MSWin32')*). This list of Perl modules should be the new value of the variable *fusinv_agent_mod_dependences*. Like this list is different of that for 2.3.0 release (repeat the previous process for '2.3.0.zip - 2.3.0 release') you need change the value of the variable *fusinv_agent_mod_dependences*.

    -declare -r fusion_agent_mod_dependences='Archive::Extract Crypt::DES
     Compress::Zlib Digest::MD5 Digest::SHA File::Copy::Recursive
     File::Which HTTP::Daemon IO::Socket::SSL JSON LWP LWP::Protocol::https
     Net::IP Net::NBName Net::SNMP Parse::EDID POE::Component::Client::Ping
     Socket::GetAddrInfo Text::Template UNIVERSAL::require URI::Escape
     Win32::Daemon Win32::Job Win32::OLE Win32::TieRegistry XML::TreePP'
    +declare -r fusion_agent_mod_dependences='Archive::Extract Crypt::DES
     Compress::Zlib Digest::MD5 Digest::SHA File::Copy::Recursive
     File::Which HTTP::Daemon IO::Socket::SSL JSON LWP LWP::Protocol::https
     Net::IP Net::NBName Net::SNMP Net::Write::Layer2 Parse::EDID
     POE::Component::Client::Ping Socket::GetAddrInfo Text::Template
     UNIVERSAL::require URI::Escape Win32::Daemon Win32::Job Win32::OLE
     Win32::TieRegistry XML::TreePP'

**Note that** they are only two lines.

As the list of modules for FusionInventory-Agent has changed, it is necessary to generate a new Strawberry Perl Portable Edition Package.

You should start with a clean Strawberry Perl distribution too, so the recommended steps are:

**Remember***, this task can be done only from Microsoft Windows OS.

    > cd fusioninventory-agent-windows-installer
    > cd Perl\Scripts
    > .\install-gnu-utilities-collection.bat
    > .\uninstall-strawberry-perl.bat
    > .\install-strawberry-perl.bat
    > .\install-perl-modules-and-dependencies.bat
    > .\delete-perl-modules-and-dependencies-temporary-files.bat
    > .\build-strawberry-perl-package-for-fusioninventory-agent.bat

Now you can load the new package and its associated files into your public repository of Strawberry Perl Portable Edition Packages for FusionInventory Agent. This can be a local repository; you only have to change the *strawberry_pepfia_url* variable of the file *./Perl/Scripts/load-perl-environment*. For example, to leave the default directory as the default repository, you only have to do the following:

    -declare -r strawberry_pepfia_url='https://sourceforge.net/projects/fiawi/fil
     es/strawberry-perl-packages
    +declare -r strawberry_pepfia_url='file://c/.../fusioninventory-agent-windows
     -installer/Perl/Strawberry'

Note that they are only two lines.

Remember, *file://* is dependent of the OS and must be written as an absolute path. Make sure, in any case, that the value of the *strawberry_pepfia_url* variable is correct.

Finally, you should change the following constants of the file *./NSIS/FusionInventory.nsi* to adapt them to their new values:

    FIA_RELEASE
    FIA_TASK_DEPLOY_RELEASE
    FIA_TASK_ESX_RELEASE
    FIA_TASK_INVENTORY_RELEASE
    FIA_TASK_NETWORK_RELEASE
    FIA_TASK_NETDISCOVERY_RELEASE
    FIA_TASK_NETINVENTORY_RELEASE
    FIA_TASK_WAKEONLAN_RELEASE
    
    PRODUCT_VERSION_MAJOR
    PRODUCT_VERSION_MINOR
    PRODUCT_VERSION_RELEASE
    PRODUCT_VERSION_BUILD

They are at the beginning of the file. Following the example,

    -!define FIA_RELEASE "2.3.0"
    +!define FIA_RELEASE "2.3.1"
    
    -!define PRODUCT_VERSION_RELEASE "0"
    +!define PRODUCT_VERSION_RELEASE "1"

Note that you can find out these release numbers searching the *VERSION* variable inside *./Perl/Strawerry/<arch>/cpan/sources/FusionInventory-Agent-<fusinv_agent_commit>/lib/FusionInventory/Agent/Task/*.pm* files.

With the new Strawberry Perl Portable Edition Package for FusionInventory Agent ready, and these last changes, you can continue as it were a normal build process. See ***How to generate the installers*** above.


## How to know whether is needed to build a new Strawberry Perl Portable Edition Package for FusionInventory Agent

Basically you should check whether there is new requirements or recommendations comparing the file *Makefile.PL* of the FusionInventory-Agent package you want to update. Then, whether there are changes, you must update the variable *fusinv_agent_mod_dependences* of *./Perl/Scripts/load-perl-environment* file to reflect these changes.

Probably you also will need to build a new Strawberry Perl Portable Edition Package for FusionInventory Agent whether you have upgraded the Strawberry Perl distribution.

See ***How to upgrade the agent and its tasks*** above for more information.


## How to build the installers for a development version of FusionInventory-Agent

The process is very similar to that described in ***How to upgrade the agent and its tasks***. Then you chose a new stable release and, in this case, you choose a branch name or a commit name.

Let's look at an example about how to build the installers for the development branch *master* related with the 2.4.x series (it is an assumption) supposing you have the builder ready to build the installer for FusionInventory-Agent v2.3.1.

Edit the *./Perl/Scripts/load-perl-environment* file and carry out these changes.

    -declare -r strawberry_pepfia_branch='2.3.x'
    +declare -r strawberry_pepfia_branch='2.4.x'
    -declare -r strawberry_pepfia_build_id='2'
    +declare -r strawberry_pepfia_build_id='1'
       ...
    -declare +r fusinv_agent_commit='2.3.1'
    +declare +r fusinv_agent_commit='master'
       ...
    
    -declare -r fusion_agent_mod_dependences='Archive::Extract Crypt::DES
     Compress::Zlib Digest::MD5 Digest::SHA File::Copy::Recursive
     File::Which HTTP::Daemon IO::Socket::SSL JSON LWP LWP::Protocol::https
     Net::IP Net::NBName Net::SNMP Net::Write::Layer2 Parse::EDID
     POE::Component::Client::Ping Socket::GetAddrInfo Text::Template
     UNIVERSAL::require URI::Escape Win32::Daemon Win32::Job Win32::OLE
     Win32::TieRegistry XML::TreePP'
    +declare -r fusion_agent_mod_dependences='Archive::Extract Crypt::DES
     Compress::Zlib Digest::MD5 Digest::SHA File::Copy::Recursive
     File::Which HTTP::Daemon IO::Socket::SSL JSON LWP LWP::Protocol::https
     Net::IP Net::NBName Net::SNMP Net::Write::Layer2 PAR::Parcker Parse::EDID
     POE::Component::Client::Ping Socket::GetAddrInfo Text::Template
     UNIVERSAL::require URI::Escape Win32::Daemon Win32::Job Win32::OLE
     Win32::TieRegistry XML::TreePP'

As the list of modules for FusionInventory-Agent has changed, it is necessary to generate a new Strawberry Perl Portable Edition Package.

You should start with a clean Strawberry Perl distribution too, so the recommended steps are:

**Remember**, this task can be done only from Microsoft Windows OS.

    > cd fusioninventory-agent-windows-installer
    > cd Perl\Scripts
    > .\install-gnu-utilities-collection.bat
    > .\uninstall-strawberry-perl.bat
    > .\install-strawberry-perl.bat
    > .\install-perl-modules-and-dependencies.bat
    > .\delete-perl-modules-and-dependencies-temporary-files.bat
    > .\build-strawberry-perl-package-for-fusioninventory-agent.bat
    > .\uninstall-strawberry-perl.bat

Now you can load the new package and its associated files into your public repository of Strawberry Perl Portable Edition Packages for FusionInventory Agent. This can be a local repository; you only have to change the *strawberry_pepfia_url* variable of the file *./Perl/Scripts/load-perl-environment*.

Finally, you should change the following constants of the file *./NSIS/FusionInventory.nsi* to adapt them to their new values:

    FIA_RELEASE
    FIA_TASK_DEPLOY_RELEASE
    FIA_TASK_ESX_RELEASE
    FIA_TASK_INVENTORY_RELEASE
    FIA_TASK_NETWORK_RELEASE
    FIA_TASK_NETDISCOVERY_RELEASE
    FIA_TASK_NETINVENTORY_RELEASE
    FIA_TASK_WAKEONLAN_RELEASE
    
    PRODUCT_VERSION_MAJOR
    PRODUCT_VERSION_MINOR
    PRODUCT_VERSION_RELEASE
    PRODUCT_VERSION_BUILD

They are at the beginning of the file. Following the example,

    -!define FIA_RELEASE "2.3.1"
    +!define FIA_RELEASE "master"
    
    -!define PRODUCT_VERSION_MINOR "3"
    -!define PRODUCT_VERSION_RELEASE "1"
    +!define PRODUCT_VERSION_MINOR "4"
    +!define PRODUCT_VERSION_RELEASE "2013030702"

**Note that** all *PRODUCT_VERSION_\** constants must have a numeric value. Here I have followed the pattern *YYYYMMDD##*, where *YYYYMMDD* is the date of creation of the installer and *##* is the sequence number of the Installer generated on that date (this value can take the values [01-99]). You can choose any other number or pattern you like.

With the new Strawberry Perl Portable Edition Package for FusionInventory Agent ready, and these last changes, you can continue as it were a normal build process. See 'How to generate the installers' above.

The branch *master* and commit *f3f9382a18659d1fff602ae04e816a1a4221c369* (it is also an assumption) reflect the same state. The following example build the same installer but choosing the commit *f3f9382a18659d1fff602ae04e816a1a4221c369* instead of branch *master*.

Edit the *./Perl/Scripts/load-perl-environment* file and carry out these changes.

    -declare -r strawberry_pepfia_branch='2.3.x'
    +declare -r strawberry_pepfia_branch='2.4.x'
    -declare -r strawberry_pepfia_build_id='2'
    +declare -r strawberry_pepfia_build_id='1'
       ...
    -declare +r fusinv_agent_commit='2.3.1'
    +declare +r fusinv_agent_commit='f3f9382a18659d1fff602ae04e816a1a4221c369'
       ...
    
    -declare -r fusion_agent_mod_dependences='Archive::Extract Crypt::DES
     Compress::Zlib Digest::MD5 Digest::SHA File::Copy::Recursive
     File::Which HTTP::Daemon IO::Socket::SSL JSON LWP LWP::Protocol::https
     Net::IP Net::NBName Net::SNMP Net::Write::Layer2 Parse::EDID
     POE::Component::Client::Ping Socket::GetAddrInfo Text::Template
     UNIVERSAL::require URI::Escape Win32::Daemon Win32::Job Win32::OLE
     Win32::TieRegistry XML::TreePP'
    +declare -r fusion_agent_mod_dependences='Archive::Extract Crypt::DES
     Compress::Zlib Digest::MD5 Digest::SHA File::Copy::Recursive
     File::Which HTTP::Daemon IO::Socket::SSL JSON LWP LWP::Protocol::https
     Net::IP Net::NBName Net::SNMP Net::Write::Layer2 PAR::Parcker Parse::EDID
     POE::Component::Client::Ping Socket::GetAddrInfo Text::Template
     UNIVERSAL::require URI::Escape Win32::Daemon Win32::Job Win32::OLE
     Win32::TieRegistry XML::TreePP'

**Note that** the installer always works with short commit names. See variable *maximum_commit_length* to know what this length is (by default it is 10). All commit names will be truncated to this length.

Like before, it is necessary to generate a new Strawberry Perl Portable Edition Package. And like before, you should change the following constants of the file *./NSIS/FusionInventory.nsi* to adapt them to their new values:

    -!define FIA_RELEASE "2.3.1"
    +!define FIA_RELEASE "f3f9382a18"
    
    -!define PRODUCT_VERSION_MINOR "3"
    -!define PRODUCT_VERSION_RELEASE "1"
    +!define PRODUCT_VERSION_MINOR "4"
    +!define PRODUCT_VERSION_RELEASE "2013030702"

With the new Strawberry Perl Portable Edition Package for FusionInventory Agent ready, and these last changes, you can continue as it were a normal build process. See ***How to generate the installers*** above.


## Contacts

### Project websites
* Main site  
<http://www.fusioninventory.org>
* Forge  
<http://forge.fusioninventory.org/projects/fusioninventory-agent-windows-installer>

### Project mailing lists
* User list  
<http://lists.alioth.debian.org/mailman/listinfo/fusioninventory-user>
* Developer list  
<http://lists.alioth.debian.org/mailman/listinfo/fusioninventory-devel>
* Translator list  
<http://lists.alioth.debian.org/mailman/listinfo/fusioninventory-i18n>

### Project IRC channel
* *#FusionInventory* on [FreeNode](http://irc.freenode.net/) IRC Network

Please report any issues on project forge bugtracker (see forge URL above).


## Repositories

### Public Git repositories

* GitHub  
<https://github.com/tabad/fusioninventory-agent-windows-installer/>
* SourceForge  
<http://sourceforge.net/p/fiawi/code/>

### Public Strawberry Perl Portable Package repositories

* SourceForge  
<http://sourceforge.net/projects/fiawi/files/strawberry-perl-packages/>

### Public experimental intallers repositories

* SourceForge  
<https://sourceforge.net/projects/fiawi/files/>


## Author

* Tomás Abad  
<tabadgp@gmail.com>

      Copyright 2012 FusionInventory Team


## License

This software is licensed under the terms of GPLv2+, see License.txt file for
details.
