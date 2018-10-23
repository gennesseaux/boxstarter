# Allow unattended reboots
$Boxstarter.RebootOk=$true
$Boxstarter.NoPassword=$false
$Boxstarter.AutoLogin=$true

#--- Import ---
Import-Function -Path "$sRoot/helpers/install/Install-VisualStudioCode.ps1"

#--- TEMPORARY ---
Disable-UAC

#--- Tools ---
Install-ChocoApp 7zip.install

#--- Apps ---
Install-ChocoApp notepadplusplus.install
Install-ChocoApp vlc
Install-ChocoApp cmder
Install-VisualStudioCode

#--- Tell chocolatey to not upgrade thoses apps --
chocolatey pin add -n=notepadplusplus
chocolatey pin add -n=vlc

#--- Restore Temporary Settings ---
Enable-UAC
Enable-MicrosoftUpdate