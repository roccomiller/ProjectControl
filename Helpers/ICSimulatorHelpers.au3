
Func SwitchToSimulator()
	WinActivate($ICSimulatorProcess[2])
	WinMove($ICSimulatorProcess[2], "", 0, 0) ; move the window to the upper left corner...
	Sleep(1000)
EndFunc

Func InsertCalibratorRackOnSimulator($RackId, $rackConfig)
	; Insert calibrator rack
	MyMouseClick(705, 731);Insert Rack
	MyMouseClick(830, 686);Select Calibrator Rack
	MyMouseClick(860, 755);Activate input
	Send($RackId)
	Sleep(500)
	If IsArray($rackConfig) Then
		For $i = 0 To UBound($rackConfig) - 1
			If $rackConfig[$i] = 1 Then
				MyMouseClick(964 - ($i * 52), 835);Insert tube
			EndIf
		Next
	EndIf
	MyMouseClick(988, 909, 2000);Insert rack
EndFunc

Func InsertCCKitOnSimulator($kit)
	MyMouseClick(247, 674);open the cc drawer
	MyMouseClick(101, 735);Pos 60
	;MyMouseClick(162, 816);Insert other kit
	MyMouseClick(177, 863);CC Kit
;~ 	Local $Kit[10]
;~ 	Switch $KitType
;~ 		Case "NACL"
;~ 			Local $Kit = GetMasterDataValuesFromXMLFile("Special", "RDTA_DILNACL")
;~ 		Case "CLEAN"
;~ 			Local $Kit = GetMasterDataValuesFromXMLFile("Special", "RDTA_CLEAN")
;~ 		Case "GLUC3"
;~ 			Local $Kit = GetMasterDataValuesFromXMLFile("Special", "RDTA_GLUC3_50")
;~ 		Case "GLUC3_50_Both"
;~ 			Local $Kit = GetMasterDataValuesFromXMLFile("Special", "RDTA_GLUC3_50_Both_8718")
;~ 		Case "GLUC3_50_None"
;~ 			Local $Kit = GetMasterDataValuesFromXMLFile("Special", "RDTA_GLUC3_50_None_8719")
;~ 		Case "GLUC3_50_Specific"
;~ 			Local $Kit = GetMasterDataValuesFromXMLFile("Special", "RDTA_GLUC3_50_Specific_8717")
;~ 		Call "GLUC3_50_Unspecific"
;~ 			Local $Kit = GetMasterDataValuesFromXMLFile("Special", "RDTA_GLUC3_50_Unspecific_8720")
;~ 	EndSwitch
	For $i = 0 To UBound($kit) - 1
		MyMouseDoubleClick(338, 927 + ($i * 38), 100); Activate input field
		Send($kit[$i])
	Next
	MyMouseClick(489, 1298);insert
	MyMouseClick(247, 674, 1000);close the cc drawer
EndFunc