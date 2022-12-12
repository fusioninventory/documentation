# Installation from the source tarball

## Get the sources Luke!

The latest release is available either from
[our github releases](https://github.com/fusioninventory/fusioninventory-agent/releases) page or from [CPAN](https://metacpan.org/release/FusionInventory-Agent).

## Build and installation

We strongly recommend the use of __GNU tar__ because some file path length are
greater than 100 caracters. Some tar version will silently ignore those files
like for example on HP-UX.

First, you need to extract the source and change the current directory.

``` shell
$> tar xfz FusionInventory-Agent-2.3.19.tar.gz
$> cd FusionInventory-Agent-2.3.19
```

Executing Makefile.PL will verify all the required dependencies are available
and prepare the build tree.

``` shell
$> perl Makefile.PL
```

At this point, you may have some missing required modules. See [dependencies](#dependencies)
section for installing them. Once this is done, run the same command again:

``` shell
$> perl Makefile.PL
```

This time the execution should success and you can finish the installation.
Here again we recommend GNU make (gmake):

``` shell
make
make install
```

If you don't want to use the default directory (/usr/local), you can use the
PREFIX parameter during the Makefile.PL step:

``` shell
perl Makefile.PL PREFIX=/opt/fusioninventory
make
make install
```

## Tests

FusionInventory components come with a test-suite. You can run it after the `perl Makefile.PL` with this command:

``` shell
$> make test
```

The tests suite requires some additional dependencies like Test::More.

## Dependencies

### Perl dependencies

The easiest way to install perl dependencies is to use [cpanm](http://cpanmin.us). Just run:

``` shell
$> cpanm .
```

You can use the _--notest_ flag if you are brave and want to skip the tests suite
execution for each install perl module.

### Offline installation of Perl dependencies

!!! info
    You will need <a href='http://cpanmin.us'>cpanm</a>.<br/>See above how to install it.

First grab the tarball from the website and extract it.

``` shell
$> tar xzf FusionInventory-Agent-2.3.19.tar.gz
$> cd FusionInventory-Agent-2.3.19
```

We use cpanm to fetch and extract the dependencies in the extlib directory.

``` shell
$> cpanm --pureperl --installdeps -L extlib --notest .
```

This command could fails (2013-08-11) with an error regarding Params::Validate. Then just run
this last command:

``` shell
$> cpanm --installdeps -L extlib --notest .
```

Now you can copy the directory to another machine and run the agent this way:

``` shell
$> perl -Iextlib/lib/perl5 -Ilib fusioninventory-agent
```

### Other dependencies

On Solaris/SPARC, you must install sneep and record the Serial Number with it.
Download it from <http://www.sun.com/download/products.xml?id=4304155a>.

On Windows, we use an additional dmidecode binary shipped in the windows
distribution to retrieve many informations not available otherwise, including
fine-grained multi-cores CPUs identification. Unfortunatly, this binary is not
reliable enough to be used on Windows 2003, leading to less precise
inventories.

On Linux, lspci will be used to collect PCI, AGP, PCI-X, ... informations.
