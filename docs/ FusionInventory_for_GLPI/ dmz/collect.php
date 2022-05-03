<?php
# Collect inventory and store them in $dumpDir
# Usage :
#  fusioninventory-agent --server http://server/collect.php
$dumpDir = '/tmp';

##########################################################################
$http_raw_post_data = file_get_contents('php://input');

if (!$http_raw_post_data) {
    return;
}

$compressmode = 'none';
if (strpos($http_raw_post_data, "<?xml") === 0) {
    $xml = $http_raw_post_data;
} else if ($xml = @gzuncompress($http_raw_post_data)) {
    $compressmode = "gzcompress";
} else if ($xml = @gzinflate ("\x1f\x8b\x08\x00\x00\x00\x00\x00".$http_raw_post_data)) {
    // ** OCS agent 2.0 Compatibility, but return in gzcompress
    $compressmode = "gzdeflate";
    if (strstr($xml, "<QUERY>PROLOG</QUERY>")
            AND !strstr($xml, "<TOKEN>")) {
        $compressmode = "gzcompress";
    }
} else if ($xml = @gzinflate (substr($http_raw_post_data, 2))) {
    // ** OCS agent 2.0 Compatibility, but return in gzcompress
    $compressmode = "gzdeflate";
    if (strstr($xml, "<QUERY>PROLOG</QUERY>")
            AND !strstr($xml, "<TOKEN>")) {
        $compressmode = "gzcompress";
    }
} else {
    $f = tempnam('/tmp', 'gz_fix');
    file_put_contents($f, "\x1f\x8b\x08\x00\x00\x00\x00\x00".$http_raw_post_data);
    $xml = file_get_contents('compress.zlib://'.$f);

    unlink($f);

    if (strpos($xml, "<?xml") === 0) {
        $compressmode = "gzcompress";
    } else {
        $xml = '';
    }
}

if (strpos($xml, "<?xml") !== 0) {
    error_log("failed to extract XML content");
}

$reply = "";
if (preg_match('/QUERY>PROLOG<\/QUERY/', $xml)) {
    $reply= '<?xml version="1.0" encoding="UTF-8"?>
        <REPLY>
           <RESPONSE>SEND</RESPONSE>
           <PROLOG_FREQ>8</PROLOG_FREQ>
        </REPLY>';
} else {
    $reply = "<?xml version='1.0' encoding='UTF-8'?>
       <REPLY>
       </REPLY>";
    $invFile = sprintf('%s/%s.xml', $dumpDir, $_SERVER['REMOTE_ADDR']);
    if (!file_put_contents($invFile, $xml)) {
        error_log("Failed to write ");
    }
}

switch($compressmode) {
    case 'none':
        print $reply;
        break;

    case 'gzcompress':
        print gzcompress($reply);
        break;

    case 'gzencode':
        print gzencode($reply);
        break;

    case 'gzdeflate':
        print gzdeflate($reply);
        break;

}
