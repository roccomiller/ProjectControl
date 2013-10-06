
If $includePreparation Then
   GUICtrlCreateTabItem($TEXT_TAB_PREPARATION_Tab)
   GUICtrlCreateGroup($TEXT_TAB_PREPARATION_GROUP_Preparation, $TAB_GROUP_LEFT, $TAB_GROUP_TOP, $TAB_GROUP_WIDTH, $TAB_GROUP_HEIGHT)

   $CBX_Preparation_RemoveOldMasterData = GUICtrlCreateCheckbox($TEXT_TAB_PREPARATION_CBX_RemoveOldMasterData, $TAB_GROUP_LEFT + 5, $TAB_GROUP_TOP + ($CBX_HEIGHT * 1), $TAB_GROUP_WIDTH - 10, $CBX_HEIGHT)
   _ArrayAdd($PreparationCheckBoxes, $CBX_Preparation_RemoveOldMasterData)

   $CBX_Preparation_RemoveOldLogfiles = GUICtrlCreateCheckbox($TEXT_TAB_PREPARATION_CBX_RemoveOldLogfiles, $TAB_GROUP_LEFT + 5, $TAB_GROUP_TOP + ($CBX_HEIGHT * 2), $TAB_GROUP_WIDTH - 10, $CBX_HEIGHT)
   _ArrayAdd($PreparationCheckBoxes, $CBX_Preparation_RemoveOldLogfiles)

   $CBX_Preparation_CleanDatabas = GUICtrlCreateCheckbox($TEXT_TAB_PREPARATION_CBX_CleanDatabase, $TAB_GROUP_LEFT + 5, $TAB_GROUP_TOP + ($CBX_HEIGHT * 3), $TAB_GROUP_WIDTH - 10, $CBX_HEIGHT)
   _ArrayAdd($PreparationCheckBoxes, $CBX_Preparation_CleanDatabas)

   $CBX_Preparation_CopyDatabaseExportTool = GUICtrlCreateCheckbox($TEXT_TAB_PREPARATION_CBX_CopyDatabaseExportTool, $TAB_GROUP_LEFT + 5, $TAB_GROUP_TOP + ($CBX_HEIGHT * 4), $TAB_GROUP_WIDTH - 10, $CBX_HEIGHT)
   _ArrayAdd($PreparationCheckBoxes, $CBX_Preparation_CopyDatabaseExportTool)

   $CBX_Preparation_StartICSimulator = GUICtrlCreateCheckbox($TEXT_TAB_PREPARATION_CBX_StartICSimulator, $TAB_GROUP_LEFT + 5, $TAB_GROUP_TOP + ($CBX_HEIGHT * 5), $TAB_GROUP_WIDTH - 10, $CBX_HEIGHT)
   _ArrayAdd($PreparationCheckBoxes, $CBX_Preparation_StartICSimulator)

   $CBX_Preparation_StartHL7Simulator = GUICtrlCreateCheckbox($TEXT_TAB_PREPARATION_CBX_StartHL7Simulator, $TAB_GROUP_LEFT + 5, $TAB_GROUP_TOP + ($CBX_HEIGHT * 6), $TAB_GROUP_WIDTH - 10, $CBX_HEIGHT)
   _ArrayAdd($PreparationCheckBoxes, $CBX_Preparation_StartHL7Simulator)

   $CBX_Preparation_StartIMSoftware = GUICtrlCreateCheckbox($TEXT_TAB_PREPARATION_CBX_StartIMSoftware, $TAB_GROUP_LEFT + 5, $TAB_GROUP_TOP + ($CBX_HEIGHT * 7), $TAB_GROUP_WIDTH - 10, $CBX_HEIGHT)
   _ArrayAdd($PreparationCheckBoxes, $CBX_Preparation_StartIMSoftware)

   $CBX_Preparation_CopyMasterDatafiles = GUICtrlCreateCheckbox($TEXT_TAB_PREPARATION_CBX_CopyMasterDatafiles, $TAB_GROUP_LEFT + 5, $TAB_GROUP_TOP + ($CBX_HEIGHT * 8), $TAB_GROUP_WIDTH - 10, $CBX_HEIGHT)
   _ArrayAdd($PreparationCheckBoxes, $CBX_Preparation_CopyMasterDatafiles)

   ;~ Check all and start actions
   $CBX_Preparation_All = GUICtrlCreateCheckbox($TEXT_TAB_PREPARATION_CBX_CheckAll, $TAB_GROUP_LEFT + 5, $CBX_CHECKALL_TOP, $TAB_GROUP_WIDTH - 10, $CBX_HEIGHT)
   GUICtrlSetTip($CBX_PREPARATION_All, $TEXT_TAB_PREPARATION_CBX_CheckAll_ToolTip)
   _ArrayAdd($CheckAllCheckBoxes, $CBX_Preparation_All)
   Global $BTN_PreparationAction_Click = CreateButton($TEXT_BTN_StartAction, $BTN_ACTIONSSTART_LEFT, $BTN_ACTIONSSTART_TOP, $BTN_ACTIONSSTART_WIDTH)
   _ArrayAdd($ActionButtons, $BTN_PreparationAction_Click)
EndIf