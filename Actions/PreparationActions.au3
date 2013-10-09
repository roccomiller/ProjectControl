
;~ Declare all used checkboxes here to prevent warnings in the usage
#region Checkbox declaration
Global $CBX_Preparation_RemoveOldMasterData
Global $CBX_Preparation_RemoveOldLogfiles
Global $CBX_Preparation_CleanDatabas
Global $CBX_Preparation_CopyDatabaseExportTool
Global $CBX_Preparation_StartICSimulator
Global $CBX_Preparation_StartHL7Simulator
Global $CBX_Preparation_StartIMSoftware
Global $CBX_Preparation_CopyAllMasterDatafiles

Global $CBX_Preparation_All
_ArrayAdd($CheckAllCheckBoxes, $CBX_Preparation_All)
#endregion Checkbox declaration

Func SetPreparationCheckBoxState()
	SetCheckBoxState($PreparationCheckBoxes, GUICtrlRead($CBX_Preparation_All))
EndFunc

Func PreparationAction_Click()
	DisableAllControlls()
	Local $previousActionResult = 1
	If GUICtrlRead($CBX_Preparation_RemoveOldMasterData) = $GUI_CHECKED And $previousActionResult = 1 Then
		$previousActionResult = RemoveOldMasterData()
	EndIf
	If GUICtrlRead($CBX_Preparation_RemoveOldLogfiles) = $GUI_CHECKED And $previousActionResult = 1 Then
		$previousActionResult = RemoveOldLogfiles()
	EndIf
	If GUICtrlRead($CBX_Preparation_CleanDatabas) = $GUI_CHECKED And $previousActionResult = 1 Then
		$previousActionResult = CleanDatabase()
	EndIf
	If GUICtrlRead($CBX_Preparation_CopyDatabaseExportTool) = $GUI_CHECKED And $previousActionResult = 1 Then
		$previousActionResult = CopyDatabaseExportTool()
	EndIf
	If GUICtrlRead($CBX_Preparation_StartICSimulator) = $GUI_CHECKED And $previousActionResult = 1 Then
		$previousActionResult = StartICSimulator()
	EndIf
	If GUICtrlRead($CBX_Preparation_StartHL7Simulator) = $GUI_CHECKED And $previousActionResult = 1 Then
		$previousActionResult = StartHL7Simulator()
	EndIf
	If GUICtrlRead($CBX_Preparation_StartIMSoftware) = $GUI_CHECKED And $previousActionResult = 1 Then
		$previousActionResult = StartIMSoftware()
	EndIf
	If GUICtrlRead($CBX_Preparation_CopyAllMasterDatafiles) = $GUI_CHECKED And $previousActionResult = 1 Then
		$previousActionResult = CopyAllMasterDatafiles()
	EndIf
	EnableAllControlls()
EndFunc

Func RemoveOldMasterData()
	SetSystemStatus("Running", "Removing old master data files.")
	;~ Remove the readonly attribute first, then delete old application files
	FileSetAttrib($TsnDropFolder & "*.*", "-R")
	FileDelete($TsnDropFolder & "*.*")
	FileSetAttrib($TsnDropFolder & "ManagedFileBase\cobas4000\*.*", "-R")
	FileDelete($TsnDropFolder & "ManagedFileBase\cobas4000\*.*")
	SetSystemStatus("Ready", "Old master data files deleted.")
	Return 1
EndFunc

Func RemoveOldLogfiles()
	SetSystemStatus("Running", "Removing old log files.")
	Local $logFileList = _FileListToArray($LogFolder, "*.*", 1)
	If IsArray($logFileList) Then
		For $i = 1 To $logFileList[0]
			If Not ($logFileList[$i] = "ComitTaskHandlingService.log") Then
				FileDelete($LogFolder & $logFileList[$i])
			EndIf
		Next
	EndIf
	SetSystemStatus("Ready", "Old log files deleted.")

	Return 1
EndFunc

Func CleanDatabase()
	SetSystemStatus("Running", "Cleaning database.")
	FileInstall("Actions\InstallerAllTablesManual.exe", "InstallerAllTablesManual.exe", 1)
	Run("InstallerAllTablesManual.exe " & $CurrentBasePath & " " & $CurrentUserPostfix)
	While ProcessExists("InstallerAllTablesManual.exe")
		Sleep(2000)
	WEnd
	Local $tries = 0
	While FileExists("InstallerAllTablesManual.exe") And $tries < 10
		FileDelete("InstallerAllTablesManual.exe")
		$tries += 1
	WEnd
	SetSystemStatus("Ready", "Database cleaned.")
	Return 1
EndFunc

Func CopyDatabaseExportTool()
	SetSystemStatus("Running", "Copying database commmander for export.")
	;~ Delete the old database export tool
	DirRemove($CurrentBasePath & "Units\bin\Debug\Database", 1)
	;~ Copy the Database export tool
	$s = $CurrentBasePath & "Setup\DatabaseMergeModule\Commander\Database_Export"
	$d = $CurrentBasePath & "Units\bin\Debug\Database\Commander\Database_Export"
	If Not DirCopy($s, $d) Then
		MsgBox(0, "Error", "Dir copy error. " & $s & " --- " & $d)
	EndIf
	SetSystemStatus("Ready", "Database commander tool for export copied.")
	Return 1
