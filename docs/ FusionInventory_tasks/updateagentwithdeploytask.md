---
layout: single
title: Update FusionInventory agent through a deploy task
---

The basic problem with updating the agent through a deployment task is the agent will have to uninstall itself while in use, thus throwing some errors.

A good method to update the agent without errors is to create a scheduled task that will update the agent to it's latest version onboot.

Let's first create a fusioninventory SFX package containing both x64 and x86 versions, and that maybe used to install a new agent or update an existing one, regardless of the architecture.

You'll need the latest stable version of 7zSD SFX that you can get [here](http://7zsfx.info/en/).
The file 7zSD.sfx needs to be ressource hacked so it will ask for UAC privileges when executed.
You may find all necessary files (pre-ressource hacked) and scripts [here](http://www.netpower.fr).

Basically we'll create a SFX package containing the following three files:
* fusioninventory-agent_windows-x86_x.yy.zz.exe
* fusioninventory-agent_windows-x64_x.yy.zz.exe
* install.cmd

The install.cmd script will contain all the necessary information to install / update a FusionInventory Agent (see below).

You'll have to create a 7zip archive of those three files with the following command (providing you already have 7z.exe):

    ..\7z a -r FUSIONINV.7z *.*

The archive has to be linked together with the SFX module and a SFX configuration file. 
We'll create a config file named sfx_config.txt and containing the following:

    ;!@Install@!UTF-8!
    Title="Installation FusionInventory"
    RunProgram="x86:install.cmd" 
    RunProgram="x64:install.cmd" 
    SelfDelete="1"
    ;!@InstallEnd@!

Then we can create the package with the following command:

    copy /b 7zSD.sfx + sfx_config.txt + FUSIONINV.7z FUSIONINV.EXE

