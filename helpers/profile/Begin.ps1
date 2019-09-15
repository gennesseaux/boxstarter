
# Allow unattended reboots
$Boxstarter.RebootOk=$true
$Boxstarter.NoPassword=$false
$Boxstarter.AutoLogin=$true

# Don't want to use those default parameters
# just add this option to the starter script
#
#       Boxstarter::Begin=false
#

#--- [Import] ---------------------------------------------------------------------------------------------------------
Import-Function -WebClient $webclient -Path "https://raw.githubusercontent.com/chocolatey/boxstarter/master/BoxStarter.Common/Remove-BoxstarterError.ps1"
Import-Function -WebClient $webclient -Path "https://raw.githubusercontent.com/chocolatey/boxstarter/master/Boxstarter.Bootstrapper/Stop-UpdateServices.ps1"
#----------------------------------------------------------------------------------------------------------------------

# Temporary
Disable-UAC

#
if(Confirm-Install 'Boxstarter::Begin')
{
    # Allow running PowerShell scripts
    if(Confirm-Install 'Boxstarter::Begin::ExecutionPolicy') {
        Update-ExecutionPolicy Unrestricted
    }

    # Disable Microsoft Update
    if(Confirm-Install 'Boxstarter::Begin::MicrosoftUpdate') {
        Disable-MicrosoftUpdate
    }

    # Disable Windows Update
    if(Confirm-Install 'Boxstarter::Begin::WindowsUpdate') {
        Stop-UpdateServices
    }
}