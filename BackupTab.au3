
If $includeBackup Then
   GUICtrlCreateTabItem($TEXT_TAB_BACKUP_Tab)
   GUICtrlCreateGroup($TEXT_TAB_BACKUP_GROUP_Backup, $TAB_GROUP_LEFT, $TAB_GROUP_TOP, $TAB_GROUP_WIDTH, $TAB_GROUP_HEIGHT)

   $CBX_Backup_Dummy = GUICtrlCreateCheckbox($TEXT_TAB_BACKUP_CBX_Dummy, $TAB_GROUP_LEFT + 5, $TAB_GROUP_TOP + ($CBX_HEIGHT * 1), $TAB_GROUP_WIDTH - 10, $CBX_HEIGHT)
   _ArrayAdd($BackupCheckBoxes, $CBX_Backup_Dummy)

   ;~ Check all and start actions
   $CBX_Backup_All = GUICtrlCreateCheckbox($TEXT_TAB_BACKUP_CBX_CheckAll, $TAB_GROUP_LEFT + 5, $CBX_CHECKALL_TOP, $TAB_GROUP_WIDTH - 10, $CBX_HEIGHT)
   GUICtrlSetTip($CBX_BACKUP_All, $TEXT_TAB_BACKUP_CBX_CheckAll_ToolTip)
   _ArrayAdd($CheckAllCheckBoxes, $CBX_Backup_All)
   Global $BTN_BackupAction_Click = CreateButton($TEXT_BTN_StartAction, $BTN_ACTIONSSTART_LEFT, $BTN_ACTIONSSTART_TOP, $BTN_ACTIONSSTART_WIDTH)
   _ArrayAdd($ActionButtons, $BTN_BackupAction_Click)
EndIf