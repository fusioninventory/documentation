# Deploy Rest API

This document covers the agent/server protocol used by the "deploy"
task.

This module is used to do remote software deployments and command
executions.

##  Jobs request

###  Request

```
/deploy?action=getJobs&machineid=$machineid&version=$version
```

This method returns the jobs to process for a given machine.

Everytime the agent request this URL, the server has to send it.
Otherwise (empty page) the agent won't continue. This page will be
requested everytime the task is started.

If a job has been processed, the server must remove it from the job
list.

###  Answer

Jobs are processed in the order given by the server.

See [Deploy REST API server answer samples](deploy/answer-samples.md)

###  Answer structure format (jobs)

#### actions

a list of operation to process

`messageBox`: Display an alert to the currently logged user.

* msg: a hash table. keys are language code and the value are the
  strings. "default" is the default language.
* type: the type of box to display to the user. info is an info box.
  postpone lets the user decide if the installation should be
  postponed.

!!! warning
    messageBox action planned for later support<br />Still not supported in Deploy v2.1.0 from FusionInventory-Agent v2.3.18

`cmd`: Execute a command

* retChecks: an array of rule to eval to know if the command
  successed.  Order matter. (types are: okPattern, errorPattern,
  okCode, errorCode)
* exec: a string with the command the launch. 2>&1 is added as suffix
  by the agent at the run time.
* envs: a hash of environment variable to set before the cmd execution
* logLineLimit: the number of line to keep in the log (optional,
  default 3)

`move`: Move a file or directory

* from: source file or directory (* are accepted)
* to: destination file or directory

`copy`: Copy a file

* from: source file or directory (* are accepted)
* to: destination file or directory

`delete`: Delete a list of file or directory. The command works like
rm -Rf $arg

* list: a list of file or directory to remove

`mkdir`: Create a list of directory

* list: a list of directory to create

`installPkg` _(draft/not implemented)_

* name: the package name.
* method (optional): the method to use to install the package,
  (apt,yum).
* repo (optional): the repository to use, e.g: backport-wheezy or
  epel.
* version (optional): the version to use, e.g: ">= 3", "= 3.0-2".

#### associatedFiles

The files (sha512 reference) to be downloaded.
Those sha512 must be listed in the `associatedFiles`
section (array) of the answer.

#### checks

A array of check to evaluate. The code returned to the server and their behaviors a describe below.

* `winkeyExists`: true if $path is a valid key in the Windows
  registry.
* `winkeyEquals`: true if the content of $path in the registry is
  equal with $value
* `winkeyMissing`: true if $path doesn't exist in the Windows
  registry.
* `fileExists`: true if $path is a valid plain file.
* `fileSizeEquals`: true if $path is a file and if its size equals
  $value (Byte).
* `fileSizeGreater`: true if $path is a file and if its size is
  greater than $value (Byte).
* `fileSizeLess`: true if $path is a file and if its size is less than
  $value (Byte).
* `fileMissing`: true is $path is not a file.
* `freespaceGreater`: true if $path freespace is greater than $value
  (MByte).

!!! warning
    Registry path must:<br /><ul><li>start with the complete hive name (HKEY_something)</li><li>use the `/` delimiter (not `\ ` )</li></ul>

A check failure will stop a job and the type of failure can be
interpreted like the following:

* `ignore`: this failure is normal and the job can be
  treated sucessful.
  <br/>
  > For example, the package is already installed or uninstalled

* `error`: this failure is unexpected and the job must be treated like
  a critical error.
  <br/>
  > For example, there is no more space left on the harddrive to
    process installation.

###  Answer structure format (associatedFiles)

Only the files used by the jobs must be in this list.

* `name` : the local name of the file

* `uncompress` : should the archive be extracted

* `mirror`: an array of base URL <br/>
  The mirror path must ends with a `/` if needed. The agent
  will join the mirror path directly with the multipart file name. The
  sha512 checksum is done after the optional gzip.

* `p2p` : does the file be shared with other agents ?

* `p2p-retention-duration`: how long an archive must be kept for
  sharing before its deletion from cache (minutes)

## Update jobs' status

###  Request

```
/deploy?action=setStatus&machineid=$machineid&part=$part&uuid=$uuid&currentStep=$currentStep&status=$status&msg=$msg
```

The agent uses this method to update the status of the deployment.

* `action=setStatus`: the method name
* `machinedid=$machineid`: the machine unique id (mandatory)
* `part=$part`: either 'file' or 'job' (optional, default=job)
* `uuid=$uuid`: the job UUID (mandatory)
* `sha512=$sha512`: the sha512 of the file (mandatory if part=file)
* `status=$status`: 'ko', 'ok'
* `currentStep=$currentStep`:
  received/checking/downloading/extracting/processing (mandatory)
* `msg=$msg`: a 120 character length string, this string must be
  static in order to reduce the transalation effort. (optional)
