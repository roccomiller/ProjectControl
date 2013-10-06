

;$image = _GIDPLUS_ImageLoadFromFile("ToolTip.png")
;$toolTipImage = _GDIPLUS_GraphicsCreateFromHWND()

Global $hToolTipImage = _GDIPlus_ImageLoadFromFile("ToolTip.png")
Global $hGraphic = _GDIPLUS_GraphicsCreateFromHWND($hMainGUI)
GUIRegisterMsg($WM_PAINT, "MY_WM_PAINT")
