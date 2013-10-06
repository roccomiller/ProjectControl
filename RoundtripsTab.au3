
If $includeRoundtrips Then
   GUICtrlCreateTabItem($TEXT_TAB_ROUNDTRIPS_Tab)
   GUICtrlCreateGroup($TEXT_TAB_ROUNDTRIPS_GROUP_Roundtrips, $TAB_GROUP_LEFT, $TAB_GROUP_TOP, $TAB_GROUP_WIDTH, $TAB_GROUP_HEIGHT)

   Global $CBX_Roundtrips_Dummy = GUICtrlCreateCheckbox($TEXT_TAB_ROUNDTRIPS_CBX_Dummy, $TAB_GROUP_LEFT + 5, $TAB_GROUP_TOP + ($CBX_HEIGHT * 1), $TAB_GROUP_WIDTH - 10, $CBX_HEIGHT)
   _ArrayAdd($RoundtripsCheckBoxes, $CBX_Roundtrips_Dummy)

   ;~ Check all and start actions
   Global $CBX_Roundtrips_All = GUICtrlCreateCheckbox($TEXT_TAB_ROUNDTRIPS_CBX_CheckAll, $TAB_GROUP_LEFT + 5, $CBX_CHECKALL_TOP, $TAB_GROUP_WIDTH - 10, $CBX_HEIGHT)
   _ArrayAdd($CheckAllCheckBoxes, $CBX_Roundtrips_All)
   Global $BTN_RoundtripsAction_Click = CreateButton($TEXT_BTN_StartAction, $BTN_ACTIONSSTART_LEFT, $BTN_ACTIONSSTART_TOP, $BTN_ACTIONSSTART_WIDTH)
   _ArrayAdd($ActionButtons, $BTN_RoundtripsAction_Click)
EndIf