---
layout: single
title: Deploy / self-service mode
---

# Introduction

This feature was added in version 9.1+1.0 of plugin FusionInventory for GLPI.

The goal is the technicians prepare packages to deploy, not deploy them  but give possibility to 
end users to install themselves.

{% include info.html param="<em>Example:</em><br/>
A technician create a Gimp package and the end user <em>toto</em> want install Gimp.
He log in GLPI and select Gimp to install on his computer ;)" %}


# How to enable self-service of a package

You create a package.

* In package form, you have an option _Enable self-service in defining computer group_: this option define a dynamic group of computers, so the computers where it can be installed.
* In tab _Targer for self-service_, select who can install on his computer: define a _profile_, an _entity_, a _user group_ or a _user_
* In the profile (profiles of simplified interface only), there is a tab _FusionInventory_ and you must select _Self deploy package_ to read

# User want install

When the user connect to GLPI, he must go in menu _plugins_ > _FusionInventory_. 
He see the computer (or the computers) where he is user (see _user_ field in computer form) and he can select the package(s) he want install on the computer.

If the user do this on his computer (browser connected to GLPI on his computer) and agent is in daemon mode, after click on button _Prepare for install_, the browser will force the agent to contact the server to install the package(s) now. 
So wait couple of seconds and it will be installed ;)



