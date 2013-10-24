
Func CopyMasterDataFilesToTsnDrop($type, $fileList)
	If IsArray($fileList) Then
		Local $sourceAppFolder = GetMasterDataSourceFolder($type)
		For $i = 0 To UBound($fileList) - 1
			FileCopy($sourceAppFolder & $MasterDataFilePrefix & $fileList[$i] & ".xml", $TsnDropFolder, 9)
			Sleep(300)
		Next
	EndIf
EndFunc

Func GetMasterDataValuesFromXMLFile($masterFileCategory, $fileName)
	;Local $xmlFilePath = GetMasterDataSourceFolder($type) & $MasterDataFilePrefix & $FileName & ".xml"
	;Local $masterFileCategory = _XMLGetAttrib("/c302ApplicationParameter/ParameterDataFileHeader", "MasterFileCategory")
	Local $reagentContainerCodePattern = GetMasterDataRootElement($masterFileCategory)
	Local $containerSizeTypePattern = GetMasterDataRootElement($masterFileCategory)
	If $masterFileCategory = "RDTA" Then
		$reagentContainerCodePattern &= "/ProcessingParameter"
		$containerSizeTypePattern &= "/ProcessingParameter"
	EndIf
	$reagentContainerCodePattern &= "/ContainerParameter"
	$containerSizeTypePattern &= "/ContainerParameter/ContainerSet"
	Local $f = _XMLFileOpen($fileName)
	Local $reagentContainerCode = _XMLGetAttrib($reagentContainerCodePattern, "ReagentContainerCode")
	; remove leading 7
	If StringLeft($reagentContainerCode, 1) = "7" Then
		$reagentContainerCode = StringTrimLeft($reagentContainerCode, 1)
	EndIf
	Local $containerSizeType = _XMLGetAttrib($containerSizeTypePattern, "ContainerSizeType")
	;MsgBox(64, $fileName, $containerSizeTypePattern & " found: " & $containerSizeType)
	Local $lotNumber = Random(600000, 999999, 1)
	Local $serialNumber = Random(90000, 99999, 1)
	Local $kit[10]
	$kit[0] = "03" 					;CassetteLayoutVersion (not from master data file)
	$kit[1] = "1"					;CassetteSet (not from master data file)
	$kit[2] = $reagentContainerCode	;CassetteNumber
	$kit[3] = $lotNumber				;LotNumber (not from master data file)
	$kit[4] = "1104"					;ExpirationDate (not from master data file)
	$kit[5] = "00"					;DayOfManufacture (not from master data file)
	$kit[6] = $serialNumber			;SerialNumber (not from master data file)
	$kit[7] = "0"					;CassetteCategory (not from master data file)
	$kit[8] = $containerSizeType		;CassetteSizeType
	$kit[9] = "X"					;ICVC (not from master data file)
	Return $kit
EndFunc

Func GetMasterDataFileNames($type, $masterFileCategory)
	Local $masterDataFileNames
	; Search
	Local $folder = GetMasterDataSourceFolder($type)
	Local $FileList = _FileListToArray($folder, "*.xml", 1)
	;_ArrayDisplay($FileList)
	If IsArray($FileList) Then
		For $i = 1 To UBound($FileList) - 1
			_XMLFileOpen($folder & $FileList[$i])
			$t = GetMasterDataRootElement($masterFileCategory)
			Local $masterFileCategoryFound = _XMLGetAttrib($t & "/ParameterDataFileHeader", "MasterFileCategory")
			If $masterFileCategory = $masterFileCategoryFound Then
				If IsArray($masterDataFileNames) Then
					_ArrayAdd($masterDataFileNames, $folder & $FileList[$i])
				Else
					Local $foo[1]
					$masterDataFileNames = $foo
					$masterDataFileNames[0] = $folder & $FileList[$i]
				EndIf
			EndIf
		Next
	EndIf
	;_ArrayDisplay($masterDataFileNames)
	Return $masterDataFileNames
EndFunc

Func GetMasterDataRootElement($masterFileCategory)
	Local $rootElement = ""
	Switch $masterFileCategory
		Case "RDTA" ; Application
			$rootElement = "/c302ApplicationParameter"
		Case "RDAA" ; Diluent, Cleaner
			$rootElement = "/c302DiluentDetergentReagentParameter"
		Case "RDCP" ; Calibrator
			$rootElement = "/CalibratorParameter"
		Case "RDOP"	; ReagentCarryOver
			$rootElement = "/c302ReagentCarryoverEvasionParameter"
		Case "RDXP"	; SampleCarryOver
			$rootElement = "/c302SampleCarryoverEvasionParameter"
	EndSwitch
	Return $rootElement
EndFunc

Func GetMasterDataSourceFolder($type)
	Local $sourceAppFolder = $c302AppFolder
	Switch $type
		Case "CC"
			$sourceAppFolder = $c302AppFolder
		Case "ISE"
			$sourceAppFolder = $iseAppFolder
		Case "IC"
			$sourceAppFolder = $e201AppFolder
		Case "TsnDrop"
			$sourceAppFolder = $TsnDropFolder & "ManagedFileBase\cobas4000\"
		Case "Special"
			$sourceAppFolder = "SpecialMasterDataFiles\"
	EndSwitch
	Return $sourceAppFolder
EndFunc

Func GetKitsToLoad()
	Local $applicationKits = GetKitsToLoadByMasterFileCategory("RDTA")
	Local $detergentKits = GetKitsToLoadByMasterFileCategory("RDAA")
	_ArrayConcatenate($applicationKits, $detergentKits)
	Return $applicationKits
EndFunc

Func GetKitsToLoadByMasterFileCategory($masterFileCategory)
	Local $kitsToLoad
	Local $applicationFileList = GetMasterDataFileNames("TsnDrop", $masterFileCategory)
	For $i = 0 To UBound($applicationFileList) - 1
		Local $kit = GetMasterDataValuesFromXMLFile($masterFileCategory, $applicationFileList[$i])
		If IsArray($kitsToLoad) Then
			_ArrayAdd($kitsToLoad, $kit)
		Else
			Local $foo[1]
			$kitsToLoad = $foo
			$kitsToLoad[0] = $kit
		EndIf
	Next
	Return $kitsToLoad
EndFunc