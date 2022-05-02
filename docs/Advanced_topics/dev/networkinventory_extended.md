---
layout: single
title: NetworkInventory extended
---

NetworkInventory extended

# IO cards

It's networks equipments with network port:
* Modem
* fiber port

We will have same structure than network equipment:

> <INFO>
> <PORTS>

in

> <DEVICE>
>       <EXTENSIONS>
>             <NETWORK>


# management cards

It's components:
* fans
* power
 
We will have this information:

??

in 

> <DEVICE>
>       <EXTENSIONS>
>             <COMPONENT>


# Evolution of XML structure of networkequipment

We need to have more fields in XML structure to manage more information of like:

* ??

Idem for PORTS section

* for IFTYPE = 94:adsl (need to verify this), need:
  * adsl login
  * freshness
  * encapsulation protocol
* for a IFTYPE = 23:ppp/3g (need to verify this), need:
  * SERIAL: SIM number
  * APN: apn
  * freshness
  * LINE_NUMBER: line number
  * OPERATOR_CODE
  * OPERATOR_NAME

On android inventory we have this structure:

>    <SIMCARDS>
>      <COUNTRY>fr</COUNTRY>
>      <OPERATOR_CODE>20815</OPERATOR_CODE>
>      <OPERATOR_NAME>Free</OPERATOR_NAME>
>      <SERIAL>8933150112022770809</SERIAL>
>      <STATE>SIM_STATE_READY</STATE>
>      <LINE_NUMBER>+33652538570</LINE_NUMBER>
>      <SUBSCRIBER_ID>208150102278715</SUBSCRIBER_ID>
>    </SIMCARDS>