* `log=$log`: log file sent through in UNIX format (\n). (looks below)
* `checknum=$checknum`: the check number (optional), start at 0
* `actionnum=$actionnum`: the action number (optional), start at 0



Current Step:

* received (job): the agent received the job request _(not
  implemented)_
* downloading (file) the agent started to check the mirror to download
  the file
* extracting (job): preparing the working directory
* processing (job): the agent is processing the job

The status:

* ko (job, file): the job processing or the file downloading had been
  abort
* ok (job, file): the job processing or the file downloading had been
  successful

The log:

The log length shouldn't be greater than 1000 caracters. If the value
is above, the begining may be silently truncated by the agent.

###  Answer

The expected answer is a JSON encoded empty hash ref {}.


##  Multipart

The multipart is the list of the file to download (from one to
unlimited). This can file name can include a relative directory path
too. Once the downloads are down, they will be joined together in the
list order. If the subfile has a .gz suffix, it will be extracted
first.

The agent will use the .gz extension of the part file to identify an
optional compression. So be careful if the initial file has already
this extension, you need to rename it to something like
file.tar.gz-01.

### Request

POST a log file for a given job.

``` shell
#!/bin/sh

MIRROR="http://deploy/ocsinventory/deploy/prepare/"
FILE=$1

if [ -z $FILE ]; then
echo "exit"
exit 1
fi
split $FILE $FILE

sha512=`sha512sum $FILE|awk '{print $1}'`
echo "

\"$sha512\" : {
\"uncompress\" : 1,
    \"mirror\" : [
    \"https://mirror.local/temp/\",
    \"$MIRROR\",
    \"//mirror.win/temp/\",
    \"ftp://mirror.win/temp/\",
    \"http://central.server/download?file=\"
    ],
    \"p2p\" : 1,
    \"multipart\" : ["
request
first=""
for part in $FILE?*; do
    [ ! -z $first ] && echo ','
    echo {\"$part\" : \"`sha512sum $part|awk '{print $1}'`\"}
    first="no"
done

echo "
    ],
    \"name\" : \"$FILE\"
    }
"
```

## Communication examples

Get the job, download the file and run the command.

    http://localhost:8080/deploy1?action=getJobs&machineid=fakeid
    http://localhost:8080/deploy1?action=setStatus&currentStep=checking&part=job&machineid=fakeid&uuid=0fae2958-24d5-0651-c49c-d1fec1766af650
    http://localhost:8080/deploy1?action=setStatus&currentStep=downloading&part=job&machineid=fakeid&uuid=0fae2958-24d5-0651-c49c-d1fec1766af650
    http://localhost:8080/deploy1?action=setStatus&sha512=60ace8efe87aa2a6ef3fed5392fef70bd2d733e198d6965135dd44ea3b8b7cf9937dd03cbfe3206fe11e0ed23e9dd489a1c1e6fa71bf912f229917bef30aeafe&currentStep=downloading&part=file&machineid=fakeid&uuid=0fae2958-24d5-0651-c49c-d1fec1766af650
    http://localhost:8080/deploy1?action=setStatus&sha512=60ace8efe87aa2a6ef3fed5392fef70bd2d733e198d6965135dd44ea3b8b7cf9937dd03cbfe3206fe11e0ed23e9dd489a1c1e6fa71bf912f229917bef30aeafe&status=ok&currentStep=downloading&part=file&machineid=fakeid&uuid=0fae2958-24d5-0651-c49c-d1fec1766af650
    http://localhost:8080/deploy1?action=setStatus&status=ok&currentStep=downloading&part=job&machineid=fakeid&uuid=0fae2958-24d5-0651-c49c-d1fec1766af650
    http://localhost:8080/deploy1?action=setStatus&status=ok&part=job&machineid=fakeid&uuid=0fae2958-24d5-0651-c49c-d1fec1766af650

Failed to download the file 60ace8e(...)

    http://localhost:8080/deploy1.1?action=getJobs&machineid=fakeid
    http://localhost:8080/deploy1.1?action=setStatus&currentStep=checking&part=job&machineid=fakeid&uuid=0fae2958-24d5-0651-c49c-d1fec1766af650
    http://localhost:8080/deploy1.1?action=setStatus&currentStep=downloading&part=job&machineid=fakeid&uuid=0fae2958-24d5-0651-c49c-d1fec1766af650
    http://localhost:8080/deploy1.1?action=setStatus&sha512=60ace8efe87aa2a6ef3fed5392fef70bd2d733e198d6965135dd44ea3b8b7cf9937dd03cbfe3206fe11e0ed23e9dd489a1c1e6fa71bf912f229917bef30aeafe&currentStep=downloading&part=file&machineid=fakeid&uuid=0fae2958-24d5-0651-c49c-d1fec1766af650
    http://localhost:8080/deploy1.1?action=setStatus&msg=download%20failed&sha512=60ace8efe87aa2a6ef3fed5392fef70bd2d733e198d6965135dd44ea3b8b7cf9937dd03cbfe3206fe11e0ed23e9dd489a1c1e6fa71bf912f229917bef30aeafe&status=ko&currentStep=downloading&part=file&machineid=fakeid&uuid=0fae2958-24d5-0651-c49c-d1fec1766af650

