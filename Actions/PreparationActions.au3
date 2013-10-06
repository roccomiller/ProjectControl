
;~ Declare all used checkboxes here to prevent warnings in the usage
#region Checkbox declaration
Global $CBX_Preparation_RemoveOldMasterData
Global $CBX_Preparation_RemoveOldLogfiles
Global $CBX_Preparation_CleanDatabas
Global $CBX_SourceControl_GetLatest
Global $CBX_SourceControl_GetTheDependecies
Global $CBX_SourceControl_BuildIMSolution
Global $CBX_SourceControl_RemoveComitServices
Global $CBX_SourceControl_AdaptTheConfigFiles

Global $CBX_Preparation_All
_ArrayAdd($CheckAllCheckBoxes, $CBX_Preparation_All)
#endregion Checkbox declaration

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