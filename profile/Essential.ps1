# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#    Essential profile:
#
#   This is the default profile used by boxstarter
#   What this script does is:
#     - Protect your privacy (see Privacy settings)
#     - Change user interface preferences (see UI preferences)
#     - Disable P2P Windows update (see Windows update)
#     - Remove default apps already installed (see Default Windows apps)
#     - Change default options (see Default options)
#     - Install few apps from chocolatey gallery (see DefaultInstall apps)
#       - Powershell
#       - Google Chrome
#       - 7zip
#       - Adobe reader
#       - Paint.net
#       - Notepad ++
#       - Vlc
#
#   You have the possibility to disable each part of this script just by adding
#   an option when calling the boxstarter.ps1
#   For example:
#     - Don't want to change the privacy setting: 'Boxstarter::Privacy-Settings=false'
#     - Don't want to remove skype: 'Boxstarter::Essential::Remove::Microsoft.SkypeApp=false'
#     - Want to remove the calculator: 'Boxstarter::Essential::Remove::Microsoft.WindowsCalculator=true'
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -


#--- [Import] ---------------------------------------------------------------------------------------------------------
Import-Function -Path "$sRoot/helpers/install/Remove-WindowsApp.ps1"
Import-Function -Path "$sRoot/helpers/install/Remove-OneDrive.ps1"
#----------------------------------------------------------------------------------------------------------------------


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#    Privacy settings
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if(Confirm-Install 'Boxstarter::Privacy-Settings')
{
    # Let apps use my advertising ID: Disable
    Set-Registry -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo' -Name 'Enabled' -Type 'DWord' -Value 0
    # SmartScreen Filter for Store Apps: Disable
    Set-Registry -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost' -Name 'EnableWebContentEvaluation' -Type 'DWord' -Value 0
    # WiFi Sense: HotSpot Sharing: Disable
    Set-Registry -Path 'HKLM:\Software\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting' -Name 'value' -Type 'DWord' -Value 0
    # WiFi Sense: Shared HotSpot Auto-Connect: Disable
    Set-Registry -Path 'HKLM:\Software\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots' -Name 'value' -Type 'DWord' -Value 0
    # Disable Telemetry (requires a reboot to take effect)
    # Set-Registry -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection' -Name 'AllowTelemetry' -Type 'DWord' -Value 0
    # Get-Service DiagTrack,Dmwappushservice | Stop-Service | Set-Service -StartupType Disabled
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#    UI preferences
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if(Confirm-Install 'Boxstarter::UI-Preferences')
{
    # Set-WindowsExplorerOptions parameters can be found in https://github.com/chocolatey/boxstarter/blob/master/Boxstarter.WinConfig/Set-WindowsExplorerOptions.ps1

    # Disables the Quick Access location and shows Computer view when opening Windows Explorer
    Set-WindowsExplorerOptions -DisableOpenFileExplorerToQuickAccess
    # Windows Explorer will expand the navigation pane to the current open folder
    Set-WindowsExplorerOptions -EnableExpandToOpenFolder
    # Disables the showing of recently used files in the Quick Access pane
    Set-WindowsExplorerOptions -DisableShowRecentFilesInQuickAccess
    # Disables the showing of frequently used directories in the Quick Access
    Set-WindowsExplorerOptions -DisableShowFrequentFoldersInQuickAccess
    # Taskbar where window is open for multi-monitor
    Set-Registry -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'MMTaskbarEnabled' -Value 1
    Set-Registry -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'MMTaskbarMode' -Value 2
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#    Windows update
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if(Confirm-Install 'Boxstarter::Windows-Update')
{
    # Disable P2P Update downloads outside of local network
    Set-Registry -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config' -Name 'DODownloadMode' -Type 'DWord' -Value 1
    Set-Registry -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization' -Name 'SystemSettingsDownloadMode' -Type 'DWord' -Value 3
}


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#    Default Windows apps
#
# Get-AppxPackage -AllUsers | Select Name, PackageFullName | Sort Name
# Get-AppxProvisionedPackage -Online | Select DisplayName, PackageName | Sort DisplayName
#
# https://docs.microsoft.com/en-us/windows/application-management/remove-provisioned-apps-during-update
# https://gist.github.com/alirobe/7f3b34ad89a159e6daa1
# https://github.com/Disassembler0/Win10-Initial-Setup-Script/blob/master/Win10.ps1
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Set-DefaultOption 'Boxstarter::Essential::Remove-Apps'                                     'true'

Set-DefaultOption 'Boxstarter::Essential::Remove::Microsoft.3DBuilder'                     'true'
Set-DefaultOption 'Boxstarter::Essential::Remove::Microsoft.Appconnector'                  'false'
Set-DefaultOption 'Boxstarter::Essential::Remove::Microsoft.BingFinance'                   'true'
Set-DefaultOption 'Boxstarter::Essential::Remove::Microsoft.BingFoodAndDrink'              'true'
Set-DefaultOption 'Boxstarter::Essential::Remove::Microsoft.BingHealthAndFitness'          'true'
Set-DefaultOption 'Boxstarter::Essential::Remove::Microsoft.BingNews'                      'true'
Set-DefaultOption 'Boxstarter::Essential::Remove::Microsoft.BingSports'                    'true'
Set-DefaultOption 'Boxstarter::Essential::Remove::Microsoft.BingTravel'                    'true'
Set-DefaultOption 'Boxstarter::Essential::Remove::Microsoft.BingWeather'                   'true'
Set-DefaultOption 'Boxstarter::Essential::Remove::Microsoft.CommsPhone'                    'true'
Set-DefaultOption 'Boxstarter::Essential::Remove::Microsoft.ConnectivityStore'             'true'
Set-DefaultOption 'Boxstarter::Essential::Remove::Microsoft.DesktopAppInstaller'           'false'
Set-DefaultOption 'Boxstarter::Essential::Remove::Microsoft.Getstarted'                    'true'
Set-DefaultOption 'Boxstarter::Essential::Remove::Microsoft.Messaging'                     'true'
Set-DefaultOption 'Boxstarter::Essential::Remove::Microsoft.Microsoft3DViewer'             'true'
Set-DefaultOption 'Boxstarter::Essential::Remove::Microsoft.MicrosoftOfficeHub'            'true'
Set-DefaultOption 'Boxstarter::Essential::Remove::Microsoft.MicrosoftPowerBIForWindows'    'true'
Set-DefaultOption 'Boxstarter::Essential::Remove::Microsoft.MicrosoftSolitaireCollection'  'true'
Set-DefaultOption 'Boxstarter::Essential::Remove::Microsoft.MicrosoftStickyNotes'          'true'
Set-DefaultOption 'Boxstarter::Essential::Remove::Microsoft.MinecraftUWP'                  'true'
Set-DefaultOption 'Boxstarter::Essential::Remove::Microsoft.MSPaint'                       'true'
Set-DefaultOption 'Boxstarter::Essential::Remove::Microsoft.NetworkSpeedTest'              'true'
Set-DefaultOption 'Boxstarter::Essential::Remove::Microsoft.Office.OneNote'                'true'
Set-DefaultOption 'Boxstarter::Essential::Remove::Microsoft.Office.Sway'                   'true'
Set-DefaultOption 'Boxstarter::Essential::Remove::Microsoft.OneConnect'                    'true'
Set-DefaultOption 'Boxstarter::Essential::Remove::Microsoft.OneDrive'                      'true'
Set-DefaultOption 'Boxstarter::Essential::Remove::Microsoft.People'                        'true'
Set-DefaultOption 'Boxstarter::Essential::Remove::Microsoft.SkypeApp'                      'true'
Set-DefaultOption 'Boxstarter::Essential::Remove::Microsoft.StorePurchaseApp'              'false'
Set-DefaultOption 'Boxstarter::Essential::Remove::Microsoft.Wallet'                        'true'
Set-DefaultOption 'Boxstarter::Essential::Remove::Microsoft.Windows.Photos'                'false'
Set-DefaultOption 'Boxstarter::Essential::Remove::Microsoft.WindowsAlarms'                 'false'
Set-DefaultOption 'Boxstarter::Essential::Remove::Microsoft.WindowsCalculator'             'false'
Set-DefaultOption 'Boxstarter::Essential::Remove::Microsoft.WindowsCamera'                 'true'
Set-DefaultOption 'Boxstarter::Essential::Remove::microsoft.windowscommunicationsapps'     'true'
Set-DefaultOption 'Boxstarter::Essential::Remove::Microsoft.WindowsFeedbackHub'            'true'
Set-DefaultOption 'Boxstarter::Essential::Remove::Microsoft.WindowsMaps'                   'true'
Set-DefaultOption 'Boxstarter::Essential::Remove::Microsoft.WindowsPhone'                  'true'
Set-DefaultOption 'Boxstarter::Essential::Remove::Microsoft.WindowsReadingList'            'true'
Set-DefaultOption 'Boxstarter::Essential::Remove::Microsoft.WindowsSoundRecorder'          'true'
Set-DefaultOption 'Boxstarter::Essential::Remove::Microsoft.WindowsStore'                  'false'
Set-DefaultOption 'Boxstarter::Essential::Remove::Microsoft.XboxApp'                       'true'
Set-DefaultOption 'Boxstarter::Essential::Remove::Microsoft.XboxGameOverlay'               'true'
Set-DefaultOption 'Boxstarter::Essential::Remove::Microsoft.XboxIdentityProvider'          'true'
Set-DefaultOption 'Boxstarter::Essential::Remove::Microsoft.XboxSpeechToTextOverlay'       'true'
Set-DefaultOption 'Boxstarter::Essential::Remove::Microsoft.ZuneMusic'                     'true'
Set-DefaultOption 'Boxstarter::Essential::Remove::Microsoft.ZuneVideo'                     'true'

[String[]]$apps = @()
if(Get-OptionBool 'Boxstarter::Essential::Remove::Microsoft.3DBuilder')                     { $apps += 'Microsoft.3DBuilder' }
if(Get-OptionBool 'Boxstarter::Essential::Remove::Microsoft.Appconnector')                  { $apps += 'Microsoft.Appconnector' }
if(Get-OptionBool 'Boxstarter::Essential::Remove::Microsoft.BingFinance')                   { $apps += 'Microsoft.BingFinance' }
if(Get-OptionBool 'Boxstarter::Essential::Remove::Microsoft.BingFoodAndDrink')              { $apps += 'Microsoft.BingFoodAndDrink' }
if(Get-OptionBool 'Boxstarter::Essential::Remove::Microsoft.BingHealthAndFitness')          { $apps += 'Microsoft.BingHealthAndFitness' }
if(Get-OptionBool 'Boxstarter::Essential::Remove::Microsoft.BingNews')                      { $apps += 'Microsoft.BingNews' }
if(Get-OptionBool 'Boxstarter::Essential::Remove::Microsoft.BingSports')                    { $apps += 'Microsoft.BingSports' }
if(Get-OptionBool 'Boxstarter::Essential::Remove::Microsoft.BingTravel')                    { $apps += 'Microsoft.BingTravel' }
if(Get-OptionBool 'Boxstarter::Essential::Remove::Microsoft.BingWeather')                   { $apps += 'Microsoft.BingWeather' }
if(Get-OptionBool 'Boxstarter::Essential::Remove::Microsoft.CommsPhone')                    { $apps += 'Microsoft.CommsPhone' }
if(Get-OptionBool 'Boxstarter::Essential::Remove::Microsoft.ConnectivityStore')             { $apps += 'Microsoft.ConnectivityStore' }
if(Get-OptionBool 'Boxstarter::Essential::Remove::Microsoft.DesktopAppInstaller')           { $apps += 'Microsoft.DesktopAppInstaller' }
if(Get-OptionBool 'Boxstarter::Essential::Remove::Microsoft.Getstarted')                    { $apps += 'Microsoft.Getstarted' }
if(Get-OptionBool 'Boxstarter::Essential::Remove::Microsoft.Messaging')                     { $apps += 'Microsoft.Messaging' }
if(Get-OptionBool 'Boxstarter::Essential::Remove::Microsoft.Microsoft3DViewer')             { $apps += 'Microsoft.Microsoft3DViewer' }
if(Get-OptionBool 'Boxstarter::Essential::Remove::Microsoft.MicrosoftOfficeHub')            { $apps += 'Microsoft.MicrosoftOfficeHub' }
if(Get-OptionBool 'Boxstarter::Essential::Remove::Microsoft.MicrosoftPowerBIForWindows')    { $apps += 'Microsoft.MicrosoftPowerBIForWindows' }
if(Get-OptionBool 'Boxstarter::Essential::Remove::Microsoft.MicrosoftSolitaireCollection')  { $apps += 'Microsoft.MicrosoftSolitaireCollection' }
if(Get-OptionBool 'Boxstarter::Essential::Remove::Microsoft.MicrosoftStickyNotes')          { $apps += 'Microsoft.MicrosoftStickyNotes' }
if(Get-OptionBool 'Boxstarter::Essential::Remove::Microsoft.MinecraftUWP')                  { $apps += 'Microsoft.MinecraftUWP' }
if(Get-OptionBool 'Boxstarter::Essential::Remove::Microsoft.MSPaint')                       { $apps += 'Microsoft.MSPaint' }
if(Get-OptionBool 'Boxstarter::Essential::Remove::Microsoft.NetworkSpeedTest')              { $apps += 'Microsoft.NetworkSpeedTest' }
if(Get-OptionBool 'Boxstarter::Essential::Remove::Microsoft.Office.OneNote')                { $apps += 'Microsoft.Office.OneNote' }
if(Get-OptionBool 'Boxstarter::Essential::Remove::Microsoft.Office.Sway')                   { $apps += 'Microsoft.Office.Sway' }
if(Get-OptionBool 'Boxstarter::Essential::Remove::Microsoft.OneConnect')                    { $apps += 'Microsoft.OneConnect' }
if(Get-OptionBool 'Boxstarter::Essential::Remove::Microsoft.People')                        { $apps += 'Microsoft.People' }
if(Get-OptionBool 'Boxstarter::Essential::Remove::Microsoft.SkypeApp')                      { $apps += 'Microsoft.SkypeApp' }
if(Get-OptionBool 'Boxstarter::Essential::Remove::Microsoft.StorePurchaseApp')              { $apps += 'Microsoft.StorePurchaseApp' }
if(Get-OptionBool 'Boxstarter::Essential::Remove::Microsoft.Wallet')                        { $apps += 'Microsoft.Wallet' }
if(Get-OptionBool 'Boxstarter::Essential::Remove::Microsoft.Windows.Photos')                { $apps += 'Microsoft.Windows.Photos' }
if(Get-OptionBool 'Boxstarter::Essential::Remove::Microsoft.WindowsAlarms')                 { $apps += 'Microsoft.WindowsAlarms' }
if(Get-OptionBool 'Boxstarter::Essential::Remove::Microsoft.WindowsCalculator')             { $apps += 'Microsoft.WindowsCalculator' }
if(Get-OptionBool 'Boxstarter::Essential::Remove::Microsoft.WindowsCamera')                 { $apps += 'Microsoft.WindowsCamera' }
if(Get-OptionBool 'Boxstarter::Essential::Remove::microsoft.windowscommunicationsapps')     { $apps += 'microsoft.windowscommunicationsapps' }
if(Get-OptionBool 'Boxstarter::Essential::Remove::Microsoft.WindowsFeedbackHub')            { $apps += 'Microsoft.WindowsFeedbackHub' }
if(Get-OptionBool 'Boxstarter::Essential::Remove::Microsoft.WindowsMaps')                   { $apps += 'Microsoft.WindowsMaps' }
if(Get-OptionBool 'Boxstarter::Essential::Remove::Microsoft.WindowsPhone')                  { $apps += 'Microsoft.WindowsPhone' }
if(Get-OptionBool 'Boxstarter::Essential::Remove::Microsoft.WindowsReadingList')            { $apps += 'Microsoft.WindowsReadingList' }
if(Get-OptionBool 'Boxstarter::Essential::Remove::Microsoft.WindowsSoundRecorder')          { $apps += 'Microsoft.WindowsSoundRecorder' }
if(Get-OptionBool 'Boxstarter::Essential::Remove::Microsoft.WindowsStore')                  { $apps += 'Microsoft.WindowsStore' }
if(Get-OptionBool 'Boxstarter::Essential::Remove::Microsoft.XboxApp')                       { $apps += 'Microsoft.XboxApp' }
if(Get-OptionBool 'Boxstarter::Essential::Remove::Microsoft.XboxGameOverlay')               { $apps += 'Microsoft.XboxGameOverlay' }
if(Get-OptionBool 'Boxstarter::Essential::Remove::Microsoft.XboxIdentityProvider')          { $apps += 'Microsoft.XboxIdentityProvider' }
if(Get-OptionBool 'Boxstarter::Essential::Remove::Microsoft.XboxSpeechToTextOverlay')       { $apps += 'Microsoft.XboxSpeechToTextOverlay' }
if(Get-OptionBool 'Boxstarter::Essential::Remove::Microsoft.ZuneMusic')                     { $apps += 'Microsoft.ZuneMusic' }
if(Get-OptionBool 'Boxstarter::Essential::Remove::Microsoft.ZuneVideo')                     { $apps += 'Microsoft.ZuneVideo' }

if(Get-OptionBool 'Boxstarter::Essential::Remove-Apps') {
    # Remove default apps
    Remove-WindowsApp $apps
    # Prevents "Suggested Applications" returning
    Set-Registry -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Cloud Content' -Name 'DisableWindowsConsumerFeatures' -Type 'DWord' -Value 1
    # remove oneDrive
    if(Get-OptionBool 'Boxstarter::Essential::Remove::Microsoft.OneDrive') {
        Remove-OneDrive
    }
   # remove paint 3D
    if(Get-OptionBool 'Boxstarter::Essential::Remove::Microsoft.MSPaint') {
        # How to remove 'Edit with Paint 3D' from context menu
        Remove-Registry 'HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\.jpeg\Shell'
    }
}


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#    Default options
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if(Confirm-Install 'Boxstarter::Disable-BingSearch')         { Disable-BingSearch  }
if(Confirm-Install 'Boxstarter::Disable-GameBarTips')        { Disable-GameBarTips }


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#    Install apps
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if(Confirm-Install 'Boxstarter::Essential::powershell')      { Install-ChocoApp powershell }
if(Confirm-Install 'Boxstarter::Essential::googlechrome')    { Install-ChocoApp googlechrome }
if(Confirm-Install 'Boxstarter::Essential::7zip')            { Install-ChocoApp 7zip.install }
if(Confirm-Install 'Boxstarter::Essential::adobereader')     { Install-ChocoApp adobereader }
if(Confirm-Install 'Boxstarter::Essential::adobereader')     { Install-ChocoApp adobereader-update }
if(Confirm-Install 'Boxstarter::Essential::paint.net')       { Install-ChocoApp paint.net }
if(Confirm-Install 'Boxstarter::Essential::notepadplusplus') { Install-ChocoApp notepadplusplus.install }
if(Confirm-Install 'Boxstarter::Essential::vlc')             { Install-ChocoApp vlc }

if(Confirm-Install 'Boxstarter::Essential::googlechrome')    { chocolatey pin add -n=googlechrome }
if(Confirm-Install 'Boxstarter::Essential::googlechrome')    { Install-ChocolateyPinnedTaskBarItem "${Env:ProgramFiles(x86)}\Google\Chrome\Application\chrome.exe" }
if(Confirm-Install 'Boxstarter::Essential::paint.net')       { chocolatey pin add -n=paint.net }

