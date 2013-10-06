#region Menu
Local $fileMenu = GUICtrlCreateMenu("&File")
;$fileitem = GUICtrlCreateMenuItem("Open", $filemenu)
Local $settingsMenu = GUICtrlCreateMenu("&Settings")
Local $settingsItem = GUICtrlCreateMenuItem("Settings", $settingsMenu)
Local $aboutMenu = GUICtrlCreateMenu("&About")
Local $aboutItemAbout = GUICtrlCreateMenuItem("About", $aboutMenu)
Local $aboutItemHelp = GUICtrlCreateMenuItem("Help?", $aboutMenu)
#endregion Menu