# Schedule agent with cron


For Linux/Unix platforms only:

!!! warning
    FusionInventory Agent would better be installed as systemd service and this is the recommanded way of doing.


FusionInventory agent is expected to run its tasks on a regular basis and is better
installed as service. Its memory and load footprints are low enough for modern desktop computers.

To know better about the FusionInventory agent execution modes, you should be read the [Agent usage page](../configuration/usage.md).

You should use cron if you don't want a fusioninventory-agent process to be running
all the time and if you don't need to trigger it remotely (from the server
or manually, locally contacting the `http://localhost:62354/` page).

So if you prefer to run FusionInventory Agent as scheduled cron job, you may need
to do the following as root:
1. stop and disable the fusioninventory-agent service (if start/enabled):

``` shell
systemctl stop fusioninventory-agent
systemctl disable fusioninventory-agent
```

2. create a `/etc/fusioninventory/conf.d/better-for-cron.cfg` file with the following
   lines:

```
# Don't force agent to run inventory at each run, but only
# after server defined timeout has been reached
lazy = 1
```

3. as example, add a root cron job like this:

```
# Don't remove --wait option (delay in seconds) so the agent wait a random
# time before really run its work
00 */4 * * * /usr/bin/fusioninventory-agent --wait=1800 >/var/lib/fusioninventory-agent/cron.log 2>&1
```

For large companies, be aware you can lead to [concurrent execution issues](../configuration/usage.md#concurrent-execution)
if you don't enable agent `lazy` option with cron scheduling and even more if you forget to
use `--wait` option. To avoid such missconfiguration,
you would prefer leave the agent started as systemd service and define a peaceful delay
on server. You may adjust scheduled time and wait command line only option to your needs.

As a reminder, when launched without the [**daemonize** configuration directive](../manpage/agent.cfg.md),
as usually done from cron, the agent is a short-lived process, without
the ability to listen on the network for out-of-schedule activation requests from the server.
