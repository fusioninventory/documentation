---
layout: single
title: API-REST collect
---

#  API-REST-collect

Protocol specification used to collect specific information on a machine.

##  ?action=getJob&machineid=$machineid

* action:getJob
* machineid: $machineid

###  serveur answer:

Server will return an array of job to process, a job is:
* a hash
* a mandatory "function" key
* an additional list of parameters

*getFromRegistry*

    [
       {
          "function" : "getFromRegistry",
          "64bit" : 0, // not implemented yet
          "path" : "HKEY_LOCAL_MACHINE/SYSTEM/CurrentControlSet/Control/Session Manager",
          "uuid" : xxxx1
       }
    ]

path can finish with a wildcare, in such case, all the key/value of the current directory are returned.

*getFromWMI*

    [
       {
          "function" : "getFromWMI",
          "moniker" : "foobar" // default is winmgmts:{impersonationLevel=impersonate,(security)}!//./
          "class" : "Win32_Keyboard",
          "properties" : [ "Name", "Caption", "Manufacturer", "Description", "Layout" ],
          "uuid" : xxxx3
       }
    ]

*findFile*

    [
       {
          "function" : "findFile",
          "limit" : 5, # Number of entry to look for, default is 50
          "recursive" : 0,
          "dir": "/home" # Where to start the search, default is /
          "filter" : // filter and its content is optional
              {
                          "regex" : "\d{4}\.bmp$",// regex done on the full path
                          "sizeEquals" : "445635",
                          "sizeGreater" : "432455",
                          "sizeLower" : "454545",
                          "checkSumSHA512" : "xxxx",
                          "checkSumSHA2" : "zzzzzz",
                          "name" : "toto",
                          "iname" : "ToTo", // case insensitive
                          "is_file" : 1,
                          "is_dir" : 0
              }
          ,
          "uuid" : xxxx3
       }
    ]

*getFile* **[not implemented]**

    [
        {
            "function" : "getFile",
            "path" : "/tmp/foobar.txt",
            "stat" : 1, # get file statistics
            "sizemax" : 500, # limit size in octects
        }
    ]

*getFileStat* **[not implemented]**

    [
        {
            "function" : "getFile",
            "path" : "/tmp/foobar.txt",
        }
    ]

*runCommand*

    [
       {
          "function" : "runCommand",
          "command" : "route",
          "dir" : "c:/", # Where to run the command
          "uuid" : "xxxx3",
          "filter" : { (optional)
              "firstMatch" : "(eth\d+)", // or (the first match for a regex)
              "firstLine" : "1", // or (the first line)
              "lineCount" : 1 // the number of lines
          }
       }
    ]

##  ?action=setAnswer&uuid=$uuid

the agent POST the answer in a JSON XML with this structure:


The answer structure is always a array of key/val hash.

###  getFromRegistry

Returns undef in case of error or an array of the following hash:

* name1 : value1
* name2 : value2
* uuid : "foo"


###  getFromWMI

Returns undef in case of error or an array of the following hash:

* propertyfoo : "bar",
* propertybar : "foo",
* uuid : "bibi1"

###  findFile

Returns undef in case of error or an array of the following hash:

* path : "c:/somewhere/picture.bmp",
* uuid : "XXXX",
* size : 12345


###  runCommand

{% include warning.html param="Function disabled for the moment." %}

* output: "blabla",
* errorMsg: "an optional error message in english",
* uuid: "drf"

### getFile

* output: <file contents>
* errorMsg: ""      # if any

### getFileStat

* output:

      0 dev      device number of filesystem
      1 ino      inode number
      2 mode     file mode  (type and permissions)
      3 nlink    number of (hard) links to the file
      4 uid      numeric user ID of file's owner
      5 gid      numeric group ID of file's owner
      6 rdev     the device identifier (special files only)
      7 size     total size of file, in bytes
      8 atime    last access time in seconds since the epoch
      9 mtime    last modify time in seconds since the epoch
      10 ctime    inode change time in seconds since the epoch (*)
      11 blksize  preferred I/O size in bytes for interacting with the
                 file (may vary from file to file)
      12 blocks   actual number of system-specific blocks allocated
                 on disk (often, but not always, 512 bytes each)

* errorMsg: ""      # if any
