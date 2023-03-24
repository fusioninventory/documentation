# How to setup a FusionInventory agent on windows from sources


## Get Perl

Download the latest version of [Strawberry Perl](http://strawberryperl.com/) and install it.

## Install the additional perl modules

Launch Perl command line (from Windows Start Menu) and launch CPAN plus shell: cpanp

![](../../assets/agent/installation/windows/from_sources-1.png)

Install the following perl modules: `install <module>`

* XML::TreePP
* UNIVERSAL::require
* File::Which
* Text::Template

![](../../assets/agent/installation/windows/from_sources-2.png)

## Retrieve the agent

### From source tarball

You can download latest git content as a [.zip file from github](https://github.com/fusioninventory/fusioninventory-agent/downloads) web interface.

### From git repository

Download the latest version of MSysGit, and install it. Clone the git repository:

* Launch git GUI (from Windows Start Menu)
* select *clone an existing repository*
* use *git://github.com/fusioninventory/fusioninventory-agent.git* as source URL
* use any directory as target directory
* click "clone" button

## Check the dependencies

``` cmd
$ perl Makefile.PL
```

You can use the `cpanm` command to install the missing dependencies:

``` cmd
$ cpanm XML::TreePP
```

## Running the agent

Open Windows commande line and go to the directory when agent's sources are located
run the agent:

``` cmd
$ perl fusioninventory-agent --stdout
```
