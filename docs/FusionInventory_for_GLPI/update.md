# Update

## Get the archive for your GLPI

First, download archive: 

* Recent versions (>= 0.90) : <https://github.com/fusioninventory/fusioninventory-for-glpi/releases>

FusionInventory for GLPI tarball name follow this convention:

* fusioninventory-for-glpi_
* GLPI major release (0.80, 0.83, 0.84, 0.85, etc)
* a '+' symbol
* FusionInventory release

!!! example "Examples"
    * 9.5+4.0
    
    * 10.0.0+1.0


## Update

!!! important
    Don't click on <em>UNINSTALL</em> link. If you do this, you will **LOSE** all FusionInventory data.


* need first disable the FusionInventory plugin via GLPI web interface 
* move the **plugins/fusioninventory folder out of the plugins/ folder**. This ensures any deprecated files will be properly removed.


!!! important
    Please, do a backup of your database before install :sweat_smile:

* Uncompress the archive into the plugin folder of GLPI. File list looks like:

```
|- glpi
   |- plugins
      |- fusioninventory
         |- index.php
         |- hook.php
         |- inc
         |- ...
```

!!! note "Upgrade procedure"

    === "CLI installation (recommanded)"
        Run these commands from console / terminal:
        ``` shell
        php bin/console glpi:plugin:install --username=glpi fusioninventory
        php bin/console glpi:plugin:activate fusioninventory
        ```
        for GLPI >= 9.5.0:
        ```
        php bin/console glpi:migration:timestamps
        ```
        for GLPI >= 10.0.0:
        ```
        php bin/console glpi:migration:utf8mb4 
        php bin/console glpi:migration:unsigned_keys
        ```


    === "Web interface update"

        * Connect to _GLPI_
        * Go in the menu _Setup_ > _Plugins_
        * Update the plugin FusionInventory
        * Activate FusionInventory 


