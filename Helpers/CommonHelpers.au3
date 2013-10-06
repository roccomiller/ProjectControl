
Func Initialize()
   LoadSettings()
   If $CurrentEnvironment = $Environments[0] Then ; Development

   ElseIf $CurrentEnvironment = $Environments[1] Then ; ControlUnit
	  $includeTest = False ; Turn off the test tab
	  $includeSourcControl = False ; Turn off the source control tab
  EndIf
   If Not @Compiled Then
	  $ResourceFile = StringReplace($ResourceFile, ".au3", ".exe", 1)
  EndIf
  Global $StatusBarIcons[7] = [ _
  _WinAPI_ExtractIcon($ResourceFile, 5, 0), _
  _WinAPI_ExtractIcon($ResourceFile, 6, 0), _
  _WinAPI_ExtractIcon($ResourceFile, 7, 0), _
  _WinAPI_ExtractIcon($ResourceFile, 8, 0), _
  _WinAPI_ExtractIcon($ResourceFile, 9, 0), _
  _WinAPI_ExtractIcon($ResourceFile, 10, 0), _
  _WinAPI_ExtractIcon($ResourceFile, 11, 0) _
  ]
   WriteLog("=================================================================")
   WriteLog("UI started")
   WriteLog("=================================================================")
EndFunc

Func _WinAPI_ExtractIcon($sFile, $iIndex, $iSize=0)
	Local $hIcon = DllStructCreate("ptr"), $result
	Switch $iSize
		Case 1
			$result = _WinAPI_ExtractIconEx($sFile, $iIndex, DllStructGetPtr($hIcon), 0, 1)
		Case 0
			$result = _WinAPI_ExtractIconEx($sFile, $iIndex, 0, DllStructGetPtr($hIcon), 1)
	EndSwitch
	If $result=0 Then Return SetError(1,0,0)
	Return DllStructGetData($hIcon,1)
EndFunc


Func Deinitialize()
   WriteLog("=================================================================")
   WriteLog("UI closed")
   WriteLog("=================================================================")
EndFunc

Func LoadSettings()
   If NOT FileExists($SettingsFileName) Then
	  CreateSettings()
   EndIf
   _XMLFileOpen($SettingsFileName)
   Global $CurrentUseICSimulator = _XMLGetAttrib("/c4000AutoItSettings/UseICSimulator", "Use")
   Global $CurrentBasePath = _XMLGetAttrib("/c4000AutoItSettings/BasePath", "Path")
   Global $CurrentEnvironment = _XMLGetAttrib("/c4000AutoItSettings/Environment", "System")
EndFunc

Func SaveSettings()
   If NOT FileExists($SettingsFileName) Then
	  CreateSettings()
   EndIf
   _XMLFileOpen($SettingsFileName)
   _XMLSetAttrib("/c4000AutoItSettings/UseICSimulator", "Use", $CurrentUseICSimulator)
   _XMLSetAttrib("/c4000AutoItSettings/BasePath", "Path", $CurrentBasePath)
   _XMLSetAttrib("/c4000AutoItSettings/Environment", "System", $CurrentEnvironment)
EndFunc

Func CreateSettings()
   _XMLCreateFile($SettingsFileName, "c4000AutoItSettings", True)
   _XMLFileOpen($SettingsFileName)
   _XMLCreateChildNodeWAttr("//c4000AutoItSettings", "UseICSimulator", "Use", $CurrentUseICSimulator)
   _XMLCreateChildNodeWAttr("//c4000AutoItSettings", "Environment", "System", $CurrentEnvironment)
   _XMLCreateChildNodeWAttr("//c4000AutoItSettings", "BasePath", "Path", $CurrentBasePath)
   _XMLCreateChildNode("//c4000AutoItSettings", "IMProcesses")
   For $i = 0 To UBound($IMProcesses) - 1
	  _XMLCreateChildNodeWAttr("//c4000AutoItSettings/IMProcesses", "IMProcess", "Name", $IMProcesses[$i])
   Next
   WriteLog("settings created: " & $SettingsFileName)
EndFunc

Func LoadDefaultSettings()
	If IsDeclared($TEXT_NOTIMPLEMETEDYET) Then
		MsgBox(64, "LoadDefaultSettings", $TEXT_NOTIMPLEMETEDYET)
	EndIf
EndFunc

Func KillAllProcesses()
   SetSystemStatus("Running", "Killing all running c4000 related processes. Please wait...")
   For $i = 0 To UBound($IMProcesses) - 1
	  ProcessClose($IMProcesses[$i])
   Next
   ProcessClose($HL7ProcessName)
   ProcessClose($ICSimulatorProcessName)
   SetSystemStatus("Ready", "All c4000 related processes killed.")
   Return 1
EndFunc

Func WriteLog($logMessage, $severity = "Debug")
   Local $logFile = FileOpen($LogFileName, 1)
   If $logFile = -1 Then
	  ; should not happen
   EndIf
   Local $prefix = @YEAR & "-" & @MON & "-" & @MDAY & " " & @HOUR & ":" & @MIN & ":" & @SEC & "." & @MSEC & ": [" & $severity & "] "
   FileWriteLine($logFile, $prefix & $logMessage)
   FileClose($logFile)
EndFunc

Func TogglePause()
	$ScriptPaused = Not $ScriptPaused
	While $ScriptPaused
		Sleep(100)
		ToolTip("Script is paused", 0, 0, "pause", 2)
	WEnd
	ToolTip("")
EndFunc

Func Terminate()
    Exit 0
EndFunc