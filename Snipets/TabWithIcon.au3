
GUICtrlCreateTab("with icon", 10, 200)

$hTabItem1 = GUICtrlCreateTabItem("My first item")
$hTabItem2 = GUICtrlCreateTabItem("My second item")
GUICtrlSetImage($hTabItem1, $ResourceFile, -7)


GUICtrlCreateTabItem("")