# Deploy REST API answer samples

# On deployement job list with audit checks and post deployment actions

In this example, one job depends on 2 files. The agent will download
the two files and then will process the order.  The order can be
started until maxValidityDate (GMT).  The files unique ID
are their sha512 signature.

``` json
{
   "jobs" : [
      {
         "checks" : [
            {
               "path" : "HKEY_LOCAL_MACHINE/SOFTWARE/Microsoft/Windows NT/CurrentVersion/ProductName",
               "type" : "winkeyExists",
               "return" : "ignore"
            },
            {
               "value" : "SYSTEM",
               "match" : "winkeyEquals",
               "path" : "HKEY_LOCAL_MACHINE/SOFTWARE/Microsoft/Windows NT/CurrentVersion/SoftwareType",
               "return" : "error"
            },
            {
               "match" : "winkeyMissing",
               "path" : "HKEY_LOCAL_MACHINE/SOFTWARE/Microsoft/Windows NT/fooBar",
               "return" : "ignore"
            },
            {
               "path" : "c:/tmp.log",
               "type" : "fileExists",
               "return" : "ignore"
            },
            {
               "value" : 345,
               "path" : "c:/tmp2.log",
               "type" : "fileSizeEquals",
               "return" : "ignore"
            },
            {
               "value" : 45,
               "path" : "c:/tmp2.log",
               "type" : "fileSizeGreater",
               "return" : "error"
            },
            {
               "path" : "c:/tmp.log",
               "type" : "fileMissing",
               "return" : "ignore"
            },
            {
               "value" : 500000,
               "path" : "c:/",
               "type" : "freespaceGreater",
               "return" : "ignore"
            }
         ],
         "actions" : [
            {
               "messageBox" : {
               "checks" : [
                  {
                     "path" : "c:/no-popup.txt",
                     "type" : "fileExists",
                     "return" : "ignore"
                  }
               ],
                  "msg" : {
                     "fr" : "Une mise a jour de votre poste va etre realisee.",
                     "default" : "An upgrade of your post will be done. Please wait."
                  },
                  "timeout" : 600,
                  "type" : "info",
                  "title" : {
                     "fr" : "Boite a message",
                     "default" : "Message box"
                  }
               }
            },
            {
               "messageBox" : {
               "checks" : [
                  {
                     "path" : "c:/no-popup.txt",
                     "type" : "fileExists",
                     "return" : "ignore"
                  }
               ],
                  "msg" : {
                     "fr" : "Voulez-vous lancer la mise a jour maintenant",
                     "default" : "Do you want to launch the upgrade now?"
                  },
                  "timeout" : 600,
                  "type" : "postpone"
               }
            },
            {
               "cmd" : {
               "checks" : [
                  {
                     "path" : "c:/no-popup.txt",
                     "type" : "fileExists",
                     "return" : "ignore"
                  }
               ],
                  "retChecks" : [
                     {
                        "values" : [
                           "ok"
                        ],
                        "type" : "okPattern"
                     },
                     {
                        "values" : [
                           "error",
                           "warning"
                        ],
                        "type" : "errorPattern"
                     },
                     {
                        "values" : [
                           1,
                           54
                        ],
                        "type" : "okCode"
                     },
                     {
                        "values" : [
                           3,
                           53
                        ],
                        "type" : "errorCode"
                     }
                  ],
                  "exec" : "install.exe arg1 arg2",
                  "envs" : {
                     "LANGUAGE" : "de",
                     "OS" : "win",
                     "HOSTNAME" : "babel",
                     "ARCH" : "x64",
                     "OS_VERSION" : "5.1"
                  }
               }
            },
            {
               "move" : {
                  "from" : "install.ini",
                  "to" : "c:/myApp/toto"
               }
            },
            {
               "delete" : {
                  "list" : [
                  "c:/install.log",
                  "c:/foo.bar" ]
               }
            }
         ],
         "maxValidityDate" : 12334546,
         "associatedFiles" : [
            "8e9392b884d631728f917bd1231256f4c44618fd39afdd7385cc654e82affe747d8ec4f65ef9b55c6b1c517c340bf9af6c53291815dbab4e8f6176be2a511b10",
            "cd98fb514b2803d496a0f5c10f4fc8c069998fa4556c0dfbe27b95d742e0d218ec61d69ee42b092d008a542190fc78988b53ee43998d9688c978dac96864ff1a"
         ],
         "uuid" : "0fae2958-24d5-0651-c49c-d1fec1766af650"
      }
   ],
   "associatedFiles" : {
      "cd98fb514b2803d496a0f5c10f4fc8c069998fa4556c0dfbe27b95d742e0d218ec61d69ee42b092d008a542190fc78988b53ee43998d9688c978dac96864ff1a" : {
         "uncompress" : 0,
         "mirrors" : [
            "http://central.server/getConfig?d="
         ],
         "multiparts" : [
            "cd98fb514b2803d496a0f5c10f4fc8c069998fa4556c0dfbe27b95d742e0d218ec61d69ee42b092d008a542190fc78988b53ee43998d9688c978dac96864ff1a"
         ],
         "p2p" : 1,
         "p2p-retention-duration" : 36000,
         "name" : "install.ini"
      },
      "8e9392b884d631728f917bd1231256f4c44618fd39afdd7385cc654e82affe747d8ec4f65ef9b55c6b1c517c340bf9af6c53291815dbab4e8f6176be2a511b10" : {
         "uncompress" : 1,
         "mirrors" : [
            "http://mirror.local/temp/",
            "https://mirror.local/temp/",
            "//mirror.win/temp/",
            "ftp://mirror.win/temp/",
            "http://central.server/download?file="
         ],
         "multiparts" : [
            "34324234545435645645645645674567456745674567456745674567456745674567456745674567456745674567456745674567456745674576457645674567",
            "34345670987654320987654309876543209876789098765434567898765445678987654567898765456789875456789876545678987656789876545678765670",
            "98765434567890987654567890987654567890987654567890987654345678909876543456789098765456789098765456789098765456789876567898765660",
            "09874323456765434567876545678765445678765456898765456898765445678909876543456789876543456789098765456789987654567887654567887610"
         ],
         "p2p" : 1,
         "name" : "winInst.zip"
      },
      "fa939923b3a7502ca0b5fe02f006ac95eed54579595eb4b6a6dd6e97d11a18566835f76f0cd87d29646e333b396d69afff07a538f0cfd2d1d67a29aed2752b16" : {
         "uncompress" : 1,
         "mirrors" : [
            "https://mirror.local/temp/",
            "http://deploy/ocsinventory/deploy/prepare/",
            "//mirror.win/temp/",
            "ftp://mirror.win/temp/",
            "http://central.server/download?file="
         ],
         "name" : "glpi-0.78.2.tar.gz",
         "multiparts" : [
            "7dc573cc9d1eb905259861b42fa065199ddeab18e9ef8ffc548d1bd95b92c688d32122d083dba101c349e8247cc52b1d866083d9a23be0b6ce2bed8a95d3bb1a",
            "fef0ccfdeb9fbdead221ee9e7cba5188a0e672b7dd5b0ec64361c4c2f3bf443344d13076041faa71236f0c5555882a83d6c7013399a345e696682f475a3d780b",
            "fde60d2ceff15b67a80e30e861b665fcb553cda4e6e78d9ea3c1983937a1076fc390889991b23b8e2633e1d69fbd65eda2818eb5af48e9ecc458cff889d38ec0",
            "87efdb41d680695fc3f08dc34c7d86e859eee71ff6429b98c92d16fb68000630b0a67d45cf2f77f6031632e6c2641bf55681c5ad7c58c2a2039e722ceda37bbf",
            "51d7d9fad06ec3a2022487b6560d1f37c59c0114e5825a576d2a33075b087979c34d384ee1dca6c59c537947a8eb45911a87b7a9e9e0c38c5ddcab4c0bbaa937",
            "aff3d39921dce089875891c4e730560d6c651dd8b217314a78829303bf41614f04f52d7a978b177d7cea18e87a069528eaeaee489b83b33705fb67296787121a",
            "c3464fbe1c79c4f925070f150ee3231fb8cac199b1773d85176cc50d088baeebd49acf0f6c1be929dce28dfce7038cf58dce50675fb8df010f7f61df05ceae96",
            "210f240e08643fb46d512f1c53392ead8a981582cabcf3094706bc9e37d45e0e5d80fe5aec4ce67a1e04413261571009c1a395cdc05fd46d356888b247735a08",
            "6a69c79a8fc4484be8bf425c2dc7c18da6c537d7fd7bd1a62cbae3c5102bfb484319d24f3a789522af06e80a49b9464e76d1c21586a6c15d25af2de614dbf8b6",
            "db49d203092ba6d8cd8fd7c1d45a524bdaf8e9f245397b3b6c1256f1d716509292e494d0589fdfe56ee29a59e4266ad63e9f7fdae80c92860f2b84676fd9ce9d",
            "307ee18ea1fc6540e4c84d583ab10f9074654a456466273b0efc7d419a86360d1ec2db3ef0976995e15db68a765a6171f217dcf3de7253bfb679d8c9f45f9a2b",
            "a36263c1cedc8d2e1c0b9e6c17768e418ba8e721c717fe795ba4c883f9bfec5d10cce540efe75b4c3b0a1f22e6e5d2e3557f28f6e6cefecb416dcaaf35fda3be",
            "048a0a51496cf47784bd503f0436eb5ef79a68aeeb807100b0e276203e62e016f03210232490f2f4004822b8d287bb7d7ec778deff6d0f528c46fae7ed332902",
            "e363b07938ed5213d81f9d8f0139e9059e7e6b1fe96285d2a122041a73093868c8578a1e0082e875d9f3262b5a158f58330801536fee72aeeda1f82752e3f2a2",
            "6075de7f966c70f0b0713cb59d092f60a2fba1fb0ff08cb71e2881207f66e2e081669ed3308d8510e3a0f4bc2eb4840f9a96a10c8917166019bdee6010f6d3dc"
         ],
         "p2p" : 0
      }
   }
}
```
