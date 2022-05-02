---
layout: single
title: How to install the development version on Unix platform
---

# How to install the developement version on Unix platform

## Installing Perl

### Perl runtime

It should already be present on any Unix system.

### Additional Perl modules

From a terminal, install the following additional modules using cpanplus shell (cpanp):

* XML::TreePP
* UNIVERSAL::require
* File::Which
* Text::Template

    $ cpanp
    CPAN Terminal> install XML::TreePP

## Installing the agent

### From an archive file

You can download latest git content as a .tar.gz file from [github web interface](https://github.com/fusioninventory/fusioninventory-agent/downloads).

### From git repository

From a terminal, clone the repository using git client:

    $ git clone git://github.com/fusioninventory/fusioninventory-agent
    $ cd agent

## Check the dependencies

    $ perl Makefile.PL

You can use either, your OS packages, cpanp or cpanm to install the missing dependencies.

## Running the agent

You can run the agent directly from extraction directory

    [guillaume@beria agent.git]$ ./bin/fusioninventory-agent --stdout
