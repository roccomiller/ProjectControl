
;~ Declare all used checkboxes here to prevent warnings in the usage
#region Checkbox declaration
Global $CBX_Roundtrips_Dummy

Global $CBX_Roundtrips_All
#endregion Checkbox declaration

Func SetRoundtripsCheckBoxState()
	SetCheckBoxState($RoundtripsCheckBoxes, GUICtrlRead($CBX_Roundtrips_All))
EndFunc

Func RoundtripsAction_Click()
   If GUICtrlRead($CBX_Roundtrips_Dummy) = $GUI_CHECKED Then
	  RunTest_Roundtrips()
   EndIf
EndFunc

Func RunTest_Roundtrips()

EndFunc