#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=ildasm_136.ico
#AutoIt3Wrapper_Res_File_Add=Background.jpg, rt_rcdata, RES_BACKGROUND_JPG
#AutoIt3Wrapper_Outfile_x64=UI.exe
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

#include <GUIConstantsEx.au3>
#include <GuiStatusBar.au3>
#include <ButtonConstants.au3>
#include <WindowsConstants.au3>
#include <WinAPI.au3>
#include <File.au3>
#include "Helpers\CommonHelpers.au3"
#include "Config\Text.au3"
#include "Helpers\UIHelpers.au3"
#include "Actions\TestActions.au3"
#include "Actions\SourceControlActions.au3"
#include "Actions\PreparationActions.au3"
#include "Actions\RoundtripsActions.au3"
#include "Actions\BackupActions.au3"



Global $hStatusBar, $SystemStatus, $OldSystemStatus



;~ Load the settings if available
LoadSettings()
Initialize()
WriteLog("=================================================================")
WriteLog("UI started")
WriteLog("=================================================================")
Main()
WriteLog("=================================================================")
WriteLog("UI closed")
WriteLog("=================================================================")

Func Main()
   Global $mainGui = GUICreate("UI", $MAINGUI_WIDTH, $MAINGUI_HEIGHT)
   ;$BackgroundPic = GUICtrlCreatePic("Images\Background_Dark.jpg", 0, 0, $MAINGUI_WIDTH, $MAINGUI_HEIGHT)
   ;GUICtrlSetState($BackgroundPic, $GUI_DISABLE); set as background (move to last layer...)
   #include "Menu.au3"
   #include "ContextMenu.au3"  
   
   #region Tab
   $hTab = GUICtrlCreateTab(1, 1, $MAINGUI_WIDTH, $MAINGUI_HEIGHT - 44 - 30)
   #include "TestTab.au3"
   #include "SourceControlTab.au3"
   #include "PreparationTab.au3"
   #include "RoundtripsTab.au3"
   #include "BackupTab.au3"
   GUICtrlCreateTabItem("") 
   #endregion Tab
   
   Global $BTN_KillAllProcesses = CreateButton("Kill all processes.", 10, $MAINGUI_HEIGHT - 44 - 25, 100)
   
   ;~ Status bar
   Global $hStatusBar = _GUICtrlStatusBar_Create($MainGUI)
   _GUICtrlStatusBar_SetParts($hStatusBar, $STATUSBAR_PARTS)
   SetSystemStatus("Ready")
   
   #region GUI handle
   GUISetState(@SW_SHOW, $mainGui)
   While 1
	  Local $msg = GUIGetMsg()
	  If $msg = $settingsItem Then
		 ShowSettingsPopup()
	  ElseIf $msg = $aboutItemAbout Then
		 ShowAboutPopup()
	  ElseIf $msg = $aboutItemHelp Then
		 ShowHelpPopup()
	  ElseIf $includeTest And $msg = $BTN_TestAction_Click Then
		 TestAction_Click()
	  ElseIf $includeTest And $msg = $CBX_Test_All Then
		 SetCheckBoxState($TestCheckBoxes, GUICtrlRead($CBX_Test_All))
	  ElseIf $includeSourcControl And $msg = $BTN_SourceControlAction_Click Then
		 SourceControlAction_Click()
	  ElseIf $includeSourcControl And $msg = $CBX_SourceControl_All Then
		 SetCheckBoxState($SourceControlCheckBoxes, GUICtrlRead($CBX_SourceControl_All))
		 
	  ElseIf $includePreparation And $msg = $BTN_PreparationAction_Click Then
		 PreparationAction_Click()
	  ElseIf $includePreparation And $msg = $CBX_Preparation_All Then
		 SetCheckBoxState($PreparationCheckBoxes, GUICtrlRead($CBX_Preparation_All))
		 
	  ElseIf $includeRoundtrips And $msg = $BTN_RoundtripsAction_Click Then
		 RoundtripsAction_Click()
	  ElseIf $includeRoundtrips And $msg = $CBX_Roundtrips_All Then
		 SetCheckBoxState($RoundtripsCheckBoxes, GUICtrlRead($CBX_Roundtrips_All))
		   
	  ElseIf $includeBackup And $msg = $BTN_BackupAction_Click Then
		 BackupAction_Click()
	  ElseIf $includeBackup And $msg = $CBX_Backup_All Then
		 SetCheckBoxState($BackupCheckBoxes, GUICtrlRead($CBX_Backup_All))
	  
	  ElseIf $msg = $BTN_KillAllProcesses Then
		 KillAllProcesses()
		 
	  ElseIf $msg = $GUI_EVENT_CLOSE Then
		 ExitLoop
	  EndIf
;~ 	  Switch $msg
;~ 		 Case $settingsItem
;~ 			ShowSettingsPopup()
;~ 		 Case $aboutItemAbout
;~ 			ShowAboutPopup()
;~ 		 Case $aboutItemHelp
;~ 			ShowHelpPopup()
;~ 		 Case $BTN_TestAction_Click
;~ 			TestAction_Click()
;~ 		 Case $GUI_EVENT_CLOSE
;~ 			ExitLoop
;~ 	  EndSwitch
   WEnd
   GUIDelete()
   #endregion GUI handle
