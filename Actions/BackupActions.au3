
;~ Declare all used checkboxes here to prevent warnings in the usage
#region Checkbox declaration
Global $CBX_Backup_Dummy

Global $CBX_Backup_All
#endregion Checkbox declaration

Func BackupAction_Click()
   If GUICtrlRead($CBX_Backup_Dummy) = $GUI_CHECKED Then
	  RunTest_Backup()
   EndIf
EndFunc

Func RunTest_Backup()

EndFunc