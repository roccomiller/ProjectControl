

$GroupLeft = 20
$GroupTop = 20
$GroupWidth = 200
$groupHeight = 300
CreateGroup("Tool tip test", $GroupLeft, $GroupTop, $GroupWidth, $groupHeight)

CreateButton("Button text 1", 15, 40, 150, 0, -7)
CreateButton("Button text 2HMMM", 15, 80, 150, 24, -6)

CreateButton("Button text 3", 15, 120, 0, 0, -8)

TestButton()

GUICtrlCreateGroup("", -99, -99, 1, 1)