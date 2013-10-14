#region Menu
Global Const $TXT_MENU_File = "File"
Global Const $TXT_MENU_File_OpenLog = "Open log file"
Global Const $TXT_MENU_File_ClearLog = "Cleare log file"

Global Const $TXT_MENU_Settings = "Settings"
Global Const $TXT_MENU_About = "About"
Global Const $TXT_MENU_Help = "Help?" & @TAB & "F1"
#endregion Menu

#region PopUps
Global Const $TXT_POPUP_SETTINGS_Settings = "Settings"
Global Const $TXT_POPUP_SETTINGS_DatabaseLocation = "Database location: "
Global Const $TXT_POPUP_SETTINGS_DatabaseLocation_Help = _
$DatabaseLocations[0] & ": " & @TAB & "Use a local installation of oracle." _
& @CRLF & $DatabaseLocations[1] & ": " & @TAB & "Use the remote server (192.168.1.100) installation of oracle server."

Global Const $TXT_POPUP_SETTINGS_UserPostfix = "User posfix: "
Global Const $TXT_POPUP_SETTINGS_UserPostfix_Help = "This is the postfix used for your database schema."

Global Const $TXT_POPUP_SETTINGS_UseICSimulator = "Use IC Simulator: "
Global Const $TXT_POPUP_SETTINGS_UseICSimulator_Help = _
$UseICSimulator[0] & ": " & @TAB & @TAB & "Perform simulator actions (eg. load rack or kit) without asking." _
& @CRLF & $UseICSimulator[1] & ": " & @TAB & "Perform simulator actions, but ask before it starts." _
& @CRLF & $UseICSimulator[2] & ": " & @TAB & "Do not perform simulator actions, but wait (and tell user) if one is needed. This is used for the real instrument."

Global Const $TXT_POPUP_SETTINGS_Environment = "Environment: "
Global Const $TXT_POPUP_SETTINGS_Environment_Help = _
$Environments[0] & ": " & @TAB & "If selected, you can use all the functions (Source control etc.)" _
& @CRLF & $Environments[1] & ": " & @TAB & "If selected, some functions are disabled or hidden because they do not make sense on the control unit."


Global Const $TXT_POPUP_SETTINGS_BasePath = "Base path: "
Global Const $TXT_POPUP_SETTINGS_BasePath_Help = "This is the base path to your branch. Usually the parent folder of the 'Units' Folder where your Roche.c4000.sln is located."
Global Const $TXT_POPUP_SETTINGS_RestartMessageTitle = "Please restart!"
Global Const $TXT_POPUP_SETTINGS_RestartMessage = "The changes you made will take effect after you restart the app."
Global Const $TXT_POPUP_SETTINGS_SelectBasePath = "Choose..."
Global Const $TXT_POPUP_SETTINGS_SelectBasePath_Message = "Select the base folder of your branch."

Global Const $TXT_POPUP_ABOUT_About = "About"
#endregion PopUps

#region Tabs

#region Test Tab
Global Const $TEXT_TAB_TEST_Tab = "Test"
Global Const $TEXT_TAB_TEST_GROUP_Test = "Test actions"
Global Const $TEXT_TAB_TEST_CBX_Test = "Test"
Global Const $TEXT_TAB_TEST_CBX_CheckAll = "Check all"
Global Const $TEXT_TAB_TEST_CBX_CheckAll_ToolTip = "This will check / uncheck all the checkboxes in this group."
#endregion Test Tab

#region Source Control Tab
Global Const $TEXT_TAB_SOURCECONTROL_Tab = "Source control"
Global Const $TEXT_TAB_SOURCECONTROL_GROUP_SourceControl = "Source control actions"
Global Const $TEXT_TAB_SOURCECONTROL_CBX_Dummy = "Dummy checkbox"
Global Const $TEXT_TAB_SOURCECONTROL_CBX_UndoAllPendingChanges = "Undo all pending changes"
Global Const $TEXT_TAB_SOURCECONTROL_CBX_RemoveDev = "Remove Dev"
Global Const $TEXT_TAB_SOURCECONTROL_CBX_GetLatest = "Get latest version"
Global Const $TEXT_TAB_SOURCECONTROL_CBX_GetTheDependecies = "Get the dependecies"
Global Const $TEXT_TAB_SOURCECONTROL_CBX_BuildIMSolutionDebug = "Build IM solution (Debug)"
Global Const $TEXT_TAB_SOURCECONTROL_CBX_BuildIMSolutionDebugNoTests = "Build IM solution (DebugNoTests)"
Global Const $TEXT_TAB_SOURCECONTROL_CBX_RemoveComitServices = "Redeploy Comit services"
Global Const $TEXT_TAB_SOURCECONTROL_CBX_AdaptTheConfigFiles = "Adapt the config files"
Global Const $TEXT_TAB_SOURCECONTROL_CBX_CheckAll = "Check all"
Global Const $TEXT_TAB_SOURCECONTROL_CBX_CheckAll_ToolTip = "This will check / uncheck all the checkboxes in this group."

