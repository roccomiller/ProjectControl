
Func PreparationAction_Click()
   If GUICtrlRead($CBX_Preparation_RemoveOldMasterData) = $GUI_CHECKED Then
	  RunTest_Preparation()
   EndIf
   If GUICtrlRead($CBX_Preparation_RemoveOldLogfiles) = $GUI_CHECKED Then
	  RunTest_Preparation()
   EndIf
   If GUICtrlRead($CBX_Preparation_CleanDatabas) = $GUI_CHECKED Then
	  RunTest_Preparation()
   EndIf
   If GUICtrlRead($CBX_SourceControl_GetLatest) = $GUI_CHECKED Then
	  RunTest_Preparation()
   EndIf
   If GUICtrlRead($CBX_SourceControl_GetTheDependecies) = $GUI_CHECKED Then
	  RunTest_Preparation()
   EndIf
   If GUICtrlRead($CBX_SourceControl_BuildIMSolution) = $GUI_CHECKED Then
	  RunTest_Preparation()
   EndIf
   If GUICtrlRead($CBX_SourceControl_RemoveComitServices) = $GUI_CHECKED Then
	  RunTest_Preparation()
   EndIf
   If GUICtrlRead($CBX_SourceControl_AdaptTheConfigFiles) = $GUI_CHECKED Then
	  RunTest_Preparation()
   EndIf
EndFunc

Func RunTest_Preparation()
   
EndFunc