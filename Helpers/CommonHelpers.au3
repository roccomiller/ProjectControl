
Func Initialize()
	LoadSettings()
	If $CurrentEnvironment = $Environments[0] Then ; Development
		$includeTest = False
		$includeSourceControl = True
		$includePreparation = True
		$includeRoundtrips = False
		$includeBackup = False
	ElseIf $CurrentEnvironment = $Environments[1] Then ; ControlUnit
		$includeTest = False ; Turn off the test tab
		$includeSourceControl = False ; Turn off the source control tab
		$includePreparation = False
		$includeRoundtrips = True
		$includeBackup = True
	ElseIf $CurrentEnvironment = $Environments[2] Then ; AutoIt-Dev
		$includeTest = True
		$includeSourceControl = True
		$includePreparation = True
		$includeRoundtrips = True
		$includeBackup = True
	EndIf
   If Not @Compiled Then
	  $ResourceFile = StringReplace($ResourceFile, ".au3", ".exe", 1)
  EndIf
  Global Const $AnimationCharacters[4] = ["[-]", "[\]", "[|]", "[/]"]
  Global $StatusBarIcons[7] = [ _
  _WinAPI_ExtractIcon($ResourceFile, 6, 0), _
  _WinAPI_ExtractIcon($ResourceFile, 7, 0), _
  _WinAPI_ExtractIcon($ResourceFile, 8, 0), _
  _WinAPI_ExtractIcon($ResourceFile, 9, 0), _
  _WinAPI_ExtractIcon($ResourceFile, 10, 0), _
  _WinAPI_ExtractIcon($ResourceFile, 11, 0), _
  _WinAPI_ExtractIcon($ResourceFile, 12, 0) _
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
   Global $CurrentDatabaseLocation = _XMLGetAttrib("/c4000AutoItSettings/DatabaseLocation", "Location")
   Global $CurrentUserPostfix = _XMLGetAttrib("/c4000AutoItSettings/UserPosfix", "Postfix")
   Global $CurrentUseICSimulator = _XMLGetAttrib("/c4000AutoItSettings/UseICSimulator", "Use")
   Global $CurrentBasePath = _XMLGetAttrib("/c4000AutoItSettings/BasePath", "Path")
   Global $CurrentEnvironment = _XMLGetAttrib("/c4000AutoItSettings/Environment", "System")
   Global $CurrentBuildConfiguration = _XMLGetAttrib("/c4000AutoItSettings/Build", "Configuration")
EndFunc

Func SaveSettings()
	If NOT FileExists($SettingsFileName) Then
		CreateSettings()
	EndIf
	_XMLFileOpen($SettingsFileName)
	_XMLSetAttrib("/c4000AutoItSettings/DatabaseLocation", "Location", $CurrentDatabaseLocation)
	_XMLSetAttrib("/c4000AutoItSettings/UserPosfix", "Postfix" , $CurrentUserPostfix)
	_XMLSetAttrib("/c4000AutoItSettings/UseICSimulator", "Use", $CurrentUseICSimulator)
	_XMLSetAttrib("/c4000AutoItSettings/BasePath", "Path", $CurrentBasePath)
	_XMLSetAttrib("/c4000AutoItSettings/Environment", "System", $CurrentEnvironment)
	_XMLSetAttrib("/c4000AutoItSettings/Build", "Configuration", $CurrentBuildConfiguration)
EndFunc

Func CreateSettings()
	_XMLCreateFile($SettingsFileName, "c4000AutoItSettings", True)
	_XMLFileOpen($SettingsFileName)
	_XMLCreateChildNodeWAttr("/c4000AutoItSettings", "DatabaseLocation", "Location", $CurrentDatabaseLocation)
	_XMLCreateChildNodeWAttr("/c4000AutoItSettings", "UserPosfix", "Postfix", $CurrentUserPostfix)
	_XMLCreateChildNodeWAttr("/c4000AutoItSettings", "UseICSimulator", "Use", $CurrentUseICSimulator)
	_XMLCreateChildNodeWAttr("/c4000AutoItSettings", "Environment", "System", $CurrentEnvironment)
	_XMLCreateChildNodeWAttr("/c4000AutoItSettings", "Build", "Configuration", $CurrentBuildConfiguration)
	_XMLCreateChildNodeWAttr("/c4000AutoItSettings", "BasePath", "Path", $CurrentBasePath)
	_XMLCreateChildNode("/c4000AutoItSettings", "IMProcesses")
	For $i = 0 To UBound($IMProcesses) - 1
		_XMLCreateChildNodeWAttr("/c4000AutoItSettings/IMProcesses", "IMProcess", "Name", $IMProcesses[$i])
	Next
	WriteLog("settings created: " & $SettingsFileName)
EndFunc

Func LoadDefaultSettings()
	;~ Idea to implement
	;~ delete settings.xml file
	;~ restart tool...
	If IsDeclared($TEXT_NOTIMPLEMETEDYET) Then
		MsgBox(64, "LoadDefaultSettings", $TEXT_NOTIMPLEMETEDYET)
	EndIf
EndFunc

Func KillAllProcesses()
	SetSystemStatus("Running", "Killing all running c4000 related processes. Please wait...")
	WinClose("cobas4000")
	For $i = 0 To UBound($IMProcesses) - 1
		If Not ($IMProcesses[$i] = $IMProcesses[2]) Then ;iexplorer.exe
			ProcessClose($IMProcesses[$i])
		EndIf
	Next
	ProcessClose($HL7SimulatorProcess[1])
	ProcessClose($ICSimulatorProcess[1])
	SetSystemStatus("Ready", "All c4000 related processes killed.")
	Return 1
EndFunc

;~<summary>
;~Starts a new process.
;~</summary>
;~<param name="$processPath">The path to the execuable to start.</param>
;~<param name="$processName">The name of the execuable to start.</param>
;~<param name="$workingDirectory">The working directory where the executable should run. If set to empty string, it will be ignored.</param>
;~<param name="$windowTitle">The title of the window from the process to start. Can be set to empty string if the process does not have a window or you don't know it.</param>
;~<param name="$waitForStart">If set to 'True', the methode waits synchronously until the process is running or the window is visible.</param>
;~<param name="$forceStart">If set to 'True', the process will be started even when the same process is alreay running.</param>
;~<returns>0 if process is alreay running, 1 if process is successfully started and -1 if process could not be started</returns>
Func StartNewProcess($processPath, $processName, $workingDirectory, $windowTitle, $waitForStart, $forceStart)
	;~ check if executable exists
	Local $process = $processPath & $processName
	Local $pid = 0
	If FileExists($process) Then
		;~ check if the process is already running
		If Not ($forceStart) And ProcessExists($processName) Then
			SetSystemStatus("Ready", $processName & " is already running, no need to start it.")
			Return 0
		Else
			If Not ($workingDirectory = "") And FileExists($workingDirectory) Then
				$pid = Run($process, $workingDirectory)
			Else
				$pid = Run($process)
			EndIf
			If Not ($pid = 0) Then
				If $waitForStart And Not ($windowTitle = "") Then
					SetSystemStatus("Waiting", "Process '" & $processName & "' started, waiting for the process window with title '" & $windowTitle & "'.")
					WinWait($windowTitle)
					;MsgBox(0, "pid", $pid)
					;$list = WinList()
					;_ArrayDisplay($list)

					SetSystemStatus("Success", "Process '" & $processName & "' started and window with title '" & $windowTitle & "' is shown.")
					Return 1
				EndIf
			Else
				SetSystemStatus("Error", "Could not start " & $process)
				WriteLog("Could not start executable: " & $process & "." & @CRLF & "Error is: " & @error)
				Return -1
			EndIf
		EndIf
	Else
		SetSystemStatus("Error", "Could not finde file: " & $process)
		WriteLog("Could not find file: " & $process)
		Return -1
	EndIf
EndFunc

;~<summary>
;~Checks if a process related to c4000 is running.
;~</summary>
;~<param name="$checkIM">If set to True, the methode checks if one of the c4000 processes is running.</param>
;~<param name="$checkIC">If set to True, the methode checks if the IC simulator is running.</param>
;~<param name="$checkHL7">If set to True, the methode checks if the HL7 simulator is running.</param>
;~<returns>Boolean array of size 3. If the proccess is running the bool is set to True, false otherwise.</returns>
Func CheckRunningProcesses($checkIM, $checkIC, $checkHL7)
	Local $isRunning[3] = [False, False, False]
	;~ check if a c4000 process is running
	If $checkIM Then
		For $i = 0 To UBound($IMProcesses) - 1
			If Not ($IMProcesses[$i] = $IMProcesses[2]) And ProcessExists($IMProcesses[$i]) Then
				$isRunning[0] = True
			ExitLoop
			EndIf
		Next
		If Not $isRunning[0] Then
			Local $uiHandle = WinGetHandle("cobas4000")
			If Not ($uiHandle = "") And @error = 1 Then
				$isRunning[0] = True
			EndIf
		EndIF
	EndIf

	;~ check if the IC simulator is running
	If $checkIC Then
		If ProcessExists($ICSimulatorProcess[1]) Then
			$isRunning[1] = True
		EndIf
	EndIf

	;~ check if the HL7 simulator is running
	If $checkHL7 Then
		If ProcessExists($HL7SimulatorProcess[1]) Then
			$isRunning[2] = True
		EndIf
	EndIf
	Return $isRunning
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

Func OpenLogFile()
	Run("cmd /c start " & $LogFileName)
EndFunc

Func ClearLogFile()
	FileDelete($LogFileName)
	FileOpen($LogFileName, 1)
EndFunc

Func ShowHelpFile()
	;~ must be hardcoded, FileInstall does not accept variables.
	FileInstall("Documentation\Documentation.chm", "Help.chm")
	Run("cmd /c start " &  @ScriptDir & "\Help.chm")
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
	Deinitialize()
    Exit 0
EndFunc

#region UI
Func MyMouseClick($x, $y, $delay = 500)
	MouseClick("", $x, $y, 1)
	Sleep($delay)
EndFunc

Func MyMouseClickXY($xy, $delay = 500)
	If IsArray($xy) Then
		MyMouseClick($xy[0], $xy[1], $delay)
	Else
		MyMouseClick($xy, $delay)
	EndIf
EndFunc

Func MyMouseDoubleClick($x, $y, $delay = 500)
	MouseClick("", $x, $y, 2)
	Sleep($delay)
EndFunc
#endregion UI