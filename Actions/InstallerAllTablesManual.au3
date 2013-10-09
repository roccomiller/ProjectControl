#include <Array.au3>
#RequireAdmin
$exitCode = 0

If IsArray($cmdLine) Then
	_ArrayDisplay($cmdLine)
	If $cmdLine[0] = 1 Then
		$exitCode = RunWait($cmdLine[1] & 'Environment\OracleScripts\InstallerAllTablesManual.cmd autorun local')
	ElseIf $cmdLine[0] = 2 Then
		$exitCode = RunWait($cmdLine[1] & 'Environment\OracleScripts\InstallerAllTablesManual.cmd autorun local ' $cmdLine[2])
	Else
		$exitCode = RunWait($cmdLine[1] & 'Environment\OracleScripts\InstallerAllTablesManual.cmd')
	EndIf
EndIf
;~ If $cmdLine[2] = "dev" Then
;~ 	$exitCode = RunWait($cmdLine[1] & 'Environment\OracleScripts\InstallerAllTablesManual.cmd autorun local ' $cmdLine[3])
;~ ElseIf $cmdLine[2] = "test" Then
;~ 	$exitCode = RunWait($cmdLine[1] & 'Environment\OracleScripts\InstallerAllTablesManual.cmd autorun local itest')
;~ Else
;~ 	$exitCode = RunWait($cmdLine[1] & 'Environment\OracleScripts\InstallerAllTablesManual.cmd')
;~ EndIf
Exit $exitCode
;RunWait($CurrentBasePath & 'Environment\OracleScripts\InstallerAllTablesManual.cmd autorun local ' & $CurrentUserPostfix)