EndFunc
 
#region Popups
Func ShowSettingsPopup()
   Local $popupWidth = 500
   Local $popupHeight = 300
   Local $ColumsLeft[3] = [10, 90, 370]
   Local $marginTop = 10   
   Local $lineHeight = 25
   Local $labelWidth = 80
   Local $settingsPopup = GUICreate("Settings", $popupWidth, $popupHeight)
   ;~ Select the current environment
   #region environment settings
   GUICtrlCreateLabel("Environment: ", $ColumsLeft[0], $marginTop + (0 * $lineHeight), $labelWidth, 20)
   Local $newEnvironment = $CurrentEnvironment
   Local $EnvironmentInput = GUICtrlCreateCombo($Environments[0], $ColumsLeft[1], $marginTop + (0 * $lineHeight), 280, 20)
   Local $environmentValues
   For $i = 1 To UBound($Environments) - 1
	  If $i > 1 Then
		 $environmentValues &= "|"
	  EndIf
	  $environmentValues &= $Environments[$i]
   Next
   GUICtrlSetData($EnvironmentInput, $environmentValues, $CurrentEnvironment)
   #endregion environment settings
   
   ;~ Select the base path
   #region base path settings
   Local $newBasePath = $CurrentBasePath
   GUICtrlCreateLabel("Base path: ", $ColumsLeft[0], $marginTop + (1 * $lineHeight), $labelWidth, 20)
   Local $BasePathInput = GUICtrlCreateLabel($CurrentBasePath, $ColumsLeft[1], $marginTop + (1 * $lineHeight), 280, 20)
   Local $BTN_SelectBasepath = CreateButton("Choose...", $ColumsLeft[2], $marginTop + (1 * $lineHeight), 60)
   #endregion base path settings
   
   
   ;GUICtrlCreateLabel("IM Processes: ", $ColumsLeft[0], $marginTop + (2 * $lineHeight), $labelWidth, 20)
   ;Local $IMProcesses = GUICtrlCreateCombo($IMProcesses_ProcessManager, $ColumsLeft[1], $marginTop + (2 * $lineHeight), 280, 20)
   ;GUICtrlSetData(-1, $IMProcesses_Scheduler & "|" & $IMProcesses_Calculator & "|" & $IMProcesses_UIServer & "|" & $IMProcesses_ResourceManager & "|" & $IMProcesses_InstrumentAccess, $IMProcesses_ProcessManager)
   
   Local $BTN_SaveSettings = CreateButton("Save", $ColumsLeft[0], $popupHeight - $BTN_HEIGHT, 150); GUICtrlCreateButton("&Save", 10, $popupHeight - $BTN_HEIGHT, 150, $BTN_Height, $BS_FLAT)
   Local $BTN_DiscardSettings = CreateButton("Cancel", $ColumsLeft[0] + 150 + 10, $popupHeight - $BTN_HEIGHT, 150)
   Local $BTN_LoadDefaultSettings = CreateButton("Default", $ColumsLeft[0] + 150 + 10 + 150 + 10, $popupHeight - $BTN_HEIGHT, 150)
   
   GUISetState(@SW_SHOW, $settingsPopup)
   While 1
	  Local $msg = GUIGetMsg()
	  Switch $msg
		 Case $EnvironmentInput
			$newEnvironment = GUICtrlRead($EnvironmentInput)
		 Case $BTN_SelectBasepath
			$newBasePath = FileSelectFolder("Select the base foler of your branch.", "C:\") & "\"
			GUICtrlSetData($BasePathInput, $newBasePath)
		 Case $BTN_SaveSettings
			$CurrentEnvironment = $newEnvironment
			$CurrentBasePath = $newBasePath
			SaveSettings()
			MsgBox(64, "Please restart!", "The changes you made will take effect after you restart the app.")
			ExitLoop
		 Case $BTN_DiscardSettings
			ExitLoop
		 Case $BTN_LoadDefaultSettings
			LoadDefaultSettings()
		 Case $GUI_EVENT_CLOSE
			ExitLoop
	  EndSwitch
   WEnd
   GUIDelete()
EndFunc
 
Func ShowAboutPopup()
   Local $popupWidth = 220
   Local $popupHeight = 300
   Local $aboutPopup = GUICreate("About", $popupWidth, $popupHeight)
   GUICtrlCreateLabel("Copyright: 2013 @ Roche", 10, 20, 200, 20)
   GUICtrlCreateLabel("Author: Rico", 10, 60, 200, 20)
   GUICtrlCreateLabel("Version: 0.2", 10, 100, 200, 20)
   GUICtrlCreateLabel("Last change: 2013-Sep-25", 10, 140, 200, 20)
   GUISetState(@SW_SHOW, $aboutPopup)
   While 1
	  Local $msg = GUIGetMsg()
	  Switch $msg
	  Case $GUI_EVENT_CLOSE
			ExitLoop
	  EndSwitch
   WEnd
   GUIDelete()
EndFunc

Func ShowHelpPopup()
   MsgBox(64, "Help", $TEXT_NOTIMPLEMETEDYET)
EndFunc
#endregion Popups