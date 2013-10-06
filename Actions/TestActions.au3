
;~ Declare all used checkboxes here to prevent warnings in the usage
#region Checkbox declaration
Global $CBX_Test

Global $CBX_Test_All
#endregion Checkbox declaration

Func TestAction_Click()
   If GUICtrlRead($CBX_Test) = $GUI_CHECKED Then
	  RunTest_SystemStatus()
   EndIf
EndFunc

Func RunTest_SystemStatus()
   SetSystemStatus("Running", "Running your test actions")
   DisableAllControlls()
   ;SleepWithStatusUpdate(50000, True)
   SleepWithStatusUpdatePercentage(20000, True)
   EnableAllControlls()
   SetSystemStatus("Ready")
   CreateMsgBox(64, "test", "blabal")
EndFunc


Func RunTest_RunWait()
   ;#requireAdmin
   $pid = RunWait("Test.bat")
   MsgBox(64, "Teste", $pid)
   $pid = Run("Test.bat")
   While ProcessExists($pid)
	  Sleep(2000)
   WEnd
   MsgBox(64, "Teste", $pid)
EndFunc