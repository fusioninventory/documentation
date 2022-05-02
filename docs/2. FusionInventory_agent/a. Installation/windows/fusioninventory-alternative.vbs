Option Explicit
On Error Resume Next
Dim AvailableVersion, InstalledVersion, FusionArguments, UpdateArguments, FusionSetupExe, WshShell, OSType, InstallCommand, UpdateCommand, InstalledKey
'
' User settings
'
AvailableVersion = "2.2.7-1" 
FusionArguments = "/S /tag=MyTag /server=http://server/glpi/plugins/fusioninventory/ /rpc-trust-localhost /runnow"
UpdateArguments = "/execmode=none"
FusionSetupExe = "\\server\netlogon\fusioninventory\fusioninventory-agent_windows-i386_" & AvailableVersion & ".exe" 
'
'DO NOT EDIT BELOW
'
InstallCommand = FusionSetupExe & " " & FusionArguments
UpdateCommand = InstallCommand & " " & UpdateArguments

Set WshShell = Wscript.CreateObject("Wscript.shell")

' Get OS Type, 32 or 64 bit
OsType = WshShell.RegRead("HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment\PROCESSOR_ARCHITECTURE")

' Extract installed version from registry
if (OsType = "x86") then
    InstalledKey = "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\FusionInventory Agent\DisplayVersion" 
else
    InstalledKey = "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\FusionInventory Agent\DisplayVersion" 
end if

' Install FusionInventory if not yet installed
' Update FusionInventory if available version is different from installed one
InstalledVersion = WshShell.RegRead(InstalledKey)
if InstalledVersion = "" then
    Wscript.Echo "FusionInventory not installed, installing version " & AvailableVersion
    Wscript.Echo "Running command: " & InstallCommand
    'WshShell.Run "CMD.EXE /C """ & InstallCommand & """",0,True
elseif InstalledVersion <> AvailableVersion then
    Wscript.Echo "Installed version: " & InstalledVersion & " -  New version available: " & AvailableVersion
    Wscript.Echo "Running command: " & UpdateCommand
    'WshShell.Run "CMD.EXE /C """ & UpdateCommand & """",0,True
else
    Wscript.Echo "Current version " & InstalledVersion & " is up to date" 
end if
