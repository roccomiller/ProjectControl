
;~ Declare all used checkboxes here to prevent warnings in the usage
#region Checkbox declaration
Global $CBX_SourceControl_UndoAllPendingChanges
Global $CBX_SourceControl_RemoveDev
Global $CBX_SourceControl_GetLatest
Global $CBX_SourceControl_GetTheDependecies
Global $CBX_SourceControl_BuildIMSolution
Global $CBX_SourceControl_RemoveComitServices
Global $CBX_SourceControl_AdaptTheConfigFiles

Global $CBX_SourceControl_All
#endregion Checkbox declaration

Func SetSourceControlCheckBoxState()
	SetCheckBoxState($SourceControlCheckBoxes, GUICtrlRead($CBX_SourceControl_All))
EndFunc

Func SourceControlAction_Click()
   DisableAllControlls()
   Local $previousActionResult = 1
   If GUICtrlRead($CBX_SourceControl_UndoAllPendingChanges) = $GUI_CHECKED And $previousActionResult = 1 Then
	  $previousActionResult = UndoAllPendingChanges()
   EndIf
   If GUICtrlRead($CBX_SourceControl_RemoveDev) = $GUI_CHECKED And $previousActionResult = 1 Then
	  $previousActionResult = RemoveDev()
   EndIf
   If GUICtrlRead($CBX_SourceControl_GetLatest) = $GUI_CHECKED And $previousActionResult = 1 Then
	  $previousActionResult = GetLatest()
   EndIf
   If GUICtrlRead($CBX_SourceControl_GetTheDependecies) = $GUI_CHECKED And $previousActionResult = 1 Then
	  $previousActionResult = GetTheDependecies()
   EndIf
   If GUICtrlRead($CBX_SourceControl_BuildIMSolution) = $GUI_CHECKED And $previousActionResult = 1 Then
	  $previousActionResult = BuildIMSolution()
   EndIf
   If GUICtrlRead($CBX_SourceControl_RemoveComitServices) = $GUI_CHECKED And $previousActionResult = 1 Then
	  $previousActionResult = RemoveComitServices()
   EndIf
   If GUICtrlRead($CBX_SourceControl_AdaptTheConfigFiles) = $GUI_CHECKED And $previousActionResult = 1 Then
	  $previousActionResult = AdaptTheConfigFiles()
   EndIf
   EnableAllControlls()
EndFunc
; RunWait($cmdLine[1] & 'Environment\OracleScripts\InstallerAllTablesManual.cmd autorun local itest')

Func UndoAllPendingChanges()
   SetSystemStatus("Waiting", "Waiting for your confirmation.")
   Local $decision = MsgBox(4, "UndoAllPendingChanges", "This will undo all your pending changes in the brancht " & $CurrentBasePath)
   SetSystemStatus("Running", "Undoing all pending changes.")
   If $decision = 6 Then
	  Local $cmd = $ExternalToolPath_Tfs & " undo /recursive /noprompt " & $CurrentBasePath
	  RunWait($cmd)
	  If @error Then
		 MsgBox(16, "Undo all pending changes exited with error.", "The error code is: " & @error)
		 SetSystemStatus("Error", "There was a problem undo all pending changes.")
		 Return -1
	  EndIf
   Else
	  SetSystemStatus("Ready", "User aborted remove pending changes.")
	  Return -1
   EndIf
   Return 1
EndFunc

Func RemoveDev()
   SetSystemStatus("Running", "Removing folders in selected branch.")
   Local $subfolders = _FileListToArray($CurrentBasePath)
   For $i = 1 To UBound($subfolders) - 1
	  UpdateStatusBarMsg("Removing " & $CurrentBasePath & $subfolders[$i] & ". Please wait.")
	  DirRemove($CurrentBasePath & $subfolders[$i], 1)
   Next
   SetSystemStatus("Ready", "Folders successfully removed.")
   Return 1
EndFunc

Func GetLatest()
   SetSystemStatus("Running", "Getting the latest source version from TFS repository.")
   Local $cmd = $ExternalToolPath_Tfs & " get /recursive /force /overwrite /version:T"
   If RunWait($cmd, $CurrentBasePath) = 0 Then
	  SetSystemStatus("Error", "There was a problem getting the latest code from tfs.")
	  Return -1
   EndIf
   SetSystemStatus("Ready", "Latest source is now on your system.")
   Return 1
EndFunc