Fails to run a command and set the log file.

    http://localhost:8080/deploy4?action=getJobs&machineid=fakeid
    http://localhost:8080/deploy4?action=setStatus&currentStep=checking&part=job&machineid=fakeid&uuid=0fae2958-24d5-0651-c49c-d1fec1766af650
    http://localhost:8080/deploy4?action=setStatus&currentStep=downloading&part=job&machineid=fakeid&uuid=0fae2958-24d5-0651-c49c-d1fec1766af650
    http://localhost:8080/deploy4?action=setStatus&status=ok&currentStep=downloading&part=job&machineid=fakeid&uuid=0fae2958-24d5-0651-c49c-d1fec1766af650
    http://localhost:8080/deploy4?action=setStatus&log[]=%20%20%20%20osname%3Dlinux%2C%20osvers%3D2.6.32-5-amd64%2C%20archname%3Dx86_64-linux-gnu-thread-multi&log[]=%20%20Platform%3A&log[]=%20%20%20&log[]=Summary%20of%20my%20perl5%20%28revision%205%20version%2012%20subversion%204%29%20configuration%3A&log[]=--------------------------------&log[]=exit%20status%3A%20%600%27&log[]=exit%20status%20is%20not%20ok%3A%20%600%27&machineid=fakeid&uuid=0fae2958-24d5-0651-c49c-d1fec1766af650&actionnum=0
    http://localhost:8080/deploy4?action=setStatus&msg=action%20processing%20failure&status=ko&currentStep=processing&part=job&machineid=fakeid&uuid=0fae2958-24d5-0651-c49c-d1fec1766af650&actionnum=0

Run a command without issue.

    http://localhost:8080/deploy5?action=getJobs&machineid=fakeid
    http://localhost:8080/deploy5?action=setStatus&currentStep=checking&part=job&machineid=fakeid&uuid=0fae2958-24d5-0651-c49c-d1fec1766af650
    http://localhost:8080/deploy5?action=setStatus&currentStep=downloading&part=job&machineid=fakeid&uuid=0fae2958-24d5-0651-c49c-d1fec1766af650
    http://localhost:8080/deploy5?action=setStatus&status=ok&currentStep=downloading&part=job&machineid=fakeid&uuid=0fae2958-24d5-0651-c49c-d1fec1766af650
    http://localhost:8080/deploy5?action=setStatus&status=ok&currentStep=processing&part=job&machineid=fakeid&uuid=0fae2958-24d5-0651-c49c-d1fec1766af650&actionnum=0
    http://localhost:8080/deploy5?action=setStatus&status=ok&part=job&machineid=fakeid&uuid=0fae2958-24d5-0651-c49c-d1fec1766af650

Second action (actionnum=1) failed.

    http://localhost:8080/deploy13?action=getJobs&machineid=fakeid
    http://localhost:8080/deploy13?action=setStatus&currentStep=checking&part=job&machineid=fakeid&uuid=0fae2958-24d5-0651-c49c-d1fec1766af650
    http://localhost:8080/deploy13?action=setStatus&currentStep=downloading&part=job&machineid=fakeid&uuid=0fae2958-24d5-0651-c49c-d1fec1766af650
    http://localhost:8080/deploy13?action=setStatus&status=ok&currentStep=downloading&part=job&machineid=fakeid&uuid=0fae2958-24d5-0651-c49c-d1fec1766af650
    http://localhost:8080/deploy13?action=setStatus&status=ok&currentStep=processing&part=job&machineid=fakeid&uuid=0fae2958-24d5-0651-c49c-d1fec1766af650&actionnum=0
    http://localhost:8080/deploy13?action=setStatus&log[]=Failed%20to%20move%20file%3A%20%27%2Fhome%2Fgoneri%2Ffusioninventory%2Fagent-task-deploy%2Ft%2F..%2Ftmp%2Fdeploy-test%2Fserver%2FDeploy.totorMissing%27%20to%20%27%2Fhome%2Fgoneri%2Ffusioninventory%2Fagent-task-deploy%2Ft%2F..%2Ftmp%2Fdeploy-test%2Fserver%2FDeploy.titi%27&log[]=Aucun%20fichier%20ou%20dossier%20de%20ce%20type&machineid=fakeid&uuid=0fae2958-24d5-0651-c49c-d1fec1766af650&actionnum=1
    http://localhost:8080/deploy13?action=setStatus&msg=action%20processing%20failure&status=ko&currentStep=processing&part=job&machineid=fakeid&uuid=0fae2958-24d5-0651-c49c-d1fec1766af650&actionnum=1
