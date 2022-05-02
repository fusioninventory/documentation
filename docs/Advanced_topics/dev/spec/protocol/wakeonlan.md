---
layout: single
title: Wake-on-lan protocol
---

# Wake-on-lan protocol

## Server to agent message

### Specification

    {
        'id': ''string'',
        'type': 'wakeonlan',
        'targets': [
            {
                'address': ''string'',
                'ethernet': ''boolean'',
                'udp': ''boolean'',
            },
            ...
        ]
    }

### Example

    {
        'id': 'job1',
        'type': 'wakeonlan',
        'targets': [
            {
                'address': '00:1e:c2:0c:36:27',
                'ethernet': 'true',
                'udp': 'true'
            },
            {
                'address': '00:1e:52:ff:fe:67',
                'ethernet': 'true',
                'udp': 'true'
            },
        ]
    }

## Agent to server message

No message.
