
If $includeSourceControl Then
	Local $currentLine = 1
	GUICtrlCreateTabItem($TEXT_TAB_SOURCECONTROL_Tab)
	GUICtrlCreateGroup($TEXT_TAB_SOURCECONTROL_GROUP_SourceControl, $TAB_GROUP_LEFT, $TAB_GROUP_TOP, $TAB_GROUP_WIDTH, $TAB_GROUP_HEIGHT)

	$CBX_SourceControl_ShowTfsHistory = GUICtrlCreateCheckbox($TEXT_TAB_SOURCECONTROL_CBX_ShowTFSHistory, $TAB_GROUP_LEFT + 5, $TAB_GROUP_TOP + ($CBX_HEIGHT * $currentLine), $TAB_GROUP_WIDTH - 10, $CBX_HEIGHT)
	_ArrayAdd($SourceControlCheckBoxes, $CBX_SourceControl_ShowTfsHistory)

	$currentLine += 1
	$CBX_SourceControl_UndoAllPendingChanges = GUICtrlCreateCheckbox($TEXT_TAB_SOURCECONTROL_CBX_UndoAllPendingChanges, $TAB_GROUP_LEFT + 5, $TAB_GROUP_TOP + ($CBX_HEIGHT * $currentLine), $TAB_GROUP_WIDTH - 10, $CBX_HEIGHT)
	_ArrayAdd($SourceControlCheckBoxes, $CBX_SourceControl_UndoAllPendingChanges)

	$currentLine += 1
	$CBX_SourceControl_RemoveDev = GUICtrlCreateCheckbox($TEXT_TAB_SOURCECONTROL_CBX_RemoveDev, $TAB_GROUP_LEFT + 5, $TAB_GROUP_TOP + ($CBX_HEIGHT * $currentLine), $TAB_GROUP_WIDTH - 10, $CBX_HEIGHT)
	_ArrayAdd($SourceControlCheckBoxes, $CBX_SourceControl_RemoveDev)

	$currentLine += 1
	$CBX_SourceControl_GetLatest = GUICtrlCreateCheckbox($TEXT_TAB_SOURCECONTROL_CBX_GetLatest, $TAB_GROUP_LEFT + 5, $TAB_GROUP_TOP + ($CBX_HEIGHT * $currentLine), $TAB_GROUP_WIDTH - 10, $CBX_HEIGHT)
	_ArrayAdd($SourceControlCheckBoxes, $CBX_SourceControl_GetLatest)

	$currentLine += 1
	$CBX_SourceControl_GetTheDependecies = GUICtrlCreateCheckbox($TEXT_TAB_SOURCECONTROL_CBX_GetTheDependecies, $TAB_GROUP_LEFT + 5, $TAB_GROUP_TOP + ($CBX_HEIGHT * $currentLine), $TAB_GROUP_WIDTH - 10, $CBX_HEIGHT)
	_ArrayAdd($SourceControlCheckBoxes, $CBX_SourceControl_GetTheDependecies)

	$currentLine += 1
	$CBX_SourceControl_CleanBuildDir = GUICtrlCreateCheckbox($TEXT_TAB_SOURCECONTROL_CBX_CleanBuildDir, $TAB_GROUP_LEFT + 5, $TAB_GROUP_TOP + ($CBX_HEIGHT * $currentLine), $TAB_GROUP_WIDTH - 10, $CBX_HEIGHT)
	_ArrayAdd($SourceControlCheckBoxes, $CBX_SourceControl_CleanBuildDir)

	$currentLine += 1
	$CBX_SourceControl_BuildIMSolutionDebugNoTests = GUICtrlCreateCheckbox($TEXT_TAB_SOURCECONTROL_CBX_BuildIMSolutionDebugNoTests, $TAB_GROUP_LEFT + 5, $TAB_GROUP_TOP + ($CBX_HEIGHT * $currentLine), $TAB_GROUP_WIDTH - 10, $CBX_HEIGHT)
	_ArrayAdd($SourceControlCheckBoxes, $CBX_SourceControl_BuildIMSolutionDebugNoTests)
	GUICtrlSetOnEvent($CBX_SourceControl_BuildIMSolutionDebugNoTests, "SetBuildIMSolutionDebugNoTestsCheckBox")

	$currentLine += 1
	$CBX_SourceControl_BuildIMSolutionDebugNoInstaller = GUICtrlCreateCheckbox($TEXT_TAB_SOURCECONTROL_CBX_BuildIMSolutionDebugNoInstaller, $TAB_GROUP_LEFT + 5, $TAB_GROUP_TOP + ($CBX_HEIGHT * $currentLine), $TAB_GROUP_WIDTH - 10, $CBX_HEIGHT)
	_ArrayAdd($SourceControlCheckBoxes, $CBX_SourceControl_BuildIMSolutionDebugNoInstaller)
	GUICtrlSetOnEvent($CBX_SourceControl_BuildIMSolutionDebugNoInstaller, "SetBuildIMSolutionDebugNoInstallerCheckBox")

	$currentLine += 1
	$CBX_SourceControl_BuildIMSolutionDebug = GUICtrlCreateCheckbox($TEXT_TAB_SOURCECONTROL_CBX_BuildIMSolutionDebug, $TAB_GROUP_LEFT + 5, $TAB_GROUP_TOP + ($CBX_HEIGHT * $currentLine), $TAB_GROUP_WIDTH - 10, $CBX_HEIGHT)
	_ArrayAdd($SourceControlCheckBoxes, $CBX_SourceControl_BuildIMSolutionDebug)
	GUICtrlSetOnEvent($CBX_SourceControl_BuildIMSolutionDebug, "SetBuildIMSolutionDebugCheckBox")

	$currentLine += 1
	$CBX_SourceControl_RemoveComitServices = GUICtrlCreateCheckbox($TEXT_TAB_SOURCECONTROL_CBX_RemoveComitServices, $TAB_GROUP_LEFT + 5, $TAB_GROUP_TOP + ($CBX_HEIGHT * $currentLine), $TAB_GROUP_WIDTH - 10, $CBX_HEIGHT)
	_ArrayAdd($SourceControlCheckBoxes, $CBX_SourceControl_RemoveComitServices)

	$currentLine += 1
	$CBX_SourceControl_AdaptTheConfigFiles = GUICtrlCreateCheckbox($TEXT_TAB_SOURCECONTROL_CBX_AdaptTheConfigFiles, $TAB_GROUP_LEFT + 5, $TAB_GROUP_TOP + ($CBX_HEIGHT * $currentLine), $TAB_GROUP_WIDTH - 10, $CBX_HEIGHT)
	_ArrayAdd($SourceControlCheckBoxes, $CBX_SourceControl_AdaptTheConfigFiles)

	;~ Check all and start actions
	$CBX_SourceControl_All = GUICtrlCreateCheckbox($TEXT_TAB_SOURCECONTROL_CBX_CheckAll, $TAB_GROUP_LEFT + 5, $CBX_CHECKALL_TOP, $TAB_GROUP_WIDTH - 10, $CBX_HEIGHT)
	GUICtrlSetTip($CBX_SOURCECONTROL_All, $TEXT_TAB_SOURCECONTROL_CBX_CheckAll_ToolTip)
	_ArrayAdd($CheckAllCheckBoxes, $CBX_SourceControl_All)
	GUICtrlSetOnEvent($CBX_SourceControl_All, "SetSourceControlCheckBoxState")

	Global $BTN_SourceControlAction_Click = CreateButton($TEXT_BTN_StartAction, $BTN_ACTIONSSTART_LEFT, $BTN_ACTIONSSTART_TOP, $BTN_ACTIONSSTART_WIDTH)
	_ArrayAdd($ActionButtons, $BTN_SourceControlAction_Click)
	GUICtrlSetOnEvent($BTN_SourceControlAction_Click ,"SourceControlAction_Click")
