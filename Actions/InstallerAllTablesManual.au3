#include <Array.au3>
#RequireAdmin
$exitCode = 0
If IsArray($cmdLine) Then
	;_ArrayDisplay($cmdLine)
	If $cmdLine[0] = 1 Then
		$exitCode = RunWait($cmdLine[1] & 'Environment\OracleScripts\InstallerAllTablesManual.cmd autorun local') ; no postfix
	ElseIf $cmdLine[0] = 2 Then
		$exitCode = RunWait($cmdLine[1] & 'Environment\OracleScripts\InstallerAllTablesManual.cmd autorun ' & $cmdLine[2]) ; no postfix
	ElseIf $cmdLine[0] = 3 Then
		$exitCode = RunWait($cmdLine[1] & 'Environment\OracleScripts\InstallerAllTablesManual.cmd autorun ' & $cmdLine[2] & ' ' & $cmdLine[3]) ; postfix
	Else
		$exitCode = RunWait($cmdLine[1] & 'Environment\OracleScripts\InstallerAllTablesManual.cmd')
	EndIf
EndIf
Exit $exitCode