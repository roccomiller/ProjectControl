
$GroupLeft = 20
$GroupTop = 20
$GroupWidth = 200
$groupHeight = 300

$hGroup = GUICtrlCreateGroup("Tool tip test", $GroupLeft, $GroupTop, $GroupWidth, $groupHeight)
$iconWidth = 16
$hHelpIcon = GUICtrlCreateIcon($ResourceFile, -6, $GroupWidth + $GroupLeft - $iconWidth - 2, $GroupTop + 8, $iconWidth, $iconWidth)
; Control tool tip on hover
GUICtrlSetTip($hHelpIcon, "hier werden sie geholfen...")

; Global tool tip always visible
;ToolTip("hier werden sie geholfen...", 0, 0); Global tool tip in the upper left corner of the screen

