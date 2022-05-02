---
layout: single
title: API-REST esx
---

#  API-REST-esx

##  getJobs?d=$deviceid

Return a list of ESX server to query.

    {
       "jobs" : [
          {
             "password" : "secret",
             "host" : "127.0.0.1",
             "user" : "myLogin",
             "uuid" : "zdqzdesdb00"
          },
          {
             "password" : "secret",
             "host" : "127.0.0.2",
             "user" : "myLogin",
             "uuid" : "08azdqzddb00"
          },
          {
             "password" : "secret2",
             "host" : "127.0.0.2",
             "user" : "my2ndLogin",
             "uuid" : "0sedesedesd"
          }
       ],
    }

##  setLog ?action=setLog&machineid=$machineid&part=$part&uuid=$uuid&msg=$msg&code=$code

* $machineid: the DeviceID of the agent
* $uuid: an unique string for the given job. supported to be standard 128bit UUID but can be a generic string
* $part: login, internal (optional)
* msg: a short message (< 100 characters) (optional)
* code: ok/ko

