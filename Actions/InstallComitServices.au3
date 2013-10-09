#RequireAdmin
$exitCode = RunWait($cmdLine[1] & 'Environment\IISScripts\InstallComitServices.bat ' & $cmdLine[1] & ' developer Debug local')
Exit $exitCode