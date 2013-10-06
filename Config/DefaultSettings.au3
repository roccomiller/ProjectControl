;~

Global Const $SettingsFileName = @ScriptDir & "\settings.xml"
Global Const $LogFileName = @ScriptDir & "\log.txt"
Global $Environments[2] = ["Development", "ControlUnit"]
Global $CurrentEnvironment = $Environments[0]
;~ C4000 folder structure settings
Global $CurrentBasePath = "C:\Dev\C4k\IM\Dev\" ; Chaneable in settings.
Global Const $LogFolder = $CurrentBasePath & "Units\bin\Debug\Log\"
Global Const $TsnDropFolder = $CurrentBasePath & "Units\bin\Debug\TsnDrop\"
Global Const $c302AppFolder = $CurrentBasePath & "Environment\MasterData\RT\c302\"
Global Const $e201AppFolder = $CurrentBasePath & "Environment\MasterData\RT\e201\"
Global Const $iseAppFolder = $CurrentBasePath & "Environment\MasterData\RT\ISE\"
Global Const $MasterDataFilePrefix = "cobas4000_"

;~ C4000 process settings
Global $IMProcesses_ProcessManager = "ProcessManager.exe"
Global $IMProcesses_Scheduler = "Scheduler.exe"
Global $IMProcesses_Calculator = "Calculator.exe"
Global $IMProcesses_UIServer = "UIServer.exe"
Global $IMProcesses_ResourceManager = "ResourceManager.exe"
Global $IMProcesses_InstrumentAccess = "InstrumentAccess.exe"

;~ Process names
Global Const $ICSimulatorProcessName = "ICSimulator.exe"
Global $IMProcesses[9]
$IMProcesses[0] = "Roche.C4000.ProcessManagement.ProcessManager.exe"
$IMProcesses[1] = "Roche.C4000.UI.Server.Main.exe"
$IMProcesses[2] = "Roche.C4000.UI.Client.UIHostProcess.exe"
$IMProcesses[3] = "Roche.C4000.Scheduling.Scheduler.exe"
$IMProcesses[4] = "Roche.C4000.ResourceManagement.ResourceManager.exe"
$IMProcesses[5] = "Roche.C4000.ProcessManagement.CommonServiceHost.exe"
$IMProcesses[6] = "Roche.C4000.InstrumentAccess.ServiceHost.exe"
$IMProcesses[7] = "Roche.C4000.DmIm.DataManagerClient.exe"
$IMProcesses[8] = "Roche.C4000.Calculator.exe"

;~ External tool settings
Global Const $AppCMDPath = "%systemroot%\system32\inetsrv\appcmd.exe"
Global Const $ExternalToolPath_Tfs = "C:\Program Files (x86)\Microsoft Visual Studio 11.0\Common7\IDE\TF.exe"
Global Const $msBuildPath = "C:\Windows\Microsoft.NET\Framework\v4.0.30319\msbuild.exe"
Global Const $ExternalToolPath_HL7InstallPath = "C:\Program Files (x86)\Host_Tools_76\"
Global Const $HL7ProcessName = "hl7sim.exe"
Global Const $GetDependenciesPath = $CurrentBasePath & "Environment\RocheBuildTools\Roche.Build.Tools.GetDependenciesConsole.exe"

#region UI settings
Global Const $MAINGUI_WIDTH = 800
Global Const $MAINGUI_HEIGHT = 700
Global Const $MAINGUI_STATUSBAR_PART_1 = 22
Global Const $MAINGUI_STATUSBAR_PART_2 = 100
Global Const $MAINGUI_STATUSBAR_PART_3 = $MAINGUI_WIDTH - $MAINGUI_STATUSBAR_PART_1 - $MAINGUI_STATUSBAR_PART_2
Global Const $STATUSBAR_PARTS[3] = [$MAINGUI_STATUSBAR_PART_1, $MAINGUI_STATUSBAR_PART_2, $MAINGUI_STATUSBAR_PART_3]

Global Const $TAB_GROUP_WIDTH = 250
Global Const $TAB_GROUP_HEIGHT = 300
Global Const $TAB_GROUP_TOP = 30
Global Const $TAB_GROUP_LEFT = 5


Global Const $BTN_HEIGHT = 20
Global Const $BTN_ACTIONSSTART_WIDTH = 100
;Global Const $BTN_ACTIONSSTART_HEIGHT = 300
Global Const $BTN_ACTIONSSTART_TOP = $TAB_GROUP_TOP + $TAB_GROUP_HEIGHT - $BTN_HEIGHT - 5
Global Const $BTN_ACTIONSSTART_LEFT = $TAB_GROUP_LEFT + 5

Global Const $CBX_HEIGHT = 17
Global Const $CBX_CHECKALL_TOP = $BTN_ACTIONSSTART_TOP - $BTN_HEIGHT

Global Const $ICON_HELP_HEIGHT = 16

#endregion UI settings

#region DON'T CHANGE THIS VALUES IF YOU DON'T KNOW WHAT YOU DO!
Global $hStatusBar, $SystemStatus, $OldSystemStatus, $ScriptPaused
Global $ResourceFile = @ScriptFullPath
Global $TestCheckBoxes[1], $SourceControlCheckBoxes[1], $PreparationCheckBoxes[1], $RoundtripsCheckBoxes[1], $BackupCheckBoxes[1], $CheckAllCheckBoxes[1]
Global $ActionButtons[1]
Global $includeTest = True
Global $includeSourcControl = True
Global $includePreparation = True
Global $includeRoundtrips = True
Global $includeBackup = True
#endregion