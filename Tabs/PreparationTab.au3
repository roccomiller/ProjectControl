
If $includePreparation Then
	Local $currentLine = 1
	GUICtrlCreateTabItem($TEXT_TAB_PREPARATION_Tab)
	GUICtrlCreateGroup($TEXT_TAB_PREPARATION_GROUP_Preparation, $TAB_GROUP_LEFT, $TAB_GROUP_TOP, $TAB_GROUP_WIDTH, $TAB_GROUP_HEIGHT)

	$CBX_Preparation_BuildIMSolution = GUICtrlCreateCheckbox($TEXT_TAB_SOURCECONTROL_CBX_BuildIMSolution, $TAB_GROUP_LEFT + 5, $TAB_GROUP_TOP + ($CBX_HEIGHT * $currentLine), $TAB_GROUP_WIDTH - 150, $CBX_HEIGHT)
	_ArrayAdd($PreparationCheckBoxes, $CBX_Preparation_BuildIMSolution)
	$BuildConfigurationInlineInput = GUICtrlCreateCombo($SupportedBuildConfigurations[0], 120, $TAB_GROUP_TOP + ($CBX_HEIGHT * $currentLine), 130, $CBX_HEIGHT)
	GUICtrlSetData($BuildConfigurationInlineInput, ConvertArrayToComboBoxString($SupportedBuildConfigurations), $CurrentBuildConfiguration)
	;GUICtrlSetOnEvent($CBX_SourceControl_BuildIMSolutionDebugNoTests, "SetBuildIMSolutionDebugNoTestsCheckBox")

	$currentLine += 1
	$CBX_Preparation_RemoveOldMasterData = GUICtrlCreateCheckbox($TEXT_TAB_PREPARATION_CBX_RemoveOldMasterData, $TAB_GROUP_LEFT + 5, $TAB_GROUP_TOP + ($CBX_HEIGHT * $currentLine), $TAB_GROUP_WIDTH - 10, $CBX_HEIGHT)
	_ArrayAdd($PreparationCheckBoxes, $CBX_Preparation_RemoveOldMasterData)

	$currentLine += 1
	$CBX_Preparation_RemoveOldLogfiles = GUICtrlCreateCheckbox($TEXT_TAB_PREPARATION_CBX_RemoveOldLogfiles, $TAB_GROUP_LEFT + 5, $TAB_GROUP_TOP + ($CBX_HEIGHT * $currentLine), $TAB_GROUP_WIDTH - 10, $CBX_HEIGHT)
	_ArrayAdd($PreparationCheckBoxes, $CBX_Preparation_RemoveOldLogfiles)

	$currentLine += 1
	$CBX_Preparation_CleanDatabase = GUICtrlCreateCheckbox($TEXT_TAB_PREPARATION_CBX_CleanDatabase, $TAB_GROUP_LEFT + 5, $TAB_GROUP_TOP + ($CBX_HEIGHT * $currentLine), $TAB_GROUP_WIDTH - 10, $CBX_HEIGHT)
	_ArrayAdd($PreparationCheckBoxes, $CBX_Preparation_CleanDatabase)

	$currentLine += 1
	$CBX_Preparation_CopyDatabaseExportTool = GUICtrlCreateCheckbox($TEXT_TAB_PREPARATION_CBX_CopyDatabaseExportTool, $TAB_GROUP_LEFT + 5, $TAB_GROUP_TOP + ($CBX_HEIGHT * $currentLine), $TAB_GROUP_WIDTH - 10, $CBX_HEIGHT)
	_ArrayAdd($PreparationCheckBoxes, $CBX_Preparation_CopyDatabaseExportTool)

	$currentLine += 1
	$CBX_Preparation_ChangeToRSAMode = GUICtrlCreateCheckbox($TEXT_TAB_PREPARATION_CBX_ChangeToRSAMode, $TAB_GROUP_LEFT + 5, $TAB_GROUP_TOP + ($CBX_HEIGHT * $currentLine), $TAB_GROUP_WIDTH - 10, $CBX_HEIGHT)
	_ArrayAdd($PreparationCheckBoxes, $CBX_Preparation_ChangeToRSAMode); do not iclude this and the next checkbx -> does not make sense...
	GUICtrlSetOnEvent($CBX_Preparation_ChangeToRSAMode, "SetChangeToRSACheckBox")

	$currentLine += 1
	$CBX_Preparation_ChangeToTsnDropMode = GUICtrlCreateCheckbox($TEXT_TAB_PREPARATION_CBX_ChangeToTsnDropMode, $TAB_GROUP_LEFT + 5, $TAB_GROUP_TOP + ($CBX_HEIGHT * $currentLine), $TAB_GROUP_WIDTH - 10, $CBX_HEIGHT)
	_ArrayAdd($PreparationCheckBoxes, $CBX_Preparation_ChangeToTsnDropMode)
	GUICtrlSetOnEvent($CBX_Preparation_ChangeToTsnDropMode, "SetChangeToTsnDropCheckBox")

	If Not ($CurrentUseICSimulator = $UseICSimulator[2]) Then
		$currentLine += 1
		$CBX_Preparation_StartICSimulator = GUICtrlCreateCheckbox($TEXT_TAB_PREPARATION_CBX_StartICSimulator, $TAB_GROUP_LEFT + 5, $TAB_GROUP_TOP + ($CBX_HEIGHT * $currentLine), $TAB_GROUP_WIDTH - 10, $CBX_HEIGHT)
		_ArrayAdd($PreparationCheckBoxes, $CBX_Preparation_StartICSimulator)
	EndIf

	$currentLine += 1
	$CBX_Preparation_StartHL7Simulator = GUICtrlCreateCheckbox($TEXT_TAB_PREPARATION_CBX_StartHL7Simulator, $TAB_GROUP_LEFT + 5, $TAB_GROUP_TOP + ($CBX_HEIGHT * $currentLine), $TAB_GROUP_WIDTH - 10, $CBX_HEIGHT)
	_ArrayAdd($PreparationCheckBoxes, $CBX_Preparation_StartHL7Simulator)

	$currentLine += 1
	$CBX_Preparation_StartIMSoftware = GUICtrlCreateCheckbox($TEXT_TAB_PREPARATION_CBX_StartIMSoftware, $TAB_GROUP_LEFT + 5, $TAB_GROUP_TOP + ($CBX_HEIGHT * $currentLine), $TAB_GROUP_WIDTH - 10, $CBX_HEIGHT)
	_ArrayAdd($PreparationCheckBoxes, $CBX_Preparation_StartIMSoftware)

	$currentLine += 1
	$CBX_Preparation_CopyAllMasterDatafiles = GUICtrlCreateCheckbox($TEXT_TAB_PREPARATION_CBX_CopyMasterDatafiles, $TAB_GROUP_LEFT + 5, $TAB_GROUP_TOP + ($CBX_HEIGHT * $currentLine), $TAB_GROUP_WIDTH - 10, $CBX_HEIGHT)
	_ArrayAdd($PreparationCheckBoxes, $CBX_Preparation_CopyAllMasterDatafiles)

	;~ Check all and start actions
	$CBX_Preparation_All = GUICtrlCreateCheckbox($TEXT_TAB_PREPARATION_CBX_CheckAll, $TAB_GROUP_LEFT + 5, $CBX_CHECKALL_TOP, $TAB_GROUP_WIDTH - 10, $CBX_HEIGHT)
	GUICtrlSetTip($CBX_PREPARATION_All, $TEXT_TAB_PREPARATION_CBX_CheckAll_ToolTip)
	_ArrayAdd($CheckAllCheckBoxes, $CBX_Preparation_All)
	GUICtrlSetOnEvent($CBX_Preparation_All, "SetPreparationCheckBoxState")

	Global $BTN_PreparationAction_Click = CreateButton($TEXT_BTN_StartAction, $BTN_ACTIONSSTART_LEFT, $BTN_ACTIONSSTART_TOP, $BTN_ACTIONSSTART_WIDTH)
	_ArrayAdd($ActionButtons, $BTN_PreparationAction_Click)
	GUICtrlSetOnEvent($BTN_PreparationAction_Click, "PreparationAction_Click")
EndIf