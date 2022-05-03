# Switch stack inventory

## Switch stack inventory


Cisco 3750

Difference in snmpwalk output between normal and stacked switch:
The additional number after GigabitEthernet is switch number inside stack,
it starts from 1 and not 0 as ports do.

Port name ( .1.3.6.1.2.1.31.1.1.1.1 , ifname )

    non-stacked:  .1.3.6.1.2.1.31.1.1.1.1.10101 = STRING: Gi0/1
    stacked:      .1.3.6.1.2.1.31.1.1.1.1.10101 = STRING: Gi1/0/1
    
Port descr. ( .1.3.6.1.2.1.2.2.1.2 , ifdesc )

    non-stacked:  .1.3.6.1.2.1.2.2.1.2.10101 = STRING: GigabitEthernet0/1
    stacked:      .1.3.6.1.2.1.2.2.1.2.10101 = STRING: GigabitEthernet1/0/1
 

### workaround that works for me 

I made discovery of all switches via fusioninv glpi plugin first.

Then I found out that if I run fusioninventory-netinventory from cli against 
switch and than send xml file with injector or curl, my ports (almost all) on 
stacked switch are visible in GLPI. Some ports are missing and I'm trying to 
find out why.

I use this commmands:

    /usr/local/bin/fusioninventory-netinventory --host 10.0.0.14 --community something --model ./996914.xml > 14.xml
    curl --header "Content-Type: Application/x-compress" -k --data @14.xml https://glpi/plugins/fusioninventory/

    # /usr/local/bin/fusioninventory-netinventory --version
    # NetInventory task 2.3.2
    With patch from bug  #2336 http://forge.fusioninventory.org/issues/2336
