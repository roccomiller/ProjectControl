
;~ Declare all used checkboxes here to prevent warnings in the usage
#region Checkbox declaration
Global $CBX_Preparation_BuildIMSolution
Global $CBX_Preparation_RemoveOldMasterData
Global $CBX_Preparation_RemoveOldLogfiles
Global $CBX_Preparation_CleanDatabase
Global $CBX_Preparation_CopyDatabaseExportTool
Global $CBX_Preparation_ChangeToRSAMode
Global $CBX_Preparation_ChangeToTsnDropMode
Global $CBX_Preparation_StartICSimulator
Global $CBX_Preparation_StartHL7Simulator
Global $CBX_Preparation_StartIMSoftware
Global $CBX_Preparation_CopyAllMasterDatafiles

Global $CBX_Preparation_All
_ArrayAdd($CheckAllCheckBoxes, $CBX_Preparation_All)
#endregion Checkbox declaration

#region action tab helpers
Func SetChangeToRSACheckBox()
	If GUICtrlRead($CBX_Preparation_ChangeToRSAMode) = $GUI_CHECKED Then
		GUICtrlSetState($CBX_Preparation_ChangeToTsnDropMode, $GUI_UNCHECKED)
	EndIf
EndFunc

Func SetChangeToTsnDropCheckBox()
	If GUICtrlRead($CBX_Preparation_ChangeToTsnDropMode) = $GUI_CHECKED Then
		GUICtrlSetState($CBX_Preparation_ChangeToRSAMode, $GUI_UNCHECKED)
	EndIf
EndFunc

Func SetPreparationCheckBoxState()
	SetCheckBoxState($PreparationCheckBoxes, GUICtrlRead($CBX_Preparation_All))
EndFunc
#endregion action tab helpers

