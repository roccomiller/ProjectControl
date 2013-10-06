
If $includeSourcControl Then
   GUICtrlCreateTabItem($TEXT_TAB_SOURCECONTROL_Tab)
   GUICtrlCreateGroup($TEXT_TAB_SOURCECONTROL_GROUP_SourceControl, $TAB_GROUP_LEFT, $TAB_GROUP_TOP, $TAB_GROUP_WIDTH, $TAB_GROUP_HEIGHT)
   
   Global $CBX_SourceControl_UndoAllPendingChanges = GUICtrlCreateCheckbox($TEXT_TAB_SOURCECONTROL_CBX_UndoAllPendingChanges, $TAB_GROUP_LEFT + 5, $TAB_GROUP_TOP + ($CBX_HEIGHT * 1), $TAB_GROUP_WIDTH - 10, $CBX_HEIGHT)
   _ArrayAdd($SourceControlCheckBoxes, $CBX_SourceControl_UndoAllPendingChanges)
   
   Global $CBX_SourceControl_RemoveDev = GUICtrlCreateCheckbox($TEXT_TAB_SOURCECONTROL_CBX_RemoveDev, $TAB_GROUP_LEFT + 5, $TAB_GROUP_TOP + ($CBX_HEIGHT * 2), $TAB_GROUP_WIDTH - 10, $CBX_HEIGHT)
   _ArrayAdd($SourceControlCheckBoxes, $CBX_SourceControl_RemoveDev)
   
   Global $CBX_SourceControl_GetLatest = GUICtrlCreateCheckbox($TEXT_TAB_SOURCECONTROL_CBX_GetLatest, $TAB_GROUP_LEFT + 5, $TAB_GROUP_TOP + ($CBX_HEIGHT * 3), $TAB_GROUP_WIDTH - 10, $CBX_HEIGHT)
   _ArrayAdd($SourceControlCheckBoxes, $CBX_SourceControl_GetLatest)
   
   Global $CBX_SourceControl_GetTheDependecies = GUICtrlCreateCheckbox($TEXT_TAB_SOURCECONTROL_CBX_GetTheDependecies, $TAB_GROUP_LEFT + 5, $TAB_GROUP_TOP + ($CBX_HEIGHT * 4), $TAB_GROUP_WIDTH - 10, $CBX_HEIGHT)
   _ArrayAdd($SourceControlCheckBoxes, $CBX_SourceControl_GetTheDependecies)
   
   Global $CBX_SourceControl_BuildIMSolution = GUICtrlCreateCheckbox($TEXT_TAB_SOURCECONTROL_CBX_BuildIMSolution, $TAB_GROUP_LEFT + 5, $TAB_GROUP_TOP + ($CBX_HEIGHT * 5), $TAB_GROUP_WIDTH - 10, $CBX_HEIGHT)
   _ArrayAdd($SourceControlCheckBoxes, $CBX_SourceControl_BuildIMSolution)
   
   Global $CBX_SourceControl_RemoveComitServices = GUICtrlCreateCheckbox($TEXT_TAB_SOURCECONTROL_CBX_RemoveComitServices, $TAB_GROUP_LEFT + 5, $TAB_GROUP_TOP + ($CBX_HEIGHT * 6), $TAB_GROUP_WIDTH - 10, $CBX_HEIGHT)
   _ArrayAdd($SourceControlCheckBoxes, $CBX_SourceControl_RemoveComitServices)
   
   Global $CBX_SourceControl_AdaptTheConfigFiles = GUICtrlCreateCheckbox($TEXT_TAB_SOURCECONTROL_CBX_AdaptTheConfigFiles, $TAB_GROUP_LEFT + 5, $TAB_GROUP_TOP + ($CBX_HEIGHT * 7), $TAB_GROUP_WIDTH - 10, $CBX_HEIGHT)
   _ArrayAdd($SourceControlCheckBoxes, $CBX_SourceControl_AdaptTheConfigFiles)   
   
   ;~ Check all and start actions
   Global $CBX_SourceControl_All = GUICtrlCreateCheckbox($TEXT_TAB_SOURCECONTROL_CBX_CheckAll, $TAB_GROUP_LEFT + 5, $CBX_CHECKALL_TOP, $TAB_GROUP_WIDTH - 10, $CBX_HEIGHT)
   _ArrayAdd($CheckAllCheckBoxes, $CBX_SourceControl_All)
   Global $BTN_SourceControlAction_Click = CreateButton($TEXT_BTN_StartAction, $BTN_ACTIONSSTART_LEFT, $BTN_ACTIONSSTART_TOP, $BTN_ACTIONSSTART_WIDTH)
   _ArrayAdd($ActionButtons, $BTN_SourceControlAction_Click)
EndIf