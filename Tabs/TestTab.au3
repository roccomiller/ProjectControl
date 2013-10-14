
If $includeTest Then
   GUICtrlCreateTabItem($TEXT_TAB_TEST_Tab)
   GUICtrlCreateGroup($TEXT_TAB_TEST_GROUP_Test, $TAB_GROUP_LEFT, $TAB_GROUP_TOP, $TAB_GROUP_WIDTH, $TAB_GROUP_HEIGHT)
   $hHelpIcon = GUICtrlCreateIcon($ResourceFile, -6, $TAB_GROUP_WIDTH + $TAB_GROUP_LEFT - $ICON_HELP_HEIGHT - 2, $TAB_GROUP_TOP + 8, $ICON_HELP_HEIGHT, $ICON_HELP_HEIGHT)

   $CBX_Test = GUICtrlCreateCheckbox($TEXT_TAB_TEST_CBX_Test, $TAB_GROUP_LEFT + 5, $TAB_GROUP_TOP + ($CBX_HEIGHT * 1), $TAB_GROUP_WIDTH - 24, $CBX_HEIGHT)
   GUICtrlSetTip($hHelpIcon, "hier werden sie geholfen...")
   GUICtrlSetBkColor($CBX_Test, 0xFF0000)
   _ArrayAdd($TestCheckBoxes, $CBX_Test)



   ;~ Check all and start actions
   $CBX_Test_All = GUICtrlCreateCheckbox($TEXT_TAB_TEST_CBX_CheckAll, $TAB_GROUP_LEFT + 5, $CBX_CHECKALL_TOP, $TAB_GROUP_WIDTH - 10, $CBX_HEIGHT)
   GUICtrlSetTip($CBX_Test_All, $TEXT_TAB_TEST_CBX_CheckAll_ToolTip)
   _ArrayAdd($CheckAllCheckBoxes, $CBX_Test_All)
   GUICtrlSetOnEvent($CBX_Test_All, "SetTestCheckBoxState")
   Global $BTN_TestAction_Click = CreateButton($TEXT_BTN_StartAction, $BTN_ACTIONSSTART_LEFT, $BTN_ACTIONSSTART_TOP, $BTN_ACTIONSSTART_WIDTH)
   _ArrayAdd($ActionButtons, $BTN_TestAction_Click)
   GUICtrlSetOnEvent($BTN_TestAction_Click, "TestAction_Click")

EndIf