Func PreparationAction_Click()
	DisableAllControlls()
	Local $previousActionResult = 1
	If GUICtrlRead($CBX_Preparation_BuildIMSolution) = $GUI_CHECKED And $previousActionResult = 1 Then
		$previousActionResult = BuildIMSolution("DebugNoTests")
	EndIf
	If GUICtrlRead($CBX_Preparation_RemoveOldMasterData) = $GUI_CHECKED And $previousActionResult = 1 Then
		$previousActionResult = RemoveOldMasterData()
	EndIf
	If GUICtrlRead($CBX_Preparation_RemoveOldLogfiles) = $GUI_CHECKED And $previousActionResult = 1 Then
		$previousActionResult = RemoveOldLogfiles()
	EndIf
	If GUICtrlRead($CBX_Preparation_CleanDatabase) = $GUI_CHECKED And $previousActionResult = 1 Then
		$previousActionResult = CleanDatabase()
	EndIf
	If GUICtrlRead($CBX_Preparation_CopyDatabaseExportTool) = $GUI_CHECKED And $previousActionResult = 1 Then
		$previousActionResult = CopyDatabaseExportTool()
	EndIf
	If GUICtrlRead($CBX_Preparation_ChangeToRSAMode) = $GUI_CHECKED And $previousActionResult = 1 Then
		$previousActionResult = ChangeToRSAMode()
	EndIf
	If GUICtrlRead($CBX_Preparation_ChangeToTsnDropMode) = $GUI_CHECKED And $previousActionResult = 1 Then
		$previousActionResult = ChangeToTsnDropMode()
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
	;~Remove old rsa packages
	If FileExists("D:\") Then
		FileDelete("D:\Roche\RSA\Temp\*.zip")
		FileDelete("D:\Roche\RSA\*.zip")
		FileDelete("D:\Roche\RSA\Repository\*.zip")
		FileDelete("D:\Roche\RSA\Repository\ELibrary\*.zip")
		FileDelete("D:\Roche\RSA\Repository\ELibrary\Temp\*.zip")
	Endif
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

	Run("InstallerAllTablesManual.exe " & $CurrentBasePath & " " & $CurrentDatabaseLocation & " " & $CurrentUserPostfix)
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

Func ChangeToRSAMode()
	Local $return = ChangeRSAMode(true)
	;~ create the folder if it does not exist and the user has a D-Drive
	;~ maybe read the rsa paht from ui server config...
	If Not FileExists("D:\") Then
		SetSystemStatus("Error", "You don't have a D-drive. Can not create RSA folder.")
		Return -1
	EndIf
	Local $RSAFolderStructure[1] = ["D:\"]
	_ArrayAdd($RSAFolderStructure, "D:\Roche\")
	_ArrayAdd($RSAFolderStructure, "D:\Roche\RSA\")
	_ArrayAdd($RSAFolderStructure, "D:\Roche\RSA\Repository\")
	_ArrayAdd($RSAFolderStructure, "D:\Roche\RSA\Repository\ELibrary\Temp\")
	_ArrayAdd($RSAFolderStructure, "D:\Roche\RSA\Repository\Installation\")
	_ArrayAdd($RSAFolderStructure, "D:\Roche\RSA\Temp")

	For $i = 0 To UBound($RSAFolderStructure) - 1
		If Not FileExists($RSAFolderStructure[$i]) Then
			If Not DirCreate($RSAFolderStructure[$i]) Then
				SetSystemStatus("Error", "Directory '" & $RSAFolderStructure[$i] & "' could not be created.")
				Return -1
			EndIf
		EndIf
	Next


;~ 	If Not FileExists("D:\Roche\RSA\Repository\ELibrary\Temp\") Then
;~ 		If Not DirCreate("D:\Roche\RSA\Repository\ELibrary\Temp\") Then
;~ 			SetSystemStatus("Error", "Directory 'D:\Roche\RSA\Repository\ELibrary\Temp\' could not be created.")
;~ 			Return -1
;~ 		EndIf
;~ 	EndIf
;~ 	If Not FileExists("D:\Roche\RSA\Repository\Installation\") Then
;~ 		If Not DirCreate() Then
;~ 			SetSystemStatus("Error", "Directory 'D:\Roche\RSA\Repository\Installation\' could not be created.")
;~ 			Return -1
;~ 		EndIf
;~ 	If Not FileExists("D:\Roche\RSA\Temp\") Then


	SetSystemStatus("Ready", "RSA folder structure on D drive created.")
	Return $return
EndFunc

Func ChangeToTsnDropMode()
	Return ChangeRSAMode(false)
EndFunc

Func ChangeRSAMode($enableRSA)
	SetSystemStatus("Running", "Changeing the Roche.C4000.UI.Server.Main.")
	Local $file = $CurrentBasePath & "Units\bin\Debug\Roche.C4000.UI.Server.Main.exe.config"
	Local $stringToReplace = 'rsaUsage="true"'
	Local $replacement = 'rsaUsage="false"'
	If $enableRSA Then
		$stringToReplace = 'rsaUsage="false"'
		$replacement = 'rsaUsage="true"'
	EndIf
	_ReplaceStringInFile($file, $stringToReplace, $replacement)
	;_XMLFileOpen($file)
	;_XMLSetAttrib("/configuration/roche.itcore.systemManagement/remoteServiceAgent", "rsaUsage", $enableRSA)

	$file = $CurrentBasePath & "Units\UI.Server\Source\Roche.C4000.UI.Server.Main\app.config"
	_ReplaceStringInFile($file, $stringToReplace, $replacement)
	;_XMLFileOpen($file)
	;_XMLSetAttrib("/configuration/roche.itcore.systemManagement/remoteServiceAgent", "rsaUsage", $enableRSA)

	SetSystemStatus("Ready", "Adapting the UI Server app.config to use rsa successfully finished.")
	Return 1
EndFunc

Func StartICSimulator()
	SetSystemStatus("Running", "Starting IC Simulator.")
	Local $startICSimulator = StartNewProcess($ICSimulatorProcess[0], $ICSimulatorProcess[1], $ICSimulatorProcess[0], $ICSimulatorProcess[2], True, False)
	If $startICSimulator = 0 Then
		Return 1
	Else
		Return $startICSimulator
	EndIf
EndFunc

Func StartHL7Simulator()
	SetSystemStatus("Running", "Starting HL7 Simulator.")
	Local $startHL7Simulator = StartNewProcess($HL7SimulatorProcess[0], $HL7SimulatorProcess[1], $HL7SimulatorProcess[0], $HL7SimulatorProcess[2], True, False)
	If $startHL7Simulator = 0 Then
		Return 1
	ElseIf $startHL7Simulator = 1 Then
		WinActivate($HL7SimulatorProcess[2])
		Send("{LEFT}")
		Send("{ENTER}")
		Return 1
	Else
		Return -1
	EndIf
EndFunc

Func StartIMSoftware()
	If IsAdmin() Then
		MsgBox(0, "StartIMSoftware()", "You are admin!")
		SetSystemStatus("Error", "You try to start the process manager as admin. This will not work!")
		Return -1
	EndIf
	SetSystemStatus("Running", "Starting IM Software.")
	$IMProcessManagerPID = Run($CurrentBasePath & "Units\bin\Debug\" & $IMProcesses[0], $CurrentBasePath & "Units\bin\Debug\")
	;~ Wait for the UIHostProcess to start...
	$UIHostPID = ProcessWait($IMProcesses[2])
	Sleep(20000) ; Wait for Silverlight gui
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