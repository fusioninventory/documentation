---
layout: single
title: Specs for POIP
---

# SNMP + HTTPXML

## Goal

We have Only SNMP for the moment.

To inventory Cisco IP phone for example, we need to get XML by HTTP and parse it.

## Cisco IP phone CP-7940

We must get datas in XML from http. links are : 

* http://IP/DeviceInformationX
* http://IP/EthernetInformationX
* http://IP/NetworkConfigurationX
* http://IP/PortInformationX?1
* http://IP/PortInformationX?2
* http://IP/PortInformationX?3
* http://IP/StreamingStatisticsX?1
* http://IP/StreamingStatisticsX?2

## DeviceInformationX

    <?xml version="1.0" encoding="iso-8859-1"?>
    <DeviceInformation>
       <MACAddress>0003E369A125</MACAddress>
       <HostName>SEP0003E369A125</HostName>
       <phoneDN>5920</phoneDN>
       <appLoadID>P00308010200</appLoadID>
       <bootLoadID>PC03A300</bootLoadID>
       <versionID>8.1(2.0)</versionID>
       <DSPLoadID>4.0(5.0)[A0]</DSPLoadID>
       <addonModule1></addonModule1>
       <addonModule2></addonModule2>
       <hardwareRevision>1.0</hardwareRevision>
       <serialNumber>INMXXXXXXX</serialNumber>
       <modelNumber>CP-7940</modelNumber>
       <Codec>ADLCodec</Codec>
       <Amps>3V Amp</Amps>
       <C3PORevision>2</C3PORevision>
       <MessageWaiting> OUI</MessageWaiting>
    </DeviceInformation>

## EthernetInformationX

    <?xml version="1.0" encoding="iso-8859-1"?>
    <EthernetInformation>
       <TxExcessiveCollisions>0</TxExcessiveCollisions>
       <TxFrames>2732807</TxFrames>
       <TxBroadcasts>7944</TxBroadcasts>
       <TxMulticasts>169287</TxMulticasts>
       <TxCollisions>0</TxCollisions>
       <TxDeferredAbort>0</TxDeferredAbort>
       <RxOverruns>0</RxOverruns>
       <RxLongCRC>0</RxLongCRC>
       <RxFrames>3837371</RxFrames>
       <RxCRCErrors>0</RxCRCErrors>
       <RxBadPreamble>0</RxBadPreamble>
       <RxRunt>0</RxRunt>
       <RxMulticasts>151066</RxMulticasts>
       <RxBroadcasts>1424370</RxBroadcasts>
       <RxShorts>0</RxShorts>
       <RxLongs>0</RxLongs>
    </EthernetInformation>

## server HTTP headers

    $curl -I 172.20.44.33
    HTTP/1.1 200 OK
    Content-Type: text/xml; charset="utf-8"
    Date: Thu, 21 Mar 2013 15:42:33 GMT
    Cache-Control: no-cache
    Expires: Thu, 26 Oct 1995 00:00:00 GMT
    Content-Length: 32
    Server: Allegro-Software-RomPager/4.34

Most of these fields can be used to identify the 

## Cisco IP phone CP-7945G

We must get datas in XML from http. links are : 

* http://IP/CGI/Java/Serviceability?adapterX=device.statistics.device
* http://IP/CGI/Java/Serviceability?adapterX=device.statistics.configuration
* http://IP/CGI/Java/Serviceability?adapterX=device.statistics.ethernet
* http://IP/CGI/Java/Serviceability?adapterX=device.statistics.port.access
* http://IP/CGI/Java/Serviceability?adapterX=device.statistics.port.network
* http://IP/CGI/Java/Serviceability?adapterX=device.statistics.streaming.0
* http://IP/CGI/Java/Serviceability?adapterX=device.statistics.streaming.1
* http://IP/CGI/Java/Serviceability?adapterX=device.statistics.streaming.2
* http://IP/CGI/Java/Serviceability?adapterX=device.statistics.streaming.3
* http://IP/CGI/Java/Serviceability?adapterX=device.statistics.streaming.4


## Modifications in Plugin GLPI

Idea: add a Web model. Eg:

    <url></url>
    <parsing>XML/HTML</parsing>
    <key></key>
    <name></name>


## Modifications in agent / module SNMPQUERY


