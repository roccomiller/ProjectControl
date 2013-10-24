
;~ Declare all used checkboxes here to prevent warnings in the usage
#region Checkbox declaration
Global $CBX_SourceControl_ShowTfsHistory
Global $CBX_SourceControl_UndoAllPendingChanges
Global $CBX_SourceControl_RemoveDev
Global $CBX_SourceControl_GetLatest
Global $CBX_SourceControl_GetTheDependecies
Global $CBX_SourceControl_CleanBuildDir
Global $CBX_SourceControl_BuildIMSolutionDebugNoTests
Global $CBX_SourceControl_BuildIMSolutionDebugNoInstaller
Global $CBX_SourceControl_BuildIMSolutionDebug
Global $CBX_SourceControl_RemoveComitServices
Global $CBX_SourceControl_AdaptTheConfigFiles
Global $CBX_SourceControl_All

Global $CBX_SourceControl_RunFxCopAll
Global $CBX_SourceControl_RunFxCopSelective
Global $CBX_SourceControl_CleanTestDataBase
Global $CBX_SourceControl_CheckAndTestIt_All
#endregion Checkbox declaration

#region action tab helpers
Func SetBuildIMSolutionDebugNoTestsCheckBox()
	If GUICtrlRead($CBX_SourceControl_BuildIMSolutionDebugNoTests) = $GUI_CHECKED Then
		GUICtrlSetState($CBX_SourceControl_BuildIMSolutionDebugNoInstaller, $GUI_UNCHECKED)
		GUICtrlSetState($CBX_SourceControl_BuildIMSolutionDebug, $GUI_UNCHECKED)
	EndIf
EndFunc

Func SetBuildIMSolutionDebugNoInstallerCheckBox()
	If GUICtrlRead($CBX_SourceControl_BuildIMSolutionDebugNoInstaller) = $GUI_CHECKED Then
		GUICtrlSetState($CBX_SourceControl_BuildIMSolutionDebugNoTests, $GUI_UNCHECKED)
		GUICtrlSetState($CBX_SourceControl_BuildIMSolutionDebug, $GUI_UNCHECKED)
	EndIf
EndFunc

Func SetBuildIMSolutionDebugCheckBox()
	If GUICtrlRead($CBX_SourceControl_BuildIMSolutionDebug) = $GUI_CHECKED Then
		GUICtrlSetState($CBX_SourceControl_BuildIMSolutionDebugNoTests, $GUI_UNCHECKED)
		GUICtrlSetState($CBX_SourceControl_BuildIMSolutionDebugNoInstaller, $GUI_UNCHECKED)
	EndIf
EndFunc

Func SetSourceControlCheckBoxState()
	SetCheckBoxState($SourceControlCheckBoxes, GUICtrlRead($CBX_SourceControl_All))
EndFunc

Func SetSourceControlCheckAndTestItCheckBoxState()
	SetCheckBoxState($SourceControlCheckAndTestItCheckBoxes, GUICtrlRead($CBX_SourceControl_CheckAndTestIt_All))
EndFunc
#endregion action tab helpers

#region Group source control
Func SourceControlAction_Click()
	DisableAllControlls()
	Local $previousActionResult = 1
	If GUICtrlRead($CBX_SourceControl_ShowTfsHistory) = $GUI_CHECKED And $previousActionResult = 1 Then
		$previousActionResult = ShowHistory()
	EndIf
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
	If GUICtrlRead($CBX_SourceControl_CleanBuildDir) = $GUI_CHECKED And $previousActionResult = 1 Then
		$previousActionResult = CleanBuildDir()
	EndIf
	If GUICtrlRead($CBX_SourceControl_BuildIMSolutionDebugNoTests) = $GUI_CHECKED And $previousActionResult = 1 Then
		$previousActionResult = BuildIMSolution("DebugNoTests")
	ElseIf GUICtrlRead($CBX_SourceControl_BuildIMSolutionDebugNoInstaller) = $GUI_CHECKED And $previousActionResult = 1 Then
		$previousActionResult = BuildIMSolution("DebugNoInstaller")
	ElseIf GUICtrlRead($CBX_SourceControl_BuildIMSolutionDebug) = $GUI_CHECKED And $previousActionResult = 1 Then
		$previousActionResult = BuildIMSolution("Debug")
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

Func ShowHistory()
	SetSystemStatus("Running", "Getting the history for the branch " & $CurrentBasePath & ".")
	Local $cmd = $ExternalToolPath_Tfs & " history /recursive ..\Dev"
	;Local $cmd = $ExternalToolPath_Tfs & " status" ;  Show pending changes -> does not work beacuse it cloeses the window
	SetSystemStatus("Waiting", "Showing the TFS history window. Please close it to continue...")
	If RunWait($cmd, $CurrentBasePath) = 0 And Not (@error = 0) Then
		SetSystemStatus("Error", "There was a problem getting the history for " & $CurrentBasePath & ".")
		Return -1
	EndIf
	SetSystemStatus("Ready", "I recently showed you the history of " & $CurrentBasePath & ".")
	Return 1