Func GetTheDependecies()
   SetSystemStatus("Running", "Getting the dependencies for c4000. Please wait...")
   Local $c4000Dependencies = RunWait($GetDependenciesPath & ' /DependenciesFile:Dependencies.targets /Log:GetDependencies.log', $CurrentBasePath & "Units\")
   If $c4000Dependencies = 0 Then
	  SetSystemStatus("Error", "There was a proble with getting the dependencies for c4000.")
	  Return -1
   EndIf
   SetSystemStatus("Running", "Getting the dependencies for IC simulator. Please wait...")
   Local $simulatorDependencies = RunWait($GetDependenciesPath & ' /DependenciesFile:ICSimulator.targets /Log:GetDependenciesSimulator.log', $CurrentBasePath & "Units\")
   If $simulatorDependencies = 0 Then
	  SetSystemStatus("Ready", "There was a problem with getting the dependecies for IC simulator.")
	  Return -1
   EndIf
   SetSystemStatus("Ready", "Dependecies for c4000 and simulator successfully fetched.")
   Return 1
EndFunc

Func BuildIMSolution()
   SetSystemStatus("Running", "Building the c4000 solution. Please wait...")
   ;~ Kill all running c4000 processes but ask first if one is running
   Local $c4000IsRunning = False
   For $i = 0 To UBound($IMProcesses) - 1
	  If ProcessExists($IMProcesses[$i]) Then
		 $c4000IsRunning = True
		 ExitLoop
	  EndIf
   Next
   If ProcessExists($HL7ProcessName) Then
	  $c4000IsRunning = True
   EndIf
   If ProcessExists($ICSimulatorProcessName) Then
	  $c4000IsRunning = True
   EndIf
   ;~ 3 => Yes, No, Cancel | Yes = 6, No = 7 and Cancel = 2
   If $c4000IsRunning Then
	  SetSystemStatus("Waiting", "Waiting for your confirmation.")
	  $killProcessesFirst = MsgBox(3, "C4000 already running", "It seems that at least one c4000 process is running. Do you want to stop all c4000 processes?")
	  If $killProcessesFirst = 6 Then
		 KillAllProcesses()
		 BuildIMSolutionDebugNoTests()
	  ElseIf $killProcessesFirst = 7 Then
		 BuildIMSolutionDebugNoTests()
	  EndIf
   Else
	  BuildIMSolutionDebugNoTests()
   EndIf
   SetSystemStatus("Ready", "C4000 solution successfully buildet.")
   Return 1
EndFunc

Func BuildIMSolutionDebugNoTests()
   SetSystemStatus("Running", "Building the c4000 solution. Please wait...")
   Local $cmd = $msBuildPath & " " & $CurrentBasePath & "Units\Roche.c4000.sln /t:build /p:Configuration=DebugNoTests;RunCodeAnalysis=false;WarningLevel=0 /nr:false"
   Local $res = RunWait($cmd)
   If @error Then
	  MsgBox(16, "Build IM solution in DebugNoTests exited with error.", "The error code is: " & @error)
	  Return -1
   EndIf
   Return 1
EndFunc

Func RemoveComitServices()
   SetSystemStatus("Running", "Redeploing the Comit services. Please wait...")
   Local $cmd = $CurrentBasePath & 'Environment\IISScripts\InstallComitServices.bat ' & $CurrentBasePath & ' developer Debug local'
   Local $cmdPit = Run($cmd)
   While ProcessExists($cmdPit)
	  SleepWithStatusUpdate(4000, True)
   WEnd
;~
;~    Run("DeployComitServices.exe " & $CurrentBasePath)
;~    While ProcessExists("DeployComitServices.exe")
;~ 	  SleepWithStatusUpdate(4000, True)
;~    WEnd
   SetSystemStatus("Ready", "Redeploing the Comit services successfully finished.")
   Return 1
EndFunc

Func AdaptTheConfigFiles()
   SetSystemStatus("Running", "Adapting the instrumentSettings.xml and the app.config of process manager. Please wait...")
   Local $file = $CurrentBasePath & "Units\bin\Debug\Roche.C4000.ProcessManagement.ProcessManager.exe.config"
   _ReplaceStringInFile($file, ", CreateHidden", "")

   $file = $CurrentBasePath & "Units\ProcessManagement\Source\Roche.C4000.ProcessManagement.ProcessManager\app.config"
   _ReplaceStringInFile($file, ", CreateHidden", "")

   $file = $CurrentBasePath & "Units\InstrumentAccess\Source\Roche.C4000.InstrumentAccess.ServiceHost\InstrumentSettings.xml"
   ; Remove the comments from the simulator part
   _ReplaceStringInFile($file, '<!--<StringParameter name="IPAddress" defaultValue="localhost"/>', '<StringParameter name="IPAddress" defaultValue="localhost"/>', 1, 0)
   _ReplaceStringInFile($file, '<StringParameter name="FtpInstallFolder" defaultValue="" />-->', '<StringParameter name="FtpInstallFolder" defaultValue="" />', 1, 0)
   ; Add the comments from the real instrument part
   _ReplaceStringInFile($file, '<StringParameter name="IPAddress" defaultValue="162.132.242.249"/>', '<!--<StringParameter name="IPAddress" defaultValue="162.132.242.249"/>', 1, 0)
   _ReplaceStringInFile($file, '<StringParameter name="FtpInstallFolder" defaultValue="" />', '<StringParameter name="FtpInstallFolder" defaultValue="" />-->', 1, 0)
   ; clean up - just in case
   _ReplaceStringInFile($file, '<!--<!--', '<!--')

   $file = $CurrentBasePath & "Units\bin\Debug\InstrumentSettings.xml"
   ; Remove the comments from the simulator part
   _ReplaceStringInFile($file, '<!--<StringParameter name="IPAddress" defaultValue="localhost"/>', '<StringParameter name="IPAddress" defaultValue="localhost"/>', 1, 0)
   _ReplaceStringInFile($file, '<StringParameter name="FtpInstallFolder" defaultValue="" />-->', '<StringParameter name="FtpInstallFolder" defaultValue="" />', 1, 0)
   ; Add the comments from the real instrument part
   _ReplaceStringInFile($file, '<StringParameter name="IPAddress" defaultValue="162.132.242.249"/>', '<!--<StringParameter name="IPAddress" defaultValue="162.132.242.249"/>', 1, 0)
   _ReplaceStringInFile($file, '<StringParameter name="FtpInstallFolder" defaultValue="" />', '<StringParameter name="FtpInstallFolder" defaultValue="" />-->', 1, 0)
   ; clean up - just in case
   _ReplaceStringInFile($file, '<!--<!--', '<!--')
   SetSystemStatus("Ready", "Adapting the instrumentSettings.xml and the app.config of process manager successfully finished.")
   Return 1
EndFunc

Func RunTest_SourceControl2()
   ;#requireAdmin
   $pid = RunWait("Test.bat")
   MsgBox(64, "Teste", $pid)
   $pid = Run("Test.bat")
   While ProcessExists($pid)
	  Sleep(2000)
   WEnd
   MsgBox(64, "Teste", $pid)
EndFunc