#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Res_Icon_Add=Images\Jahshaka.ico; Icon number -5
#AutoIt3Wrapper_Res_Icon_Add=Images\Help.ico	; Icon number -6
#AutoIt3Wrapper_Res_Icon_Add=Images\Ready.ico	; Icon number -7
#AutoIt3Wrapper_Res_Icon_Add=Images\Waiting.ico	; Icon number -8
#AutoIt3Wrapper_Res_Icon_Add=Images\Running.ico	; Icon number -9
#AutoIt3Wrapper_Res_Icon_Add=Images\Info.ico	; Icon number -10
#AutoIt3Wrapper_Res_Icon_Add=Images\Warning.ico	; Icon number -11
#AutoIt3Wrapper_Res_Icon_Add=Images\Error.ico	; Icon number -12
#AutoIt3Wrapper_Res_Icon_Add=Images\Success.ico	; Icon number -13
;#AutoIt3Wrapper_Res_File_Add=Documentation\Documentation.chm, rt_rcdatat, DOCUMENTATION
;#AutoIt3Wrapper_Res_File_Add=Background.jpg, rt_rcdata, RES_BACKGROUND_JPG
#AutoIt3Wrapper_Outfile_x64=UI.exe
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

#include <GUIConstantsEx.au3>
#include <GuiStatusBar.au3>
#include <ButtonConstants.au3>
#include <WindowsConstants.au3>
#include <WinAPI.au3>
#include <File.au3>
#include <date.au3>
#include <Array.au3>
#include <Libraries\_XMLDomWrapper.au3>
;#include <Libraries\resources.au3>
#include "Config\DefaultSettings.au3"
#include "Config\Text.au3"
#include "Helpers\CommonHelpers.au3"
#include "Helpers\UIHelpers.au3"
#include "Actions\TestActions.au3"
#include "Actions\SourceControlActions.au3"
#include "Actions\PreparationActions.au3"
#include "Actions\RoundtripsActions.au3"
#include "Actions\BackupActions.au3"

Initialize()
Main()
Deinitialize()

Func Main()
	Global $mainGui = GUICreate("C4000 Project Control", $MAINGUI_WIDTH, $MAINGUI_HEIGHT)
	Opt("GUIOnEventMode",1)
	;WinSetTrans($mainGui, '', 255)
	GUISetIcon($ResourceFile, -5)
	GUISetOnEvent($GUI_EVENT_CLOSE, "Terminate")
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
	GUICtrlSetOnEvent($BTN_KillAllProcesses, "KillAllProcesses")

	;~ Status bar
	Global $hStatusBar = _GUICtrlStatusBar_Create($MainGUI)
	_GUICtrlStatusBar_SetParts($hStatusBar, $STATUSBAR_PARTS)
	SetSystemStatus("Ready")

	#region GUI handle
	GUISetState(@SW_SHOW, $mainGui)
	While 1
		Sleep(50)
	WEnd
	GUIDelete()
	#endregion GUI handle
EndFunc