EndIf

;~ second group
If $includeSourceControl Then
	GUICtrlCreateGroup($TEXT_TAB_SOURCECONTROL_GROUP_CheckAndTestIt, $TAB_GROUP_LEFT_2, $TAB_GROUP_TOP, $TAB_GROUP_WIDTH, $TAB_GROUP_HEIGHT)

	$CBX_SourceControl_RunFxCopAll = GUICtrlCreateCheckbox($TEXT_TAB_SOURCECONTROL_CBX_RunFxCopAll, $TAB_GROUP_LEFT_2 + 5, $TAB_GROUP_TOP + ($CBX_HEIGHT * 1), $TAB_GROUP_WIDTH - 10, $CBX_HEIGHT)
	_ArrayAdd($SourceControlCheckAndTestItCheckBoxes, $CBX_SourceControl_RunFxCopAll)

	$CBX_SourceControl_RunFxCopSelective = GUICtrlCreateCheckbox($TEXT_TAB_SOURCECONTROL_CBX_RunFxCopSelective, $TAB_GROUP_LEFT_2 + 5, $TAB_GROUP_TOP + ($CBX_HEIGHT * 2), $TAB_GROUP_WIDTH - 10, $CBX_HEIGHT)
	_ArrayAdd($SourceControlCheckAndTestItCheckBoxes, $CBX_SourceControl_RunFxCopSelective)

	$CBX_SourceControl_CleanTestDataBase = GUICtrlCreateCheckbox($TEXT_TAB_SOURCECONTROL_CBX_CleanTestDataBase, $TAB_GROUP_LEFT_2 + 5, $TAB_GROUP_TOP + ($CBX_HEIGHT * 3), $TAB_GROUP_WIDTH - 10, $CBX_HEIGHT)
	_ArrayAdd($SourceControlCheckAndTestItCheckBoxes, $CBX_SourceControl_CleanTestDataBase)

	;~ Check all and start actions
	$CBX_SourceControl_CheckAndTestIt_All = GUICtrlCreateCheckbox($TEXT_TAB_SOURCECONTROL_CBX_CheckAndTestIt_CheckAll, $TAB_GROUP_LEFT_2 + 5, $CBX_CHECKALL_TOP, $TAB_GROUP_WIDTH - 10, $CBX_HEIGHT)
	GUICtrlSetTip($CBX_SourceControl_CheckAndTestIt_All, $TEXT_TAB_SOURCECONTROL_CBX_CheckAndTestIt_CheckAll_ToolTip)
	_ArrayAdd($CheckAllCheckBoxes, $CBX_SourceControl_CheckAndTestIt_All)
	GUICtrlSetOnEvent($CBX_SourceControl_CheckAndTestIt_All, "SetSourceControlCheckAndTestItCheckBoxState")

	Global $BTN_SourceControlAction_CheckAndTestIt_Click = CreateButton($TEXT_BTN_StartAction, $BTN_ACTIONSSTART_LEFT_2, $BTN_ACTIONSSTART_TOP, $BTN_ACTIONSSTART_WIDTH)
	_ArrayAdd($ActionButtons, $BTN_SourceControlAction_CheckAndTestIt_Click)
	GUICtrlSetOnEvent($BTN_SourceControlAction_CheckAndTestIt_Click ,"SourceControlAction_CheckAndTestIt_Click")
EndIf