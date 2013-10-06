#region Included Resources
#AutoIt3Wrapper_Res_Icon_Add=Icons\Jahshaka.ico ; Icon number -5
#AutoIt3Wrapper_Res_Icon_Add=Icons\Help.ico ; Icon number -6
#AutoIt3Wrapper_Res_Icon_Add=Icons\ToolTip.ico ; Icon nubmer -7
#AutoIt3Wrapper_Res_Icon_Add=Icons\Start.ico ; Icon nubmer -8
#endregion Included Resources
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****.
#AutoIt3Wrapper_Outfile_x64=SnipetGUI.exe
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****


#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <ButtonConstants.au3>
;#include <GDIPlus.au3>
;#include <WinAPI.au3>
Global $ResourceFile = @ScriptFullPath
Initialize()
Main()


Func Main()
	Global $hMainGUI = GUICreate("Snipet test gui", 800, 800)
	GUISetIcon(@ScriptFullPath, -5)

	#region snipet
	;#include "TabWithIcon.au3"
	;#include "ToolTip.au3"
	#include "ButtonWithIcon.au3"
	#endregion snipet

	GUISetState(@SW_SHOWNORMAL, $hMainGUI)
	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				ExitLoop
		EndSwitch
	WEnd
EndFunc

Func Initialize()
	If stringRight($ResourceFile, 4) = ".au3" Then
		$ResourceFile = StringReplace($ResourceFile, ".au3", ".exe", 1)
	EndIf
EndFunc

Func CreateGroup($text, $left, $top, $widht, $height)
	$hGroup = GUICtrlCreateGroup($text, $left, $top, $widht, $height) ;$BS_FLAT
	;GUICtrlSetState($hGroup, $GUI_DISABLE)
	;Return $hGroup
EndFunc

Func TestButton()
	GUICtrlCreateButton("test", 15, 160, 150, 32, BitOr($BS_FLAT, $WS_CLIPSIBLINGS))
	GUICtrlSetState(-1, $GUI_ENABLE)
EndFunc

Func CreateButton($text, $left, $top, $widht = 0, $height = 0, $iconNumber = 0)
	If $widht = 0 Then
		$widht = (StringLen($text) * 6)
	EndIf
	If $height = 0 Then
		$height = 34
	EndIf
	If Not ($iconNumber = 0) Then
		GUICtrlCreateIcon($ResourceFile, $iconNumber, $left + 1, $top + 1, $height - 2, $height - 2)
		;GUICtrlSetState(-1, $GUI_DISABLE)
		$widht += 64
	EndIf
	$XS_btnx = GUICtrlCreateButton($text, $left, $top, $widht, $height, BitOr($BS_FLAT, $WS_CLIPSIBLINGS))
	DllCall("UxTheme.dll", "int", "SetWindowTheme", "hwnd", GUICtrlGetHandle($XS_btnx), "wstr", 0, "wstr", 0)
	Return $XS_btnx
EndFunc