EndFunc

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
   Local $subfolders = _FileListToArray($CurrentBasePath, "*", 2)
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
	If RunWait($cmd, $CurrentBasePath) = 0 And Not (@error = 0) Then
		SetSystemStatus("Error", "There was a problem getting the latest code from tfs.")
		Return -1
	EndIf
	SetSystemStatus("Ready", "Latest source is now on your system.")
	Return 1
EndFunc

Func GetTheDependecies()
   SetSystemStatus("Running", "Getting the dependencies for c4000. Please wait...")
   Local $c4000Dependencies = RunWait($GetDependenciesPath & ' /DependenciesFile:Dependencies.targets /Log:GetDependencies.log', $CurrentBasePath & "Units\")
   ;If $c4000Dependencies = 0 Then
	;  SetSystemStatus("Error", "There was a proble with getting the dependencies for c4000.")
	 ; Return -1
   ;EndIf
   SetSystemStatus("Running", "Getting the dependencies for IC simulator. Please wait...")
   Local $simulatorDependencies = RunWait($GetDependenciesPath & ' /DependenciesFile:ICSimulator.targets /Log:GetDependenciesSimulator.log', $CurrentBasePath & "Units\")
   ;If $simulatorDependencies = 0 Then
	;  SetSystemStatus("Ready", "There was a problem with getting the dependecies for IC simulator.")
	 ; Return -1
   ;EndIf
   SetSystemStatus("Ready", "Dependecies for c4000 and simulator successfully fetched.")
   Return 1
EndFunc

Func CleanBuildDir()
	SetSystemStatus("Running", "Removing bin\Debug\ content.")
	Local $success = 1
	Local $subPath = "Units\bin\Debug\"
	Local $subfolders = _FileListToArray($CurrentBasePath & $subPath, "*", 2)
	For $i = 1 To UBound($subfolders) - 1
		UpdateStatusBarMsg("Removing " & $CurrentBasePath & $subPath & $subfolders[$i] & ". Please wait.")
		$success = DirRemove($CurrentBasePath & $subPath & $subfolders[$i], 1)
		If $success = 0 Then
			MsgBox(0, "Could not delete folder", $CurrentBasePath & $subPath & $subfolders[$i])
		EndIf
	Next
	Local $files = _FileListToArray($CurrentBasePath & $subPath, "*", 1)
	For $i = 1 To UBound($files) - 1
		UpdateStatusBarMsg("Removing " & $CurrentBasePath & $subPath & $files[$i] & ". Please wait.")
		$success = FileDelete($CurrentBasePath & $subPath & $files[$i])
		If $success = 0 Then
			MsgBox(0, "Could not delete file", $CurrentBasePath & $subPath & $files[$i])
		EndIf
	Next
	SetSystemStatus("Ready", "Folders and files in " & $CurrentBasePath & $subPath & " successfully removed.")
	Return $success
EndFunc

Func BuildIMSolution($buildConfiguration = "Debug")
	SetSystemStatus("Running", "Building the c4000 solution. Please wait...")
	Local $checkRunning = CheckRunningProcesses(True, True, True)
	If $checkRunning[0] Or $checkRunning[1] Or $checkRunning[2] Then
		;~ Kill all running c4000 processes but ask first if one is running
		SetSystemStatus("Waiting", "Waiting for your confirmation.")
		Local $msg = "It seems that "
		If $checkRunning[0] Then
			$msg &= "a c4000 process "
		EndIf
		If $checkRunning[1] Then
			$msg &= "the IC simulator "
		EndIf
		If $checkRunning[2] Then
			$msg &= "the HL7 simulator "
		EndIf
		$msg &= "is still running. Do you want to stop all running processes?"
		Local $killProcessesFirst = MsgBox(3, "C4000 already running", $msg)
		;~ 3 => Yes, No, Cancel | Yes = 6, No = 7 and Cancel = 2
		If $killProcessesFirst = 6 Then
			KillAllProcesses()
			StartBildIMSolution($buildConfiguration)
		ElseIf $killProcessesFirst = 7 Then
			StartBildIMSolution($buildConfiguration)
		ElseIf $killProcessesFirst = 2 Then
			SetSystemStatus("Warning", "Building the solution was canceled by the user.")
			Return -1
		EndIf
	Else
		StartBildIMSolution($buildConfiguration)
	EndIf
	SetSystemStatus("Ready", "C4000 solution successfully buildet.")
	Return 1
EndFunc

Func StartBildIMSolution($buildConfiguration)
	SetSystemStatus("Running", "Building the c4000 solution with configuration '" & $buildConfiguration & "'. Please wait...")
	Local $cmd = $msBuildPath & " " & $CurrentBasePath & "Units\Roche.c4000.sln /t:build /p:Configuration=" & $buildConfiguration & ";RunCodeAnalysis=false;WarningLevel=0 /nr:false"
	Local $res = RunWait($cmd)
	If @error Then
		MsgBox(16, "Build IM solution with configuration '" & $buildConfiguration & "' exited with error.", "The error code is: " & @error)
		Return -1
	EndIf
	Return 1
EndFunc

Func RemoveComitServices()
	SetSystemStatus("Running", "Redeploing the Comit services. Please wait...")
	FileInstall("Actions\InstallComitServices.exe", "InstallComitServices.exe", 1)
	Run("InstallComitServices.exe " & $CurrentBasePath)
	While ProcessExists("InstallComitServices.exe")
		Sleep(2000)
	WEnd
	Local $tries = 0
	While FileExists("InstallComitServices.exe") And $tries < 10
		FileDelete("InstallComitServices.exe")
		$tries += 1
	WEnd
	SetSystemStatus("Ready", "Redeploing the Comit services successfully finished.")
	Return 1
EndFunc

Func AdaptTheConfigFiles()
   SetSystemStatus("Running", "Adapting the instrumentSettings.xml and the app.config of process manager. Please wait...")
   Local $file = $CurrentBasePath & "Units\bin\Debug\Roche.C4000.ProcessManagement.ProcessManager.exe.config"
   _ReplaceStringInFile($file, ", CreateHidden", "")
   _ReplaceStringInFile($file, "-k Roche.C4000.UI.Client.SL.Main.html", "Roche.C4000.UI.Client.SL.Main.html")

   $file = $CurrentBasePath & "Units\ProcessManagement\Source\Roche.C4000.ProcessManagement.ProcessManager\app.config"
   _ReplaceStringInFile($file, ", CreateHidden", "")
   _ReplaceStringInFile($file, "-k Roche.C4000.UI.Client.SL.Main.html", "Roche.C4000.UI.Client.SL.Main.html")

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
#endregion Group source control

#region Group source control check and test it
Func SourceControlAction_CheckAndTestIt_Click()
	DisableAllControlls()
	Local $previousActionResult = 1
	If GUICtrlRead($CBX_SourceControl_RunFxCopAll) = $GUI_CHECKED And $previousActionResult = 1 Then
		$previousActionResult = RunFxCopAll()
	EndIf
	If GUICtrlRead($CBX_SourceControl_RunFxCopSelective) = $GUI_CHECKED And $previousActionResult = 1 Then
		$previousActionResult = RunFxCopSelective()
	EndIf
	If GUICtrlRead($CBX_SourceControl_CleanTestDataBase) = $GUI_CHECKED And $previousActionResult = 1 Then
		$previousActionResult = CleanTestDataBase()
	EndIf
	EnableAllControlls()
EndFunc

Func RunFxCopAll()
	If FileExists("Violations.xml") Then
		FileDelete("Violations.xml")
	EndIf
	Local $cmd = $FxCopToolPath
	$cmd &= ' /out:"Violations.xml"'
	$cmd &= ' /console'
	$cmd &= ' /summary'
	$cmd &= ' /file:"' & $CurrentBasePath & 'Units\bin\Debug\Roche.C4000.*.dll"'
	$cmd &= ' /dictionary:"' & $CurrentBasePath & 'Units\CodeAnalysisDictionary.xml"'
	$cmd &= ' /ruleset:="' & $CurrentBasePath & 'Units\RocheCodingStandardsNoNaming.Rules.ruleset"'
	RunWait($cmd)
	Return 1
EndFunc

Func RunFxCopSelective()

EndFunc

Func CleanTestDataBase()
	SetSystemStatus("Running", "Cleaning test database (itest postfix).")
	FileInstall("Actions\InstallerAllTablesManual.exe", "InstallerAllTablesManual.exe", 1)
	Run("InstallerAllTablesManual.exe " & $CurrentBasePath & " " & $CurrentDatabaseLocation & " itest")
	While ProcessExists("InstallerAllTablesManual.exe")
		Sleep(2000)
	WEnd
	Local $tries = 0
	While FileExists("InstallerAllTablesManual.exe") And $tries < 10
		FileDelete("InstallerAllTablesManual.exe")
		$tries += 1
	WEnd
	SetSystemStatus("Ready", "Test database (itest postfix) cleaned.")
	Return 1
EndFunc

#endregion Group source control check and test it