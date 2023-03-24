# Task creation


Use the (Normal) display of Task Management. This is used to list and
search the existing tasks in the Fusion Inventory system.

![](../../assets/fi4g/deploy/FusionTaskManagementNormalPage.png)

1.  Clicking on _Task management (Normal)_ link.
2.  Clicking on the big "+", like in all of
    [[GLPI]], will create a new object in
    the area you are working - in this case, a new task.
3.  Clicking on a task name will allow you to edit existing tasks, check
    their status, start them, stop them, etc.

## “Agent contact the server” or “Server contacts the agent”

There is two different way to publish a task once it is ready. You can either:

* awake the agent from the server so it will start the task immediately.
* wait for the agent to contact the server like you do for an inventory.

In the first case, the task will fail if the agent is not available. The agent
has to be running as a daemon or a service, and the server must be able to
contact the agent web interface (defaut port: 62354). Additionaly, on windows
XP, a nasty name resolution issue (#2190) requires to explicitely add the
server IP address to agent httpd-trust configuration directive.
