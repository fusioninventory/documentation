---
layout: single
title: Fusioninventory Plugin for GLPI - Tasks Redux
---

# Tasks redux : objectives

This page aims to gather objectives .

* Split and move tasks summary GUI parts into appropriate tab/screen called
  **Monitoring** and **Reporting** (like using native GLPI reporting facilities or
  mReporting optional plugin)
* Rework task summary categories and layout

{% include info.html param="**TODO** We welcome any mockup and propositions." %}

* Add history log on tasks.

* Externalize taskjobs reports in an independant page and base the display of
  this page on what have been done with the Deploy reports status

{% include info.html param="**TODO**<br /><br />Add some mockup within this page or linked to another page if there are too many elements that makes this page unreadable." %}

## Multi TaskJob sequencing

Up until 0.83, there was some sequencing facility with the original tabbed Task interface.

The actual implementation did not allow us to reorder easily those "Multi-TaskJobs" Tasks.

**Add timeout field in the action**

The following mockup show some way to achieve this :

![](../../../assets/dev/plugin-glpi/multijob-tasks-reborn.png)

## Task planification

### server-driven mode (legacy)

Taskjobs are generated like in previous version but Task and TaskJobs are created
and managed separately.

* Split tasks from jobs to simplify the process
    * Create a Jobs management tab outside the tasks
    * We should be able to create Jobs in task management screen (cf. Package interface)
    * Tasks are only considered as crontab-like tasks.
    * Display the jobs list line by line.
    * Create some helper class which helps to list jobs associated to some
      task. For each Jobs linked, we must have:
        * some timeout (or delay) before running a job.
        * regroup every job by starting time.

* JobStates are generated according to their delay and in the resultant order :

        example:
            * Wakeonlan 1 - no delay
            * Deploy 1    - no delay
            * Deploy 2    - 2 hours

        results:
            * at t+0, [Wakeonlan 1] and [Deploy 1] tasks are generated and
            ready to be executed by the agents.
            * at t+1h, nothing to be done
            * at t+2h, [Deploy 2] is generated and ready to be executed by the
            agents.

{% include info.html param="**TODO**<br /><br />* Explain in detail the delay time.<br />* Maybe we can use some sort of maximum duration in addition to the delay a task in order to limit usage on certain time slots." %}

### agent-driven mode (ondemand)

TaskJobs are produced more like an on-demand service:

1. Some agent asks for its tasks periodically (cf. getConfig in REST specs)
2. The server computes a list of currently available Tasks for the agent.
3. This list is filtered out by the agent id and the allowed timeslot.
4. Each allowed Tasks generates a corresponding TaskJob and sends the result to the agent.

![](timeslot.svg)

* Each black square represents an authorized interval

* The timeslot associated to the task will be saved in a table:

    <INT:task_id> | <TINYINT:weekday_number> | <TINYINT:hour_start> | <TINYINT:hour_end>

Example:

    #Monday(0), between 0:00 and 7:00
    12345 |  0 |  0 |  7
    #Monday(0), between 19:00 and 0:00
    12345 |  0 | 19 | 24

    #Tuesday(1), between 0:00 and 4:00
    12345 |  1 |  0 |  4
    #Tuesday(1), between 6:00 and 10:00
    12345 |  1 |  6 | 10
    #Tuesday(1), between 12:00 and 16:00
    12345 |  1 | 12 | 16
    #Tuesday(1), between 19:00 and 0:00
    12345 |  1 | 19 | 23

    #Wednesday(2), between 12:00 and 15:00
    12345 |  2 | 12 | 15

    #Thursday(3), between 8:00 and 12:00
    12345 |  3 |  8 | 12

    #Friday(4), between 12:00 and 14:00
    12345 |  4 | 12 | 14

    #Friday(5), all day long
    12345 |  5 |  0 | 24

    #Sunday(6), all day long
    12345 |  6 |  0 | 24

## Taskjob Statuses

### legacy

* **PREPARED** : server just create the TaskJob
* **RUNNING**  : some agent gets its corresponding TaskJob
* **FINISHED** : the agent has completed its TaskJob without error
* **INERROR**  : the agent encountered some issues and stop the TaskJob with errors or TaskJob's timeout occured (crontask > 2h)

### on-demand

* **RUNNING**  : some agent gets its corresponding TaskJob
* **FINISHED** : the agent has completed its TaskJob without error
* **INERROR**  : the agent encountered some issues and stop the TaskJob with errors or TaskJob's timeout occured (crontask > 2h)

## Monitoring / Logs

* Enhance summary view with tasks related status informations like number of
discovered/inventoried devices (cf. NetDiscovery or NetInventory status) or the
number of packages deployed grouped by statuses. It looks like tasks summary
view in 0.84+1.0 but with relevant summarized details. Those details can be
refreshed dynamically on this consultation page. Each line must use the
following format :

        <task icon> - <task name> - <specific global tasks details> - [global completion percentage] - <status icon>
            + more specific task details

* Example :

        <DEPLOY icon> - Office Apps install - 80 deployments (ok: 50, ko : 12, unneeded : 3) - completion : 81 % - <RUNNING icon>
            + Total targetted devices : 40
            + LibreOffice - ok : 30, ko :  2,  unneeded : 3
            + Thunderbird - ok : 20, ko : 10,  unneeded : 0

        <NETDISCOVERY icon> - Building 42 - discoveries : (50 new devices , 100 updated devices) - completion : N/A - <FINISHED icon>
            + networking devices - 10 new devices, 5 updated devices
            + printers           - 30 new devices, 5 updated devices
            + unknown devices    - 10 new devices, 90 updated devices

        <NETINVENTORY icon> - Building 666 - targetted devices : 0 - completion : 0 % - <INERROR icon>
            + Total targets : 0
            + IP range :
                9th circle, 8th circle, 7th circle
            + Error :
                no devices found to be inventoried

* Selecting a task will switch to a more detailed view with advanced logs (jobstates filtered by the currently selected task id)

## Reporting

{% include info.html param="**TODO**<br /><br />* Define some use case reports for each tasks." %}