EndFunc

Func StartICSimulator()
	SetSystemStatus("Running", "Starting IC Simulator.")
	If FileExists($ICSimulatorPath & $ICSimulatorProcessName) Then
		Run($ICSimulatorPath & $ICSimulatorProcessName, $ICSimulatorPath)
		WinWait("IC Simulator")
		SetSystemStatus("Ready", "IC Simulator started.")
	Else
		SetSystemStatus("Error", "Could not find simulator executalble.")
		WriteLog("Could not find simulator: " & $ICSimulatorPath & $ICSimulatorProcessName)
		Return -1
	EndIf
	Return 1
EndFunc

Func StartHL7Simulator()
	SetSystemStatus("Running", "Starting HL7 Simulator.")
	Global $HL7SimulatorPID = Run($ExternalToolPath_HL7InstallPath & $HL7ProcessName , $ExternalToolPath_HL7InstallPath)
	;~ Accept the popup
	Sleep(2000)
	WinActivate("HL7 Host Interface Simulator [V 7.6]")
	Send("{LEFT}")
	Send("{ENTER}")
	SetSystemStatus("Ready", "HL7 Simulator started.")
	Return 1
EndFunc

Func StartIMSoftware()
	If IsAdmin() Then
		MsgBox(0, "IsAdmin()", "is admin")
	Else
		MsgBox(0, "IsAdmin()", "is NOT admin")
	EndIf
	SetSystemStatus("Running", "Starting IM Software.")
	;$IMProcessManagerPID = Run($CurrentBasePath & "Units\bin\Debug\" & $IMProcesses[0], $CurrentBasePath & "Units\bin\Debug\")
	;~ Wait for the UIHostProcess to start...
	;$UIHostPID = ProcessWait($IMProcesses[2])
	;Sleep(20000) ; Wait for Silverlight gui
	SetSystemStatus("Ready", "IM Software started.")
	Return 1
EndFunc

Func CopyAllMasterDatafiles()
	SetSystemStatus("Running", "Copying master data files to TsnDrop.")

	;~ CC master data files
	Local $CCMasterDataFiles = _FileListToArray($c302AppFolder, "*.xml", 1)
	If @error Then
		Local $CCMasterDataFiles[2] = [1, 0]
	EndIf
	For $i = 0 to $CCMasterDataFiles[0] - 1
		;If GUICtrlRead($CCMasterDataFilesCheckBoxes[$i]) = $GUI_CHECKED Then
			FileCopy($c302AppFolder & $CCMasterDataFiles[$i + 1], $TsnDropFolder, 9)
			UpdateStatusBarMsg("Copying " & $CCMasterDataFiles[$i + 1] & " to TsnDrop.")
			Sleep(500)
			WriteLog($c302AppFolder & $CCMasterDataFiles[$i + 1] & " copied to " & $TsnDropFolder)
		;EndIf
	Next

	;~ ISE master data files
	Local $ISEMasterDataFiles = _FileListToArray($iseAppFolder, "*.xml", 1)
	If @error Then
		Local $ISEMasterDataFiles[2] = [1, 0]
	EndIf
	For $i = 0 to $ISEMasterDataFiles[0] - 1
		;If GUICtrlRead($ISEMasterDataFilesCheckBoxes[$i]) = $GUI_CHECKED Then
			FileCopy($iseAppFolder & $ISEMasterDataFiles[$i + 1], $TsnDropFolder, 9)
			UpdateStatusBarMsg("Copying " & $ISEMasterDataFiles[$i + 1] & " to TsnDrop.")
			Sleep(500)
			WriteLog($iseAppFolder & $ISEMasterDataFiles[$i + 1] & " copied to " & $TsnDropFolder)
		;EndIf
	Next

	;~ IC master data files
	Local $ICMasterDataFiles = _FileListToArray($e201AppFolder, "*.xml", 1)
	If @error Then
		Local $ICMasterDataFiles[2] = [1, 0]
	EndIf
	For $i = 0 to $ICMasterDataFiles[0] - 1
		;If GUICtrlRead($ICMasterDataFilesCheckBoxes[$i]) = $GUI_CHECKED Then
			FileCopy($e201AppFolder & $ICMasterDataFiles[$i + 1], $TsnDropFolder, 9)
			UpdateStatusBarMsg("Copying " & $ICMasterDataFiles[$i + 1] & " to TsnDrop.")
			Sleep(500)
			WriteLog($e201AppFolder & $ICMasterDataFiles[$i + 1] & " copied to " & $TsnDropFolder)
		;EndIf
	Next
	SetSystemStatus("Ready", "Master data files copied.")
	Return 1
EndFunc