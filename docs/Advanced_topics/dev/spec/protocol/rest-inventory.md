# REST API inventory

##  setInventory: ?action=setInventory&devicetype=computer&machineid=$deviceid

The inventory content is submitted in a POST request.

*devicetype: the object type, default is computer. This parameter is here for future use.

You can convert a XML inventory to the JSON format with this script:

``` perl
#!/usr/bin/perl -w

use strict;
use warnings;

use Data::Dumper;
use XML::TreePP;
use JSON;

use XML::TreePP;
my $tpp = XML::TreePP->new();
open XML, "</tmp/myxmlinventory.ocs" or die;
$/=undef;
my $xml = <XML>;
close XML;

$xml =~ s/(<)([^>]*)(>)/$1.lc($2).$3/ge;

my $tree = $tpp->parse($xml);
print Dumper($tree->{request}{content});
```

##  The changes

* Key are now low case
* The VOLUMN key has been renamed to volume.

Example:

    {
       "usbdevices" : [
          {
             "vendorid" : "8087",
             "subclass" : "0",
             "class" : "9",
             "productid" : "0020"
          },
          {
             "vendorid" : "0bda",
             "subclass" : "2",
             "serial" : "0x0001",
             "class" : "14",
             "productid" : "58f5"
          }
       ],
       "bios" : {
          "mmodel" : "Portable PC",
          "bdate" : "12/06/2010",
          "bversion" : "Version 1.80",
          "assettag" : "0000000000",
          "smodel" : "Satellite R630",
          "msn" : "0000000000",
          "bmanufacturer" : "TOSHIBA",
          "ssn" : "9A157081H",
          "skunumber" : "0000000000",
          "smanufacturer" : "TOSHIBA",
          "mmanufacturer" : "TOSHIBA"
       },
       "processes" : [
          {
             "virtualmemory" : "10400",
             "pid" : "1",
             "cpuusage" : "0.0",
             "cmd" : "init [2]",
             "user" : "root",
             "started" : "2011-03-19 0:05",
             "mem" : "0.0",
             "tty" : "?"
          },
          {
             "virtualmemory" : "0",
             "pid" : "2",
             "cpuusage" : "0.0",
             "cmd" : "[kthreadd]",
             "user" : "root",
             "started" : "2011-03-19 0:00",
             "mem" : "0.0",
             "tty" : "?"
          },
          {
             "virtualmemory" : "151864",
             "pid" : "28516",
             "cpuusage" : "0.0",
             "cmd" : "/usr/sbin/NetworkManager",
             "user" : "root",
             "started" : "2011-03-20 4:50",
             "mem" : "0.1",
             "tty" : "?"
          }
       ],
       "users" : [
          {
             "login" : "root"
          },
          {
             "login" : "goneri"
          }
       ],
       "storages" : [
          {
             "disksize" : "0",
             "manufacturer" : "MATSHITA",
             "serialnumber" : "HK31  125223",
             "name" : "sr0",
             "model" : "MATSHITADVD-RAM UJ892ES",
             "type" : "cdrom",
             "firmware" : "1.20",
             "description" : "SCSI"
          },
          {
             "disksize" : "305245",
             "manufacturer" : "Hitachi",
             "serialnumber" : "Hitachi_HTS545032B9A300_100830PBN300ZTJU5N1A",
             "name" : "sda",
             "model" : "Hitachi HTS545032B9A300",
             "type" : "disk",
             "firmware" : "PB3OC6G4",
             "description" : "SATA",
             "wwn" : "5000cca622e7a17b"
          }
       ],
       "drives" : {
          "volume" : "/dev/sda2",
          "free" : "43338",
          "serial" : "7043650e-5a7e-49ea-9864-29ad7350aabb",
          "filesystem" : "ext4",
          "type" : "/",
          "total" : "150226"
       },
       "softwares" : [
          {
             "filesize" : "296",
             "version" : "2.2.49-4",
             "from" : "deb",
             "name" : "acl",
             "comments" : "Access control list utilities"
          },
          {
             "filesize" : "92",
             "version" : "1.5-2",
             "from" : "deb",
             "name" : "acpi",
             "comments" : "displays information on ACPI devices"
          }
       ],
       "hardware" : {
          "dns" : "10.0.5.105",
          "userid" : "root/goneri",
          "oscomments" : "#1 SMP Wed Jan 12 03:40:32 UTC 2011",
          "processort" : "Intel(R) Core(TM) i3 CPU       M 350  @ 2.27GHz",
          "uuid" : "AAE79880-C977-11DF-801C-B05991157081",
          "lastloggeduser" : "goneri",
          "checksum" : "262143",
          "osversion" : "2.6.32-5-amd64",
          "archname" : "x86_64-linux-gnu-thread-multi",
          "processors" : "2270",
          "osname" : "Debian GNU/Linux unstable (sid)",
          "swap" : "0",
          "ipaddr" : "172.28.218.100/192.168.41.6/192.168.1.11",
          "defaultgateway" : "192.168.1.254",
          "name" : "tosh-r630",
          "description" : "x86_64/00-00-11 18:38:10",
          "workgroup" : "rulezlan.org",
          "vmsystem" : "Physical",
          "etime" : "7",
          "memory" : "3696",
          "userdomain" : "",
          "processorn" : "1",
          "datelastloggeduser" : "Wed Mar 30 19:29"
       },
       "memories" : [
          {
             "caption" : "DIMM0",
             "speed" : "1067",
             "numslots" : "1",
             "serialnumber" : "4447E5CC",
             "type" : "<OUT OF SPEC>",
             "description" : "SODIMM",
             "capacity" : "2048"
          },
          {
             "caption" : "DIMM2",
             "speed" : "1067",
             "numslots" : "2",
             "serialnumber" : "4447E6B5",
             "type" : "<OUT OF SPEC>",
             "description" : "SODIMM",
             "capacity" : "2048"
          }
       ],
       "controllers" : [
          {
             "name" : "Core Processor DRAM Controller",
             "caption" : "Core Processor DRAM Controller",
             "pciid" : "8086:0044",
             "pcislot" : "00:00.0",
             "manufacturer" : "Intel Corporation",
             "pciclass" : "0600",
             "type" : "Bridge",
             "driver" : "agpgart"
          },
          {
             "name" : "Core Processor Integrated Graphics Controller",
             "caption" : "Core Processor Integrated Graphics Controller",
             "pciid" : "8086:0046",
             "pcislot" : "00:02.0",
             "manufacturer" : "Intel Corporation",
             "pciclass" : "0300",
             "type" : "Display controller",
             "driver" : "i915"
          },
          {
             "pcislot" : "00:16.0",
             "pciid" : "8086:3b64",
             "caption" : "5 Series/3400 Series Chipset HECI Controller",
             "manufacturer" : "Intel Corporation",
             "name" : "5 Series/3400 Series Chipset HECI Controller",
             "type" : "Communication controller",
             "pciclass" : "0780"
          },
          {
             "name" : "82577LC Gigabit Network Connection",
             "caption" : "82577LC Gigabit Network Connection",
             "pciid" : "8086:10eb",
             "pcislot" : "00:19.0",
             "manufacturer" : "Intel Corporation",
             "pciclass" : "0200",
             "type" : "Network controller",
             "driver" : "e1000e"
          },
          {
             "name" : "5 Series/3400 Series Chipset USB2 Enhanced Host Controller",
             "caption" : "5 Series/3400 Series Chipset USB2 Enhanced Host Controller",
             "pciid" : "8086:3b3c",
             "pcislot" : "00:1a.0",
             "manufacturer" : "Intel Corporation",
             "pciclass" : "0c03",
             "type" : "Serial bus controller",
             "driver" : "ehci_hcd"
          },
          {
             "name" : "5 Series/3400 Series Chipset High Definition Audio",
             "caption" : "5 Series/3400 Series Chipset High Definition Audio",
             "pciid" : "8086:3b56",
             "pcislot" : "00:1b.0",
             "manufacturer" : "Intel Corporation",
             "pciclass" : "0403",
             "type" : "Multimedia controller",
             "driver" : "HDA"
          }
       ],
       "versionclient" : "FusionInventory-Agent_v2.1.8",
       "accesslog" : {
          "logdate" : "2011-03-30 20:49:02",
          "userid" : "N/A"
       },
       "inputs" : [
          {
             "caption" : "AT Translated Set 2 keyboard",
             "type" : "Keyboard",
             "description" : "AT Translated Set 2 keyboard"
          },
          {
             "caption" : "PC Speaker",
             "type" : "Keyboard",
             "description" : "PC Speaker"
          }
       ],
       "networks" : [
          {
             "status" : "Up",
             "slaves" : "",
             "macaddr" : "00:23:18:91:db:8d",
             "description" : "eth0",
             "virtualdev" : "0",
             "pcislot" : "0000:00:19.0",
             "ipdhcp" : "172.23.240.1",
             "type" : "Ethernet",
             "driver" : "e1000e"
          }
       ],
       "videos" : {
          "resolution" : "1366x768",
          "name" : "Intel(R) Arrandale"
       },
       "ports" : [
          {
             "caption" : "DB-15 female",
             "name" : "",
             "type" : "Other",
             "description" : "None"
          },
          {
             "caption" : "RJ-45",
             "name" : "",
             "type" : "Network Port",
             "description" : "None"
          }
       ],
       "sounds" : [
          {
             "manufacturer" : "Intel Corporation 5 Series/3400 Series Chipset High Definition Audio ",
             "name" : "Audio device",
             "description" : "rev 06"
          },
          {
             "manufacturer" : "Intel Corporation 5 Series/3400 Series Chipset High Definition Audio ",
             "name" : "Audio device",
             "description" : "rev 06"
          }
       ],
       "cpus" : {
          "thread" : "4",
          "core" : "4",
          "speed" : "2270",
          "manufacturer" : "Intel",
          "name" : "Intel(R) Core(TM) i3 CPU       M 350  @ 2.27GHz",
          "id" : "55 06 02 00 FF FB EB BF"
       },
       "batteries" : {
          "chemistry" : "Lithium ",
          "serial" : "0000000000",
          "manufacturer" : "TOSHIBA",
          "date" : ""
       },
       "slots" : [
          {
             "status" : "In Use",
             "name" : "SD CARD",
             "description" : "Other"
          },
          {
             "designation" : "1",
             "status" : "In Use",
             "name" : "EXPRESS CARD",
             "description" : "x1 PCI Express"
          }
       ],
       "envs" : [
          {
             "val" : "/root",
             "key" : "HOME"
          }
          {
             "val" : "1000",
             "key" : "SUDO_GID"
          },
          {
             "val" : ":0",
             "key" : "DISPLAY"
          }
       ]
    }
