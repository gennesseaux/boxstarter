
# Allow unattended reboots
$Boxstarter.RebootOk=$true
$Boxstarter.NoPassword=$false
$Boxstarter.AutoLogin=$true

# Don't want to use those default parameters
# just add this option to the starter script
#
#       Boxstarter::Begin=false
#

# Temporary
Disable-UAC
if(Test-PendingReboot) { Invoke-Reboot }

#
if(Confirm-Install 'Boxstarter::Begin')
{
    # Allow running PowerShell scripts
    if(Confirm-Install 'Boxstarter::ExecutionPolicy') {
        Update-ExecutionPolicy Unrestricted
    }

    # Show more info for files in Explorer
    if(Confirm-Install 'Boxstarter::WindowsExplorerOptions') {
        # Set-WindowsExplorerOptions parameters can be found in https://github.com/chocolatey/boxstarter/blob/master/Boxstarter.WinConfig/Set-WindowsExplorerOptions.ps1

        # hidden files will be shown in Windows Explorer
        # hidden Operating System files will be shown in Windows Explorer
        # Windows Explorer will include the file extension in file names
        Set-WindowsExplorerOptions -EnableShowHiddenFilesFoldersDrives `
                                   -EnableShowProtectedOSFiles `
                                   -EnableShowFileExtensions
    }

    # Enable remote desktop
    if(Confirm-Install 'Boxstarter::RemoteDesktop') {
        Enable-RemoteDesktop
    }

    #
    if(Confirm-Install 'Boxstarter::InternetExplorerESC') {
        Disable-InternetExplorerESC
    }

    # Small taskbar
    if(Confirm-Install 'Boxstarter::TaskbarOptions') {
        Set-TaskbarOptions -Size Small -Dock Bottom -Combine Always
        Set-TaskbarOptions -Size Small -Dock Bottom -Combine Always -AlwaysShowIconsOn
    }

    # replace command prompt with powershell in start menu and win+x
    if(Confirm-Install 'Boxstarter::CornerNavigationOptions') {
        Set-CornerNavigationOptions -EnableUsePowerShellOnWinX
    }

    # Turns on Microsoft Update
    if(Confirm-Install 'Boxstarter::MicrosoftUpdate') {
        Enable-MicrosoftUpdate
        if(Test-PendingReboot) { Invoke-Reboot }
    }

    # Downloads and installs updates via Windows Update
    if(Confirm-Install 'Boxstarter::WindowsUpdate') {
        Start-UpdateServices
        Install-WindowsUpdate -AcceptEula
        if(Test-PendingReboot) { Invoke-Reboot }
    }
}