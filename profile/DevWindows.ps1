#--- [Import] ---------------------------------------------------------------------------------------------------------
Import-Function -Path "$sRoot/helpers/install/Install-Install-VisualStudio2017.ps1"
Import-Function -Path "$sRoot/helpers/install/Install-VisualStudio2017VsixPackage.ps1"
#----------------------------------------------------------------------------------------------------------------------


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#    Visual studio 2017
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if(Confirm-Install 'Boxstarter::DevWindows::VisualStudio2017') {
    Install-VisualStudio2017 `
        -entreprise `
        -data `
        -manageddesktop `
        -nativedesktop `
        -netcoretools `
        -node `
        -universal `
        -visualstudioextension
}


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#    Visual studio packages
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if($(Confirm-Install 'Boxstarter::DevWindows::VisualStudio2017VsixPackage') -And $(Confirm-Install 'Boxstarter::DevWindows::VisualStudio2017')) {
    # Packages to add to Visual studio 2017 :
    [String[]]$packages = @()
    $packages += 'StopOnFirstBuildError:https://marketplace.visualstudio.com/items?itemName=EinarEgilsson.StopOnFirstBuildError'
    $packages += 'PowerShellToolsForVisualStudio2017:https://marketplace.visualstudio.com/items?itemName=AdamRDriscoll.PowerShellToolsforVisualStudio2017-18561'
    $packages += 'OpeninVisualStudioCode:https://marketplace.visualstudio.com/items?itemName=MadsKristensen.OpeninVisualStudioCode'
    $packages += 'PrettyPaste:https://marketplace.visualstudio.com/items?itemName=MadsKristensen.PrettyPaste'
    $packages += 'ProductivityPowerPack2017:https://marketplace.visualstudio.com/items?itemName=VisualStudioProductTeam.ProductivityPowerPack2017'
    $packages += 'Viasfora:https://marketplace.visualstudio.com/items?itemName=TomasRestrepo.Viasfora'
    $packages += 'Outputenhancer:https://marketplace.visualstudio.com/items?itemName=NikolayBalakin.Outputenhancer'
    # Get user define packages
    $userPackages = Get-Option 'Boxstarter::DevWindows::VisualStudio2017VsixPackage::Packages'
    if(-not($userPackages -eq $null)) { $packages += $userPackages.split(';, ').Trim() }

    Install-VisualStudioCodeExtensions $packages
}


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#    Other common tools
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if(Confirm-Install 'Boxstarter::DevWindows::vswhere')               { Install-ChocoApp vswhere }
if(Confirm-Install 'Boxstarter::DevWindows::nodejs')                { Install-ChocoApp nodejs-lts }
if(Confirm-Install 'Boxstarter::DevWindows::docker-for-windows')    { Install-ChocoApp docker-for-windows }
if(Confirm-Install 'Boxstarter::DevWindows::docker-compose')        { Install-ChocoApp docker-compose }
if(Confirm-Install 'Boxstarter::DevWindows::docker-kitematic')      { Install-ChocoApp docker-kitematic }
if(Confirm-Install 'Boxstarter::DevWindows::resharper-platform')    { Install-JetBrainsResharper -ultimate }
if(Confirm-Install 'Boxstarter::DevWindows::putty')                 { Install-ChocoApp putty.install }
if(Confirm-Install 'Boxstarter::DevWindows::winscp')                { Install-ChocoApp winscp.install }

if(Confirm-Install 'Boxstarter::DevWindows::Microsoft-Hyper-V')                     { Install-ChocoWindowsFeature Microsoft-Hyper-V-All }
if(Confirm-Install 'Boxstarter::DevWindows::Microsoft-Windows-Subsystem-Linux')     { Install-ChocoWindowsFeature Microsoft-Windows-Subsystem-Linux }
