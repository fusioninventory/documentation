# How to push additional content in my inventory

## Additional content

You can use *additional-content* [configuration parameter](../configuration/configuration.md) 
(alternatively, *--additional-content* [command-line options](../../manpage/)) to inject arbitary XML content into
inventory result.

For instance, to add some manually installed software, unknown from the
packaging system database:

``` shell
$> cat /tmp/foo.xml
<?xml version="1.0" encoding="UTF-8" ?>
<REQUEST>
<CONTENT>
    <SOFTWARES>
        <NAME>foo</NAME>
        <VERSION>bar</VERSION>
    </SOFTWARES>
</CONTENT>
</REQUEST>
$> fusioninventory-agent --additional-content /tmp/foo.xml
```

## Perl module (Agent side)

You can extend FusionInventory by creating a custom Perl module, and installing
it anywhere under 'lib/FusionInventory/Agent/Task/Inventory' directory. It will
be automatically loaded and executed at run time.

Example: <http://forum.fusioninventory.org/viewtopic.php?id=2248> (French)

If you want to add some content which isn't curently in FusionInventory, follow this Oracle integration procedure for AIX:

Create a perl module named "Oracle.pm":

``` perl
package FusionInventory::Agent::Task::Inventory::Input::AIX::Oracle;
use strict;
use warnings;
use English qw(-no_match_vars);
sub isEnabled {
    return 1;
}
sub doInventory {
    my (%params) = @_;
    my $inventory = $params{inventory};
    
    #[ADD CUSTOM CONTENT HERE]
        
    #Call this function to add an XML block
    addOracle(inventory => $inventory, entry => {
        'INSTANCE' => $nomInstance,
        'VERSION'  => $version,
        'URL'      => $url,
        'PORT'     => $port,
        'PATH'     => $path,
        'STATE'    => $state,
    });
}
sub addOracle {
    my (%params) = @_;
    my $entry = $params{entry};
    $params{inventory}->addEntry(section => 'ORACLE', entry => $entry);
}
1;
```

Put this file into:
./fusioninventory-agent_aix-6.1-ppc_2.2.7-4/perl/agent/FusionInventory/Agent/Task/Inventory/Input/AIX/ (Old version)    
./FusionInventory-Agent-2.3.17/lib/FusionInventory/Agent/Task/Inventory/AIX (New version)

Then, you can modify "fusioninventory-agent_aix-6.1-ppc_2.2.7-4/perl/agent/FusionInventory/Agent/Task/Inventory/Inventory.pm" in order to add a new field for Oracle.

``` perl
my %fields = (   
    […]
ORACLE      => [ qw/INSTANCE VERSION URL PORT PATH STATE/],
```

## Add content: Server side

You can create a new PHP class "Oracle.class.php" into ./glpi/plugins/fusioninventory/inc/ if you want to visualise it on GLPI.

On the same repository, modify "formatconvert.class.php" file so that the server understands the new xml block:

``` php
static function XMLtoArray($xml) {
// Hack for some sections
$a_fields = ['SOUNDS', 'VIDEOS', 'CONTROLLERS', 'CPUS', 'DRIVES', 'MEMORIES', 'NETWORKS', 'SOFTWARE', 'USERS',
'VIRTUALMACHINES', 'ANTIVIRUS', 'MONITORS', 'PRINTERS', 'USBDEVICES', 'PHYSICAL_VOLUMES', 'VOLUME_GROUPS',
'LOGICAL_VOLUMES', 'BATTERIES', 'LICENSEINFOS', 'STORAGES', 'INPUTS', 'ORACLE'];  
    […]
$_a_inventory['oracleinstance'] = [];
   if (isset($array['ORACLE'])){
      foreach ($array['ORACLE'] as $a_oracle) {
         $array_tmp = $thisc->addValues($a_oracle,
         [
            'INSTANCE' => 'name',
            'URL'      => 'url',
            'PORT'     => 'port',
            'VERSION'  => 'version',
            'PATH'     => 'path',
            'STATE'    => 'state'
         ]);
         $a_inventory['oracleinstance'][] = $array_tmp;
      }
   }
}
```

Uppercase fields = XML fields   
Lowercase fields = Database fields

Add database interactions:

Now, the server can interpret the new XML datas but still can't add it into our GLPI database. So you need to add content in "inventorycomputerlib.class.php" file.

``` php
function updateComputer($a_computerinventory, $computers_id, $no_history, $setdynamic=0) {
   […]
   $pfOracle = new PluginFusioninventoryOracle();
   […]
   // * CUSTOM: Oracle
   $db_oracleinstance = array(); // Recover the datas from database
      if ($no_history === FALSE) {
         $query = "SELECT `id`, `name`, `url`, `port`, `version`
                   FROM `glpi_plugin_fusioninventory_oracles`
                    WHERE `computers_id` = '$computers_id'";
         $result = $DB->query($query);
         while ($data = $DB->fetch_assoc($result)) {
            $idtmp = $data['id'];
            unset($data['id']);
            $data1 = Toolbox::addslashes_deep($data);
            $data2 = array_map('strtolower', $data1);
            $db_oracleinstance[$idtmp] = $data2;
         }
      }
      foreach ($a_computerinventory['oracleinstance'] as $key => $arrays) { /* We don't want to deal with the parameters already in database */
         $arrayslower = array_map('strtolower', $arrays); // XML CONVERTED
         foreach ($db_oracleinstance as $keydb => $arraydb) {
            if ($arrayslower == $arraydb) { // if XML and DB matched, then nothing to do
               unset($a_computerinventory['oracleinstance'][$key]);
               unset($db_oracleinstance[$keydb]);
               break;
            }
         }
      }
      if (count($a_computerinventory['oracleinstance']) == 0 AND count($db_oracleinstance) == 0) {
         // Nothing to do.
      } else {
         if (count($db_oracleinstance) != 0) { // if there is still DB parameters.
            foreach ($db_oracleinstance as $idtmp => $data) {
               $pfOracle->delete(array('id'=>$idtmp), 1); // delete attribute ID
            }
         }
         if (count($a_computerinventory['oracleinstance']) != 0) {
            foreach($a_computerinventory['oracleinstance'] as $a_oracle) {
               $a_oracle['computers_id'] = $computers_id;
               $pfOracle->add($a_oracle, array(), FALSE);    // add attribute to array.
            }
         }
      }
   [...]    
}
```

Create the associate table into database: *glpi_plugin_fusioninventory_oracles*

The table name must always ends with a plural.
