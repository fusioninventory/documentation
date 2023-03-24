# Cron

## The goal of the GLPI cron

GLPI has _automatic actions_ like _optimize database_, _alerts on end of contracts_ ...
The plugin FusionInventory has own actions like:

* _taskscheduler_ used to prepare the tasks (network inventory, deployment...)
* _cleantaskjob_ used to clean logs of the tasks
* _cleannetworkportlogs_ used to clean the logs of ports (network equipments)
* _cleanoldagents_ used to execute the action defined in the configuration (clean after xx days, or change status after xx days)
* _wakeupAgents_ used to wake up the agents (for the tasks)


That's why, these actions must run often.


## How to run the GLPI cron?

It's not complex, you need create a cron on your operating system run the GLPI cron.


For Linux, add in _crontab_:

```
* * * * * cd /var/www/glpi/front/ && /usr/bin/php cron.php &>/dev/null
```

For windows, create in _Task Scheduler_ all 1 or 5 minutes:

```
"c:\path\to\php.exe c:\path\to\glpi\front\cron.php"
```

