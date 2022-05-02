---
layout: single
title: Installation on RHEL, CentOS and other RHEL clones
---

# Agent 2.4.x/2.5.x

Due to several configuration changes since 2.4 series, RPM for 2.4 or 2.5 releases of the agent are not available from EPEL repository; you'll have to use our [COPR repository](https://copr.fedorainfracloud.org/coprs/trasher/fusioninventory-agent).

To get it installed, run:

    $ sudo yum copr enable trasher/fusioninventory-agent

If the above command does not work, ensure package "yum-plugin-copr" is installed.

If, for any reason, the copr plugin is not available, go to the [COPR repository](https://copr.fedorainfracloud.org/coprs/trasher/fusioninventory-agent) page, click on "Repo Download" button for your version, and put down the file in `/etc/yum.repos.d/` directory.

# RHEL/Centos 8.x

The FusionInventory team maintains RPM packages in the [EPEL repository](https://fedoraproject.org/wiki/EPEL).
Once the repository is installed, you also need to enable another repository:

For RHEL 8 users with certificate subcriptions, you need to enable 'codeready-builder' repository:

    # subscription-manager repos --enable "codeready-builder-for-rhel-8-$(arch)-rpms"

For CenOS 8 users, you need to enable 'PowerTools' repository:

    # dnf config-manager --set-enabled PowerTools

Than just run:

    # dnf install fusioninventory-agent fusioninventory-agent-task-inventory

If you plan to use agent in daemon mode (default), don't forget to start the service and enable it:

    # systemctl start fusioninventory-agent
    # systemctl enable fusioninventory-agent

# RHEL/Centos 7.x

The FusionInventory team maintains RPM packages in the [EPEL repository](https://fedoraproject.org/wiki/EPEL).
Once the repository is installed, just run:

    # yum install fusioninventory-agent fusioninventory-agent-task-inventory

If you plan to use agent in daemon mode (default), don't forget to start the service and enable it:

    # systemctl start fusioninventory-agent
    # systemctl enable fusioninventory-agent

# RHEL/Centos 6.x

The FusionInventory team maintains RPM packages in the [EPEL repository](https://fedoraproject.org/wiki/EPEL).
Once the repository is installed, just run:

    # yum install fusioninventory-agent fusioninventory-agent-task-inventory

If you plan to use agent in daemon mode (default), don't forget to start the service and enable it:

    # service fusioninventory-agent start
    # chkconfig fusioninventory-agent on

# RHEL/Centos 5.x

An old *fusioninventory-agent* package was provided by FusionInventory
team. You can retrieve it from [openSUSE Build
Service](https://build.opensuse.org/project/show?project=home%3Aguillomovitch).

Beware, you'all also need the *EPEL* repository. See [EPEL wiki](https://fedoraproject.org/wiki/EPEL) for details.

Agent installation:

    # yum install fusioninventory-agent fusioninventory-agent-task-inventory