Global Const $TEXT_TAB_SOURCECONTROL_GROUP_CheckAndTestIt = "Check and test it"
Global Const $TEXT_TAB_SOURCECONTROL_CBX_RunFxCopAll = "Run FxCop on solution"
Global Const $TEXT_TAB_SOURCECONTROL_CBX_RunFxCopSelective = "Run FxCop for project: "
Global Const $TEXT_TAB_SOURCECONTROL_CBX_CheckAndTestIt_CheckAll = "Check all"
Global Const $TEXT_TAB_SOURCECONTROL_CBX_CheckAndTestIt_CheckAll_ToolTip = "This will check / uncheck all the checkboxes in this group."
#endregion Source Control Tab

#region Preparation Tab
Global Const $TEXT_TAB_PREPARATION_Tab = "Preparation"
Global Const $TEXT_TAB_PREPARATION_GROUP_Preparation = "Preparation actions"
Global Const $TEXT_TAB_PREPARATION_CBX_Dummy = "Dummy checkbox"
Global Const $TEXT_TAB_PREPARATION_CBX_RemoveOldMasterData = "Remove old MasterData (inc. RSA)"
Global Const $TEXT_TAB_PREPARATION_CBX_RemoveOldLogfiles = "Remove old Logfiles"
Global Const $TEXT_TAB_PREPARATION_CBX_CleanDatabase = "Clean Database"
Global Const $TEXT_TAB_PREPARATION_CBX_CopyDatabaseExportTool = "Copy Database Export Tool"
Global Const $TEXT_TAB_PREPARATION_CBX_ChangeToRSAMode = "Change to RSA mode"
Global Const $TEXT_TAB_PREPARATION_CBX_ChangeToTsnDropMode = "Change to TsnDrop mode"
Global Const $TEXT_TAB_PREPARATION_CBX_StartICSimulator = "Start IC Simulator"
Global Const $TEXT_TAB_PREPARATION_CBX_StartHL7Simulator = "Start HL7 Simulator"
Global Const $TEXT_TAB_PREPARATION_CBX_StartIMSoftware = "Start IM software"
Global Const $TEXT_TAB_PREPARATION_CBX_CopyMasterDatafiles = "Copy All MasterData files"
Global Const $TEXT_TAB_PREPARATION_CBX_CheckAll = "Check all"
Global Const $TEXT_TAB_PREPARATION_CBX_CheckAll_ToolTip = "This will check / uncheck all the checkboxes in this group."
#endregion Preparation Tab

#region Roundtrips Tab
Global Const $TEXT_TAB_ROUNDTRIPS_Tab = "Roundtrips"
Global Const $TEXT_TAB_ROUNDTRIPS_GROUP_Roundtrips = "Roundtrips actions"
Global Const $TEXT_TAB_ROUNDTRIPS_CBX_Dummy = "Dummy checkbox"
Global Const $TEXT_TAB_ROUNDTRIPS_CBX_CheckAll = "Check all"
Global Const $TEXT_TAB_ROUNDTRIPS_CBX_CheckAll_ToolTip = "This will check / uncheck all the checkboxes in this group."
#endregion Roundtrips Tab

#region Backup Tab
Global Const $TEXT_TAB_BACKUP_Tab = "Backup"
Global Const $TEXT_TAB_BACKUP_GROUP_Backup = "Backup actions"
Global Const $TEXT_TAB_BACKUP_CBX_Dummy = "Dummy checkbox"
Global Const $TEXT_TAB_BACKUP_CBX_CheckAll = "Check all"
Global Const $TEXT_TAB_BACKUP_CBX_CheckAll_ToolTip = "This will check / uncheck all the checkboxes in this group."
#endregion Backup Tab

#endregion Tabs

#region Buttons
Global Const $TEXT_BTN_StartAction = "Start"
Global Const $TEXT_BTN_Save = "Save"
Global Const $TEXT_BTN_Cancel = "Cancel"
Global Const $TEXT_BTN_Default = "Default"
#endregion Buttons

Global Const $TEXT_NOTIMPLEMETEDYET = "Not implemented yet..."