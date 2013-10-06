
If $includeTest Then
   GUICtrlCreateTabItem($TEXT_TAB_TEST_Tab)
   GUICtrlCreateGroup($TEXT_TAB_TEST_GROUP_Test, $TAB_GROUP_LEFT, $TAB_GROUP_TOP, $TAB_GROUP_WIDTH, $TAB_GROUP_HEIGHT)
   
   Global $CBX_Test = GUICtrlCreateCheckbox($TEXT_TAB_TEST_CBX_Test, $TAB_GROUP_LEFT + 5, $TAB_GROUP_TOP + ($CBX_HEIGHT * 1), $TAB_GROUP_WIDTH - 10, $CBX_HEIGHT)
   _ArrayAdd($TestCheckBoxes, $CBX_Test)
  
   ;~ Check all and start actions
   Global $CBX_Test_All = GUICtrlCreateCheckbox($TEXT_TAB_TEST_CBX_CheckAll, $TAB_GROUP_LEFT + 5, $CBX_CHECKALL_TOP, $TAB_GROUP_WIDTH - 10, $CBX_HEIGHT)
   _ArrayAdd($CheckAllCheckBoxes, $CBX_Test_All)
   Global $BTN_TestAction_Click = CreateButton($TEXT_BTN_StartAction, $BTN_ACTIONSSTART_LEFT, $BTN_ACTIONSSTART_TOP, $BTN_ACTIONSSTART_WIDTH)
   _ArrayAdd($ActionButtons, $BTN_TestAction_Click)
EndIf