#include-once 
#include <GUIConstantsEx.au3>

Global $ScriptPaused
HotKeySet("{ESC}", "Terminate")
HotKeySet("{PAUSE}", "TogglePause")

Global Const $AnimationCharacters[4] = ["[-]", "[\]", "[|]", "[/]"]

Func CreateMsgBox($flag, $title, $text)
   SetSystemStatus("Waiting", "Waiting for message box confirmation.")
   MsgBox($flag, $title, $text)
   ResetSystemStatus()
EndFunc

Func CreateGroup()
   
EndFunc

Func CreateButton($text, $left, $top, $width, $height = $BTN_HEIGHT, $style = $BS_FLAT)
   Return GUICtrlCreateButton($text, $left, $top, $width, $height, $style)
EndFunc

Func SetCheckBoxState($checkboxes, $state)
   For $i = 1 To UBound($checkboxes) - 1
	  GUICtrlSetState($checkboxes[$i], $state)
   Next
EndFunc

Func DisableControls($arrayOfControls)
   SetControlState($arrayOfControls, $GUI_DISABLE)
EndFunc

Func EnableControls($arrayOfControls)
   SetControlState($arrayOfControls, $GUI_ENABLE)
EndFunc
 
Func DisableAllControlls()
   DisableControls($TestCheckBoxes)
   DisableControls($SourceControlCheckBoxes)
   DisableControls($PreparationCheckBoxes)
   DisableControls($RoundtripsCheckBoxes)
   DisableControls($BackupCheckBoxes)
   DisableControls($ActionButtons)
   DisableControls($CheckAllCheckBoxes)
EndFunc
 
Func EnableAllControlls()
   EnableControls($TestCheckBoxes)
   EnableControls($SourceControlCheckBoxes)
   EnableControls($PreparationCheckBoxes)
   EnableControls($RoundtripsCheckBoxes)
   EnableControls($BackupCheckBoxes)
   EnableControls($ActionButtons)
   EnableControls($CheckAllCheckBoxes)
EndFunc

Func SetControlState($arrayOfControls, $state)
	If IsArray($arrayOfControls) Then
		For $i = 0 To UBound($arrayOfControls) - 1
			GUICtrlSetState($arrayOfControls[$i], $state)
		Next
	EndIf
EndFunc

Func ResetSystemStatus()
   SetSystemStatus($OldSystemStatus)
EndFunc

Func SetSystemStatus($status, $msg = "")
   Local $icon = 324
   Switch $status
		Case "Ready"
			$icon = 112
			If $msg = "" Then
				$msg = "Up and ready..."
			EndIf
		Case "Waiting"
			$icon = 23
			If $msg = "" Then
				$msg = "Waiting for your input or action..."
			EndIf
		Case "Running"
			$icon = 137
			If $msg = "" Then
				$msg = "Runnin some action, please wait..."
			EndIf
		Case "Info"
			$icon = 221
			If $msg = "" Then
				$msg = "Good to know..."
			EndIf
		Case "Warning"
			$icon = 208
			If $msg = "" Then
				$msg = "Just take care..."
			EndIf
		Case "Error"
			$icon = 131
			If $msg = "" Then
				$msg = "Ups! Something seems to cause an error..."
			EndIf
		Case Else
			$icon = 23
			If $msg = "" Then
				$msg = "..."
			EndIf
   EndSwitch
   _GUICtrlStatusBar_SetIcon($hStatusBar, 0, _WinAPI_LoadShell32Icon($icon))
   _GUICtrlStatusBar_SetText($hStatusBar, $status, 1)
   UpdateStatusBarMsg($msg)
   $OldSystemStatus = $SystemStatus
   $SystemStatus = $status
EndFunc

Func GetSystemStatus()
	Return $SystemStatus
EndFunc

Func UpdateStatusBarMsg($msg)
   _GUICtrlStatusBar_SetText($hStatusBar, $msg, 2)
EndFunc

Func SleepWithStatusUpdate($time, $animation = False)
   Local $oldMsg = _GUICtrlStatusBar_GetText($hStatusBar, 2)
   Local $newMsg = ""
   Local $animationCounter = 0
   Local $timeout = 0
   While $timeout < $time
	  If NOT $animation Then
		 $newMsg = $oldMsg
	  Else
		 If $animationCounter = UBound($AnimationCharacters) Then
			$animationCounter = 0
		 EndIf
		 $newMsg = $oldMsg & $AnimationCharacters[$animationCounter]
		 $animationCounter += 1
	  EndIf	  
	  UpdateStatusBarMsg($newMsg)
	  Sleep(200)
	  $timeout += 200
   WEnd
EndFunc

Func SleepWithStatusUpdatePercentage($time, $animation = False)
   Local $oldMsg = _GUICtrlStatusBar_GetText($hStatusBar, 2)
   Local $newMsg = ""
   Local $animationCounter = 0
   Local $timeout = 0
   Local $percentage = 0
   While $timeout < $time
	  If NOT $animation Then
		 $newMsg = $oldMsg
	  Else
		 If $animationCounter = UBound($AnimationCharacters) Then
			$animationCounter = 0
		 EndIf
		 $newMsg = $oldMsg & " [" & $percentage & "%]"
		 $percentage = Round($timeout / $time * 100, 0)
	  EndIf	  
	  UpdateStatusBarMsg($newMsg)
	  Sleep(100)
	  $timeout += 500
   WEnd
EndFunc