---
layout: single
title: Task scheduling protocol
---

#  Task scheduling protocol

## Agent request

### Description

The agent advertise itself and its capacities, through URL parameters

### Example

GET http://glpiserver/glpi/plugins/fusioninventory/api/tasks?agentid=xyz&module['inventory']=2.4.0&module['netinventory']=2.4.0

## Server response

### Description

The server response is a list of tasks, and a timestamp for next agent request.

A task had an identifier, and a list of jobs.

A job has an identifier, a type and a list of targets.

### Example

    {
        'tasks': [
            {
                'id': 'task1',
                'jobs': [
                    {
                        'id': 'job1.1',
                        'type': 'netdiscovery',
                        'workers': 2,
                        'targets': [
                            {
                                'network': '192.168.0.0/24',
                                'workers': 10,
                                'timeout': 5,
                                'credentials': [
                                    {
                                        'version': '2c',
                                        'community': 'public'
                                    },
                                    {
                                        'version': '1',
                                        'community': 'public'
                                    },
                                ],
                            },
                            {
                                'network': '192.168.1.1-192.168.1.254',
                                'workers': 5,
                                'timeout': 2,
                                'credentials': [
                                    {
                                        'version': '3',
                                        'username': 'foo',
                                        'authprotocol': 'sha1',
                                        'authpassword': 'bar',
                                    },
                                ],
                            },
                        ],
                    },
                    {
                        'id': 'job1.2'
                        'type': 'netinventory',
                        'workers': 2,
                        'targets': [
                            {
                                'host': '192.168.1.1',
                                'type': 'printer,'
                                'credentials': {
                                    'version': '2c',
                                    'community': 'public'
                                },
                            },
                            {
                                'host': '192.168.1.2',
                                'type': 'networking,'
                                'credentials': {
                                    'version': '3',
                                    'username': 'foo',
                                    'authprotocol': 'sha1',
                                    'authpassword': 'bar',
                                },
                            },
                        ],
                    },
                ],
            },
            {
                'id': 'task3',
                'jobs': [
                    {
                        'id': 'job31'
                        'type': 'inventory'
                    },
                ],
            },

        ],
        'nextContactTime': 1424763734
    }

## Processing.

The agent should process each task, and each job within a task, sequentially.

The agent should process multiple targets of the same job either paralleously
if a 'workers' variable is present at job level, sequentially otherwise.

The agent should process a single target paralleously, if a 'workers' variable
is present at target level (network discovery only), sequentially otherwise.