#region Popups
Func ShowSettingsPopup()
	Local $popupWidth = 500
	Local $popupHeight = 300
	Local $ColumsLeft[4] = [10, 110, 390, 460]
	Local $marginTop = 10
	Local $lineHeight = 25
	Local $labelWidth = 100
	Local $top = 0
	Local $settingsPopup = GUICreate($TXT_POPUP_SETTINGS_Settings, $popupWidth, $popupHeight)
	Opt("GUIOnEventMode",0)
	;~ Set your user postfix for database
	#region user postfix
	$top = $marginTop + (0 * $lineHeight)
	GUICtrlCreateLabel($TXT_POPUP_SETTINGS_UserPostfix, $ColumsLeft[0], $top, $labelWidth, 20)
	Local $newUserPostfix = $CurrentUserPostfix
	Local $UserPostfixInput = GUICtrlCreateInput($CurrentUserPostfix, $ColumsLeft[1], $top, 280, 20)
	Local $hHelpIcon_UserPostfix = GUICtrlCreateIcon($ResourceFile, -6, $ColumsLeft[3], $top, $ICON_HELP_HEIGHT, $ICON_HELP_HEIGHT)
	GUICtrlSetTip($hHelpIcon_UserPostfix, $TXT_POPUP_SETTINGS_UserPostfix_Help)
	#endregion user postfix

	;~ Select if you want to use the simulator or not
	#region Simulator usage
	$top = $marginTop + (1 * $lineHeight)
	GUICtrlCreateLabel($TXT_POPUP_SETTINGS_UseICSimulator, $ColumsLeft[0], $top, $labelWidth, 20)
	Local $newUseICSimulator = $CurrentUseICSimulator
	Local $UseICSimulatorInput = GUICtrlCreateCombo($UseICSimulator[0], $ColumsLeft[1], $top, 280, 20)
	GUICtrlSetData($UseICSimulatorInput, ConvertArrayToComboBoxString($UseICSimulator), $CurrentUseICSimulator)
	Local $hHelpIcon_UseICSimulator = GUICtrlCreateIcon($ResourceFile, -6, $ColumsLeft[3], $top, $ICON_HELP_HEIGHT, $ICON_HELP_HEIGHT)
	GUICtrlSetTip($hHelpIcon_UseICSimulator, $TXT_POPUP_SETTINGS_UseICSimulator_Help)
	#endregion Simulator usage

	;~ Select the current environment
	#region environment settings
	$top = $marginTop + (2 * $lineHeight)
	GUICtrlCreateLabel($TXT_POPUP_SETTINGS_Environment, $ColumsLeft[0], $top, $labelWidth, 20)
	Local $newEnvironment = $CurrentEnvironment
	Local $EnvironmentInput = GUICtrlCreateCombo($Environments[0], $ColumsLeft[1], $top, 280, 20)
	GUICtrlSetData($EnvironmentInput, ConvertArrayToComboBoxString($Environments), $CurrentEnvironment)
	Local $hHelpIcon_EnvironmentInput = GUICtrlCreateIcon($ResourceFile, -6, $ColumsLeft[3], $top, $ICON_HELP_HEIGHT, $ICON_HELP_HEIGHT)
	GUICtrlSetTip($hHelpIcon_EnvironmentInput, $TXT_POPUP_SETTINGS_Environment_Help)
	#endregion environment settings

	;~ Select the base path
	#region base path settings
	$top = $marginTop + (3 * $lineHeight)
	Local $newBasePath = $CurrentBasePath
	GUICtrlCreateLabel($TXT_POPUP_SETTINGS_BasePath, $ColumsLeft[0], $top, $labelWidth, 20)
	Local $BasePathInput = GUICtrlCreateLabel($CurrentBasePath, $ColumsLeft[1], $top, 280, 20)
	Local $BTN_SelectBasepath = CreateButton($TXT_POPUP_SETTINGS_SelectBasePath, $ColumsLeft[2], $top, 60)
	Local $hHelpIcon_SelectBasepath = GUICtrlCreateIcon($ResourceFile, -6, $ColumsLeft[3], $top, $ICON_HELP_HEIGHT, $ICON_HELP_HEIGHT)
	Local $helpText_SelectBasepath = $TXT_POPUP_SETTINGS_BasePath_Help
	GUICtrlSetTip($hHelpIcon_SelectBasepath, $helpText_SelectBasepath)
	#endregion base path settings

	;GUICtrlCreateLabel("IM Processes: ", $ColumsLeft[0], $marginTop + (2 * $lineHeight), $labelWidth, 20)
	;Local $IMProcesses = GUICtrlCreateCombo($IMProcesses_ProcessManager, $ColumsLeft[1], $marginTop + (2 * $lineHeight), 280, 20)
	;GUICtrlSetData(-1, $IMProcesses_Scheduler & "|" & $IMProcesses_Calculator & "|" & $IMProcesses_UIServer & "|" & $IMProcesses_ResourceManager & "|" & $IMProcesses_InstrumentAccess, $IMProcesses_ProcessManager)

	Local $BTN_SaveSettings = CreateButton($TEXT_BTN_Save, $ColumsLeft[0], $popupHeight - $BTN_HEIGHT, 150); GUICtrlCreateButton("&Save", 10, $popupHeight - $BTN_HEIGHT, 150, $BTN_Height, $BS_FLAT)
	Local $BTN_DiscardSettings = CreateButton($TEXT_BTN_Cancel, $ColumsLeft[0] + 150 + 10, $popupHeight - $BTN_HEIGHT, 150)
	Local $BTN_LoadDefaultSettings = CreateButton($TEXT_BTN_Default, $ColumsLeft[0] + 150 + 10 + 150 + 10, $popupHeight - $BTN_HEIGHT, 150)

	GUISetState(@SW_SHOW, $settingsPopup)

	While 1
		Local $msg = GUIGetMsg()
		Switch $msg
			Case $UserPostfixInput
				$newUserPostfix = GUICtrlRead($UserPostfixInput)
			Case $UseICSimulatorInput
				$newUseICSimulator = GUICtrlRead($UseICSimulatorInput)
			Case $EnvironmentInput
				$newEnvironment = GUICtrlRead($EnvironmentInput)
			Case $BTN_SelectBasepath
				$newBasePath = FileSelectFolder($TXT_POPUP_SETTINGS_SelectBasePath_Message, "C:\") & "\"
				If FileExists($newBasePath) And Not ($newBasePath = "\") Then
					GUICtrlSetData($BasePathInput, $newBasePath)
				EndIf
			Case $BTN_SaveSettings
				$CurrentUserPostfix = $newUserPostfix
				$CurrentUseICSimulator = $newUseICSimulator
				$CurrentEnvironment = $newEnvironment
				$CurrentBasePath = $newBasePath
				SaveSettings()
				MsgBox(64, $TXT_POPUP_SETTINGS_RestartMessageTitle, $TXT_POPUP_SETTINGS_RestartMessage)
				ExitLoop
			Case $BTN_DiscardSettings
				ExitLoop
			Case $BTN_LoadDefaultSettings
				LoadDefaultSettings()
			Case $GUI_EVENT_CLOSE
				ExitLoop
		EndSwitch
	WEnd
	Opt("GUIOnEventMode",1)
	GUIDelete()
EndFunc

Func ShowAboutPopup()
	Local $popupWidth = 500
	Local $popupHeight = 300
	Local $aboutPopup = GUICreate($TXT_POPUP_ABOUT_About, $popupWidth, $popupHeight)
	Opt("GUIOnEventMode",0)
	GUICtrlCreateLabel("Copyright: 2013 @ Roche", 10, 20, 200, 20)
	GUICtrlCreateLabel("Author: Rico", 10, 60, 200, 20)
	GUICtrlCreateLabel("Version: 0.2", 10, 100, 200, 20)
	GUICtrlCreateLabel("Last change: 2013-Oct-07", 10, 140, 200, 20)
	GUISetState(@SW_SHOW, $aboutPopup)
	While 1
		Local $msg = GUIGetMsg()
		Switch $msg
			Case $GUI_EVENT_CLOSE
				ExitLoop
		EndSwitch
	WEnd
	Opt("GUIOnEventMode",1)
	GUIDelete()
EndFunc
#endregion Popups