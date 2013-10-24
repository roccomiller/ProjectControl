
;~ Declare all used checkboxes here to prevent warnings in the usage
#region Checkbox declaration
Global $CBX_Roundtrips_BasicGluc3Calibration
Global $CBX_Roundtrips_BasicGluc3SampleOrder

Global $CBX_Roundtrips_All
#endregion Checkbox declaration

Func SetRoundtripsCheckBoxState()
	SetCheckBoxState($RoundtripsCheckBoxes, GUICtrlRead($CBX_Roundtrips_All))
EndFunc

Func RoundtripsAction_Click()
	DisableAllControlls()
	Local $previousActionResult = 1
	If GUICtrlRead($CBX_Roundtrips_BasicGluc3Calibration) = $GUI_CHECKED And $previousActionResult = 1 Then
		$previousActionResult = BasicGluc3Calibration()
	EndIf
	If GUICtrlRead($CBX_Roundtrips_BasicGluc3SampleOrder) = $GUI_CHECKED And $previousActionResult = 1 Then
		$previousActionResult = BasicGluc3SampleOrder()
	EndIf
	EnableAllControlls()
EndFunc

Func BasicGluc3Calibration()
	Local $calibratorRackId = "1234"
	;~ copy master data files to tsndrop folder
	Local $FileList[8] = ["CAL_CFAS", "CAL_H2O", "RDAA_CLEAN", "RDAA_DILNACL", "RDTA_GLUC3_50", "RDOP_ReagCarryoEvParameterRoundtrip", "RDXP_SampleCarryEvParameterRoundtrip"]
	CopyMasterDataFilesToTsnDrop("CC", $FileList)
	SwitchToBrowser()
	Sleep(1000)
	;~ install the master datas
	GoTo_SearchAndInstall()
	Local $positions[1] = [0] ; Select all
 	SelectFromDataGridRightPanel($positions, False)
 	PressApplicationInstallButton()
	;~ CFAS and H2O calibrator rack assignment
 	GoTo_ManageCalibratorRackAssignment()
 	CalibratorRackAssignment($calibratorRackId, 1)
 	GoTo_ManageCalibratorRackAssignment()
	CalibratorRackAssignment($calibratorRackId, 2)
	;~ Insert calibrator rack with calbirator on pos 1 and 2
 	SwitchToSimulator()
 	Local $calibratorRackConfig[5] = [1, 1, 0, 0, 0]
 	InsertCalibratorRackOnSimulator($calibratorRackId, $calibratorRackConfig)
	;~ Get a list of kits to load, based on the installed masterdatas
	;~ If MasterDataCategory is 'RDTA' or 'RDAA' it is a test, diulent or clean with kit
	Local $kitsToLoad = GetKitsToLoad()
	For $i = 0 To UBound($kitsToLoad) - 1
		InsertCCKitOnSimulator($kitsToLoad[$i])
	Next
	;~ Order calibration
	SwitchToBrowser()
	GoTo_CalibrationStatus()
	Local $positions[1] = [0] ; Select all
	SelectFromDataGridRightPanel($positions, False)
	;~ Order
	PressCalibrationOrderButton()
	SampleStart()
	Sleep(30000)
	SampleStop()

EndFunc

Func BasicGluc3SampleOrder()

EndFunc