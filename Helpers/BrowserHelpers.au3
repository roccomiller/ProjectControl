
Func SwitchToBrowser()
	WinActivate($IMUIWindowTitle)
	Sleep(1000)
	Local $size = WinGetClientSize($IMUIWindowTitle)
	;~ 2560 / 1388 -> not full
	;~ 2560 / 1440 -> full
	If IsArray($size) Then
		If Not ($size[1] = 1440) Then
			Send("{F11}")
			Sleep(5000)
		EndIf
	EndIf
EndFunc

#region GoTo Portlets
Func SampleStart()
	; press the start button
	MyMouseClickXY($BTN_Portlet_Start);Start
EndFunc

Func SampleStop()
	;~ press sample stop
	SwitchToBrowser()
	SampleStart()
	MyMouseClickXY($BTN_Portlet_SampleStop); Sample stop
EndFunc

Func PressApplicationInstallButton($sleep = 6000)
	MyMouseClickXY($BTN_Administration_SearchAndInstallElibraryPackages_Install, $sleep)
EndFunc

Func PressCalibrationOrderButton($sleep = 5000)
	MyMouseClickXY($BTN_Routine_CalibrationStatus_Order, $sleep);Order
EndFunc
#endregion GoTo Portlets

#region GoTo Routine

Func GoTo_Tab_Routine()
	MyMouseClickXY($BTN_Routine_Main_Tab); Routine
	;MyMouseClick(99, $UICoordinate_Tab_Y); Routine
EndFunc

Func GoTo_Breadcrumb_Routine()
	GoTo_Tab_Routine()
	MyMouseClickXY($BTN_Routine_Breadcrumb_Routine); Routine
	;MyMouseClick($UICoordinate_Breadcrumb1_X, $UICoordinate_Breadcrumb_Y); Routine
EndFunc

Func GoTo_ListOfSampleOrders()
		GoTo_Breadcrumb_Routine()
		MyMouseClickXY($BTN_Routine_ListOfSampleOrders, 1000)
		;MyMouseClick($UICoordinate_LeftPanel_DrilldownBtn_X, 300, 1000); List of sample orders
EndFunc

Func GoTo_ListOfSampleResults()
	GoTo_Breadcrumb_Routine()
	MyMouseClickXY($BTN_Routine_ListOfsampleResults, 700)
	;MyMouseClick($UICoordinate_LeftPanel_DrilldownBtn_X, 350, 700); List of sample results
EndFunc

Func GoTo_CalibrationStatus()
	GoTo_Breadcrumb_Routine()
	MyMouseClickXY($BTN_Routine_CalibrationStatus, 2000)
	;MyMouseClick($UICoordinate_LeftPanel_DrilldownBtn_X, 455, 2000); Calibration status
EndFunc

Func GoTo_ListOfCalibrationResults()
	GoTo_Breadcrumb_Routine()
	MyMouseClickXY($BTN_Routine_ListOfCalibrationResults, 700)
	;MyMouseClick($UICoordinate_LeftPanel_DrilldownBtn_X, 505, 700); List of Calibration results
EndFunc

#endregion GoTo Routine

#region GoTo Monitoring

Func GoTo_Tab_Monitoring()
	MyMouseClickXY($BTN_Monitoring_Main_Tab); Monitoring
EndFunc

Func GoTo_Breadcrumb_Monitoring()
	GoTo_Tab_Monitoring()
	MyMouseClick($UICoordinate_Breadcrumb1_X, $UICoordinate_Breadcrumb_Y); Monitoring
EndFunc

Func GoTo_ManageCalibratorRackAssignment()
	GoTo_Breadcrumb_Monitoring()
	MyMouseClick($UICoordinate_LeftPanel_DrilldownBtn_X, 460); Manage calibrator rack assignment
EndFunc

Func GoTo_Messages()
	GoTo_Breadcrumb_Monitoring()
	MyMouseClick($UICoordinate_LeftPanel_DrilldownBtn_X, 618); Messages
EndFunc

Func GoTo_ProblemReport()
	GoTo_Messages()
	MyMouseClick($UICoordinate_RightPanel_Drilldown_X, 368) ; Problem report
EndFunc

#endregion GoTo Monitoring

#region GoTo Administration

Func GoTo_Tab_Administation()
	MyMouseClick(503, $UICoordinate_Tab_Y); Administration
EndFunc

Func GoTo_Breadcrumb_Administation()
	GoTo_Tab_Administation()
	MyMouseClick($UICoordinate_Breadcrumb1_X, $UICoordinate_Breadcrumb_Y); Administration
EndFunc

Func GoTo_ELibraryManagement()
	GoTo_Breadcrumb_Administation()
	MyMouseClick($UICoordinate_LeftPanel_DrilldownBtn_X, 300); e-library management
EndFunc

Func GoTo_SearchAndInstall()
	GoTo_ELibraryManagement()
	MyMouseClick($UICoordinate_RightPanel_Drilldown_X, 350, 3000); Search and install
EndFunc

#endregion GoTo Administration

Func CalibratorRackAssignment($RackId, $RackPos, $SortByName = True)
	If $SortByName Then
		MyMouseClick(1457, $UICoordinate_RightPanel_DataGrid_Header_Y)
	EndIf
	Local $rPos[1] = [$RackPos]
	SelectFromDataGridRightPanel($rPos, False)
	MyMouseClick(2495, 338 + (($RackPos - 1) * 44)); Drilldown
	MyMouseClick(2490, 1338);Edit
	MyMouseClick(1585, 468);Activate input
	Send($RackId);Write into the field
	Sleep(500)
	MyMouseClick(2510, 469);Select dropdown
	MyMouseClick(2290, 510 + (($RackPos - 1) * 42));Select rack pos
	MyMouseClick(2490, 1338);Save
EndFunc

Func SelectFromDataGridRightPanel($Positions, $SortByName = True)
	If IsArray($Positions) Then
		If $SortByName Then
			MyMouseClick(1594, $UICoordinate_RightPanel_DataGrid_Header_Y, 2000); Sort by Name
		EndIf
		For $i = 0 To UBound($Positions) - 1
			MyMouseClick($UICoordinate_RightPanel_DataGrid_CheckPos_X, $UICoordinate_RightPanel_DataGrid_Header_Y + ($Positions[$i] * 43), 250)
		Next
	EndIf
EndFunc