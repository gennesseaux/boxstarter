# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#    Add tweaks from Disassembler0
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -


#--- [Import] ---------------------------------------------------------------------------------------------------------
Import-Function -Path "$sRoot/helpers/tweak/Disassembler0/Privacy.ps1"
Import-Function -Path "$sRoot/helpers/tweak/Disassembler0/Security.ps1"
Import-Function -Path "$sRoot/helpers/tweak/Disassembler0/Service.ps1"
Import-Function -Path "$sRoot/helpers/tweak/Disassembler0/UI.ps1"
Import-Function -Path "$sRoot/helpers/tweak/Disassembler0/ExplorerUI.ps1"
Import-Function -Path "$sRoot/helpers/tweak/Disassembler0/Application.ps1"
#----------------------------------------------------------------------------------------------------------------------


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#    Privacy tweaks
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if(Confirm-Install 'Boxstarter::EssentailTweaks::Privacy-tweaks')
{
    Write-BoxstarterMessage "Updating Privacy tweaks..."

    DisableTelemetry
    DisableWiFiSense
    DisableWebSearch
    DisableAppSuggestions
    DisableActivityHistory
    DisableLocationTracking
    DisableMapUpdates
    DisableFeedback
    DisableTailoredExperiences
    DisableAdvertisingID
    DisableWebLangList
    DisableErrorReporting
    SetP2PUpdateLocal
    DisableDiagTrack
    DisableWAPPush
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#    Security  tweaks
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if(Confirm-Install 'Boxstarter::EssentailTweaks::Security-tweaks')
{
    Write-BoxstarterMessage "Updating Security tweaks..."

    SetCurrentNetworkPrivate
    EnableF8BootMenu
    SetDEPOptOut
}


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#    Service tweaks
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if(Confirm-Install 'Boxstarter::EssentailTweaks::Service-tweaks')
{
    Write-BoxstarterMessage "Updating Service tweaks..."

    DisableUpdateRestart
    DisableSharedExperiences
    DisableRemoteAssistance
    EnableRemoteDesktop
    DisableAutoplay
    DisableAutorun
    DisableFastStartup
}


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#    UI tweaks
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if(Confirm-Install 'Boxstarter::EssentailTweaks::UI-tweaks')
{
    Write-BoxstarterMessage "Updating UI tweaks..."

    DisableStickyKeys
    ShowTaskManagerDetails
    ShowFileOperationsDetails
    HideTaskbarPeopleIcon
    EnableNumlock
    DisableStartupSound
}


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#    Explorer UI tweaks
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if(Confirm-Install 'Boxstarter::EssentailTweaks::Explorer-UI-tweaks')
{
    Write-BoxstarterMessage "Updating Explorer UI tweaks..."

    ShowKnownExtensions
    ShowHiddenFiles
    HideSyncNotifications
    HideRecentShortcuts
    SetExplorerThisPC
    HideQuickAccess
    ShowThisPCOnDesktop
    DisableThumbnailCache
    DisableThumbsDBOnNetwork
}


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#    Application tweaks
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if(Confirm-Install 'Boxstarter::EssentailTweaks::Application-tweaks')
{
    Write-BoxstarterMessage "Updating Application tweaks..."

    UninstallXPSPrinter
    RemoveFaxPrinter
    UninstallFaxAndScan
}