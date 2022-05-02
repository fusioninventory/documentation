---
layout: single
title: Cron for GLPI and for FusionInventory
---

# The goal of the GLPI cron

GLPI has _automatic actions_ like _optimize database_, _alerts on end of contracts_ ...
The plugin FusionInventory has own _automatic actions_ like the _taskscheduler_ used to prepare the tasks.

That's why, these actions must run often.


# How to run the GLPI cron?

It's not complex, you need create a cron on your operating system run the GLPI cron.


For Linux, add in _crontab_:

```
* * * * * /usr/bin/php5 /var/www/glpi/front/cron.php &>/dev/null
```

For windows, create in _Task Scheduler_ all 1 or 5 minutes:

```
"c:\path\to\php.exe c:\path\to\glpi\front\cron.php"
```






