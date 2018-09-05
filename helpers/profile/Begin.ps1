
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
        Set-WindowsExplorerOptions -EnableShowHiddenFilesFoldersDrives
        # hidden Operating System files will be shown in Windows Explorer
        Set-WindowsExplorerOptions -EnableShowProtectedOSFiles
        # Windows Explorer will include the file extension in file names
        Set-WindowsExplorerOptions -EnableShowFileExtensions
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

    # Install Windows update
    if(Confirm-Install 'Boxstarter::WindowsUpdate') {
        Start-UpdateServices
        Install-WindowsUpdate -AcceptEula
        if(Test-PendingReboot) { Invoke-Reboot }
    }

    # Install Windows update
    if(Confirm-Install 'Boxstarter::MicrosoftUpdate') {
        Enable-MicrosoftUpdate
        if(Test-PendingReboot) { Invoke-Reboot }
    }
}