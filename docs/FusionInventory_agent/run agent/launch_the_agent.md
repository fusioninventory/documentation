# How to run agent


## HTTP interface

If the agent is running as a service or a daemon, its web interface should 
be accessible at <http://hostname:62354>.

If the machine connecting to this interface is trusted (see *httpd-trust*
configuration directective in [agent configuration](../configuration/configuration.md)), a
link will be available to force immediate execution.

## Command line

Agent can also be executed from command line, using either of its multiple
executables (see [agent man pages](../../manpage/) for details).

### Windows

Open a command interpreter windows (cmd.exe), with administrator privileges
(*right clic* → *Run as Administrator* on Vista and Seven *Start menu*).

Go in the **c:\Program files\FusionInventory-Agent\perl\bin** (adjust this path depending on your configuration) directory and run:

``` cmd
# perl fusioninventory-agent
```

### OS X

Ensure `daemon` key is not defined or false in `agent.cfg`. This key is enabled on OS X default settings (`/opt/fusioninventory-agent/agent.cfg`).

Go in /opt/fusioninventory-agent and run the following command:

``` shell
$ sudo /opt/fusioninventory-agent/fusioninventory-agent
```

See [OS X documentation for further details](../../   Installation/osx/osx/).

### Other

Just run:

``` shell
# fusioninventory-agent
```
