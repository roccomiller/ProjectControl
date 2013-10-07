#region Menu
Global $fileMenu = GUICtrlCreateMenu($TXT_MENU_File)
Global $fileMenu_itemOpenLog = GUICtrlCreateMenuItem($TXT_MENU_File_OpenLog, $filemenu)
GUICtrlSetOnEvent($fileMenu_itemOpenLog, "OpenLogFile")
Global $fileMenu_itemClearLog = GUICtrlCreateMenuItem($TXT_MENU_File_ClearLog, $filemenu)
GUICtrlSetOnEvent($fileMenu_itemClearLog, "ClearLogFile")

Global $settingsMenu = GUICtrlCreateMenu($TXT_MENU_Settings)
Global $settingsMenu_itemSettings = GUICtrlCreateMenuItem($TXT_MENU_Settings, $settingsMenu)
GUICtrlSetOnEvent($settingsMenu_itemSettings, "ShowSettingsPopup")

Global $aboutMenu = GUICtrlCreateMenu($TXT_MENU_About)
Global $aboutMenu_itemAbout = GUICtrlCreateMenuItem($TXT_MENU_About, $aboutMenu)
GUICtrlSetOnEvent($aboutMenu_itemAbout, "ShowAboutPopup")
Global $aboutMenu_itemHelp = GUICtrlCreateMenuItem($TXT_MENU_Help, $aboutMenu)
GUICtrlSetOnEvent($aboutMenu_itemHelp, "ShowHelpFile")
#endregion Menu