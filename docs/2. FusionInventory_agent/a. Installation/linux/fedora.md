---
layout: single
title: Installation on Fedora
---

# Maintained Fedora version

*fusioninventory-agent* is part of the *official repository* for Fedora. 2.4 agent releases will only be available for Fedora >= 28.

# Non maintained Fedora version

Since there has been many changes in the configuration beetween 2.3 and 2.4 releases; you will have to use our [COPR repository](https://copr.fedorainfracloud.org/coprs/trasher/fusioninventory-agent) to get 2.4 series agent on Fedora 26 and 27.

To install and activate the repository; run:

    $ sudo dnf copr enable trasher/fusioninventory-agent

If the above command does not work, ensure package "dnf-plugins-core" is installed.

# Agent installation

Agent installation:

    $ sudo dnf install fusioninventory-agent

Only *fusioninventory-agent* is mandatory, other packages are additional tasks.

You can also install the *yum plugin* which will request a inventory after each yum operation

    $ sudo dnf install fusioninventory-agent-yum-plugin

If the latest release is not available in stable repositories, you may check on testing:

    $ sudo dnf --enablerepo=updates-testing install fusioninventory-agent
