#include <_XMLDomWrapper.au3>
#include <Array.au3>
#include <File.au3>

Global Const $XmlFileName = "test.xml"
$file = _XMLFileOpen($XmlFileName)
;Local $Id = _XMLGetElement()
;Local $Id = _XMLGetAttrib("/ArrayOfLogEventDefinition/LogEventDefinition/LogEventDefinitionId")
$count = _XMLGetNodeCount("/ArrayOfLogEventDefinition/LogEventDefinition/EventCode")
$aIds = _XMLGetValue("/ArrayOfLogEventDefinition/LogEventDefinition/EventCode")
_ArraySort($aIds)
$aUniqueIds = _ArrayUnique($aIds)
$Diff = _Diff($aUniqueIds, $aIds)
_ArrayDisplay($Diff)
;_ArrayDisplay($aUniqueIds)




;Local $Ids = _XMLGetAllAttrib("/ArrayOfLogEventDefinition/LogEventDefinition/LogEventDefinitionId", $a, $t)
;MsgBox(0, "test", $first)
;_ArrayDisplay($first)


;=================================================
; Function Name:   _Diff($Set1, $Set2 [, $GetAll=0 [, $Delim=Default]])
; Description::    Find values in $Set1 that do not occur in $Set2
; Parameter(s):    $Set1    set 1 (1D-array or delimited string)
;                  $Set2    set 2 (1D-array or delimited string)
;      optional:   $GetAll  0 - only one occurence of every difference are shown (Default)
;                           1 - all differences are shown, allowing duplicates
;      optional:   $Delim   Delimiter for strings (Default use the separator character set by Opt("GUIDataSeparatorChar") )
; Return Value(s): Succes   1D-array of values from $Set1 that do not occur in $Set2
;                  Failure  -1  @error  set, that was given as array, isn't 1D-array
; Note:            Comparison is case-sensitive! - i.e. Number 9 is different to string '9'!
; Author(s):       BugFix (bugfix@autoit.de) Modified by ParoXsitiC for Faster _Diff (Formally _GetIntersection)
;=================================================
Func _Diff(ByRef $Set1, ByRef $Set2, $GetAll = 0, $Delim = Default)
    Local $o1 = ObjCreate("System.Collections.ArrayList")
    Local $o2 = ObjCreate("System.Collections.ArrayList")
    Local $oUnion = ObjCreate("System.Collections.ArrayList")
    Local $oDiff1 = ObjCreate("System.Collections.ArrayList")
    Local $oDiff2 = ObjCreate("System.Collections.ArrayList")
    Local $tmp, $i
    If $GetAll <> 1 Then $GetAll = 0
    If $Delim = Default Then $Delim = Opt("GUIDataSeparatorChar")
    If Not IsArray($Set1) Then
        If Not StringInStr($Set1, $Delim) Then
            $o1.Add($Set1)
        Else
            $tmp = StringSplit($Set1, $Delim, 1)
            For $i = 1 To UBound($tmp) - 1
                $o1.Add($tmp[$i])
            Next
        EndIf
    Else
        If UBound($Set1, 0) > 1 Then Return SetError(1, 0, -1)
        For $i = 0 To UBound($Set1) - 1
            $o1.Add($Set1[$i])
        Next
    EndIf
    If Not IsArray($Set2) Then
        If Not StringInStr($Set2, $Delim) Then
            $o2.Add($Set2)
        Else
            $tmp = StringSplit($Set2, $Delim, 1)
            For $i = 1 To UBound($tmp) - 1
                $o2.Add($tmp[$i])
            Next
        EndIf
    Else
        If UBound($Set2, 0) > 1 Then Return SetError(1, 0, -1)
        For $i = 0 To UBound($Set2) - 1
            $o2.Add($Set2[$i])
        Next
    EndIf
    For $tmp In $o1
        If $o2.Contains($tmp) And Not $oUnion.Contains($tmp) Then $oUnion.Add($tmp)
    Next
    For $tmp In $o1
        If $GetAll Then
            If Not $oUnion.Contains($tmp) Then $oDiff1.Add($tmp)
        Else
            If Not $oUnion.Contains($tmp) And Not $oDiff1.Contains($tmp) Then $oDiff1.Add($tmp)
        EndIf
    Next


    If $oDiff1.Count <= 0 Then Return 0

    Local $aOut[$oDiff1.Count]
    $i = 0
    For $tmp In $oDiff1
        $aOut[$i] = $tmp
        $i += 1
    Next
    Return $aOut
EndFunc   ;==>_Diff