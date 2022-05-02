---
layout: single
title: Network discovery protocol
---

# Network discovery protocol

## Server to agent message

### Specification

    <!ELEMENT REPLY (PROCESSNUMBER, OPTION)>
    <!ELEMENT PROCESSNUMBER (#PCDATA)>
    <!ELEMENT OPTION (NAME, PARAM, RANGEIP+, AUTHENTICATION+)>
      <!ELEMENT NAME (#PCDATA)>

      <!ELEMENT PARAM EMPTY>
        <!ATTLIST PARAM THREADS_QUERY CDATA "1">
        <!ATTLIST PARAM PID CDATA #REQUIRED>

      <!ELEMENT RANGEIP EMPTY>
        <!ATTLIST RANGEIP ID CDATA #REQUIRED>
        <!ATTLIST RANGEIP IPSTART CDATA #REQUIRED>
        <!ATTLIST RANGEIP IPEND CDATA #REQUIRED>
        <!ATTLIST RANGEIP ENTITY CDATA #IMPLIED>

      <!ELEMENT AUTHENTICATION EMPTY>
        <!ATTLIST AUTHENTICATION ID CDATA #REQUIRED>
        <!ATTLIST AUTHENTICATION VERSION CDATA #REQUIRED>
        <!ATTLIST AUTHENTICATION COMMUNITY CDATA #IMPLIED>
        <!ATTLIST AUTHENTICATION USERNAME CDATA #IMPLIED>
        <!ATTLIST AUTHENTICATION AUTHPROTOCOL CDATA #IMPLIED>
        <!ATTLIST AUTHENTICATION AUTHPASSPHRASE CDATA #IMPLIED>
        <!ATTLIST AUTHENTICATION PRIVHPROTOCOL CDATA #IMPLIED>
        <!ATTLIST AUTHENTICATION PRIVPASSPHRASE CDATA #IMPLIED>

### Example

    <?xml version="1.0" encoding="UTF-8"?>
    <REPLY>
      <PROCESSNUMBER>1280265592/024</PROCESSNUMBER>
      <OPTION>
        <NAME>NETDISCOVERY</NAME>
        <PARAM THREADS_DISCOVERY="10" PID="1280265592/024"/>
        <RANGEIP ID="1" IPSTART="192.168.0.1" IPEND="192.168.0.254" ENTITY="15"/>
        <AUTHENTICATION ID="1" COMMUNITY="public" VERSION="1" USERNAME="" AUTHPROTOCOL="" AUTHPASSPHRASE="" PRIVPROTOCOL="" PRIVPASSPHRASE=""/>
        <AUTHENTICATION ID="2" COMMUNITY="public" VERSION="2c" USERNAME="" AUTHPROTOCOL="" AUTHPASSPHRASE="" PRIVPROTOCOL="" PRIVPASSPHRASE=""/>
      </OPTION>
    </REPLY>

## Agent to server message

### Specification

    <!ELEMENT REQUEST (CONTENT+, DEVICEID, QUERY)>

      <!ELEMENT CONTENT (DEVICE*, MODULEVERSION, PROCESSNUMBER)>

        <!-- a device -->
        <!ELEMENT DEVICE (IP, MAC?, AUTHSNMP?, TYPE?, MANUFACTURER?, MODEL?, DESCRIPTION?, SNMPHOSTNAME?, LOCATION?, CONTACT?, SERIAL?, FIRMWARE?, UPTIME?, IPS? DNSHOSTNAME?, NETPORTVENDOR?, NETBIOSNAME?, WORKGROUP?, USERSESSION?)>
          <!--  IP address -->
          <!ELEMENT IP (#PCDATA)>
          <!--  mac address -->
          <!ELEMENT MAC (#PCDATA)>

          <!-- Information retrieved from SNMP -->
          <!-- credentials ID -->
          <!ELEMENT AUTHSNMP (#PCDATA)>
          <!-- type
            (COMPUTER|NETWORKING|PRINTER|STORAGE|POWER|PHONE|VIDEO|KVM) -->
          <!ELEMENT TYPE (#PCDATA)>
          <!-- manufacturer -->
          <!ELEMENT MANUFACTURER (#PCDATA)>
          <!-- model -->
          <!ELEMENT MODEL (#PCDATA)>
          <!-- description (sysDescr) -->
          <!ELEMENT DESCRIPTION (#PCDATA)>
          <!--  host name -->
          <!ELEMENT SNMPHOSTNAME (#PCDATA)>
          <!--  location -->
          <!ELEMENT LOCATION (#PCDATA)>
          <!--  contact -->
          <!ELEMENT CONTACT (#PCDATA)>
          <!--  serial number -->
          <!ELEMENT SERIAL (#PCDATA)>
          <!--  firmware version -->
          <!ELEMENT FIRMWARE (#PCDATA)>
          <!--  uptime ("X days, HH:MM::SS" format) -->
          <!ELEMENT UPTIME (#PCDATA)>
          <!--  IP addresses -->
          <!ELEMENT IPS (IP+)>
            <!--  IP address -->
            <!ELEMENT IP (#PCDATA)>

          <!-- Information retrieved from Nmap -->
          <!-- host name -->
          <!ELEMENT DNSHOSTNAME (#PCDATA)>
          <!-- vendor -->
          <!ELEMENT NETPORTVENDOR (#PCDATA)>

          <!-- Information retrieved from NetBios -->
          <!-- host name -->
          <!ELEMENT NETBIOSNAME (#PCDATA)>
          <!-- user name -->
          <!ELEMENT USERSESSION (#PCDATA)>
          <!-- workgroup -->
          <!ELEMENT USERSESSION (#PCDATA)>

        <!-- netsdiscovery module version(string) -->
        <!ELEMENT MODULEVERSION (#PCDATA)> # netdiscovery module version
        <!-- server process ID (integer) -->
        <!ELEMENT PROCESSNUMBER (#PCDATA)>

      <!-- agent ID (string) -->
      <!ELEMENT DEVICEID (#PCDATA)> # agent ID (string)
      <!-- message type, ie "NETDISCOVERY" -->
      <!ELEMENT QUERY (#PCDATA)>

### Example

    <?xml version="1.0" encoding="UTF-8" ?>
    <REQUEST>
      <CONTENT>
        <DEVICE>
          <AUTHSNMP>1</AUTHSNMP>
          <CONTACT>dsi.sesi.reseau@inria.fr</CONTACT>
          <DESCRIPTION>Cisco NX-OS(tm) n5000, Software (n5000-uk9), Version 5.2(1)N1(5), RELEASE SOFTWARE Copyright (c) 2002-2011 by Cisco Systems, Inc. Device Manager Version 6.1(1),  Compiled 6/27/2013 16:00:00</DESCRIPTION>
          <FIRMWARE>CW_VERSION$5.2(1)N1(5)$</FIRMWARE>
          <IP>192.168.0.8</IP>
          <LOCATION>Inria dc1 salle 07</LOCATION>
          <MAC>00:23:04:ee:be:02</MAC>
          <MANUFACTURER>Cisco</MANUFACTURER>
          <MODEL>Cisco Nexus 5596</MODEL>
          <SNMPHOSTNAME>swdc-07-01-dc1</SNMPHOSTNAME>
          <TYPE>NETWORKING</TYPE>
          <UPTIME>175 days, 11:33:37.48</UPTIME>
        </DEVICE>
        <MODULEVERSION>2.3.9901</MODULEVERSION>
        <PROCESSNUMBER>1</PROCESSNUMBER>
      </CONTENT>
      <DEVICEID>qlf-sesi-inventory.inria.fr-2013-11-14-17-47-17</DEVICEID>
      <QUERY>NETDISCOVERY</QUERY>
    </REQUEST>
