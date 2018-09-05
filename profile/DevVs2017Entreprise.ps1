#--- [Import] ---------------------------------------------------------------------------------------------------------
Import-Function -Path "$sRoot/helpers/install/Install-Install-VisualStudio2017.ps1"
Import-Function -Path "$sRoot/helpers/install/Install-VisualStudio2017VsixPackage.ps1"
#----------------------------------------------------------------------------------------------------------------------


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#    Visual studio 2017
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if(Confirm-Install 'Boxstarter::DevVs2017::VisualStudio2017') {
    Install-VisualStudio2017 `
        -Entreprise `
        -NativeDesktop
}


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#    Visual studio packages
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if($(Confirm-Install 'Boxstarter::DevVs2017::VisualStudio2017VsixPackage') -And $(Confirm-Install 'Boxstarter::DevVs2017::VisualStudio2017')) {
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
    $userPackages = Get-Option 'Boxstarter::DevVs2017::VisualStudio2017VsixPackage::Packages'
    if(-not($null -eq $userPackages)) { $packages += $userPackages.split(';, ').Trim() }

    Install-VisualStudioCodeExtensions $packages
}


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#    Other common tools
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if(Confirm-Install 'Boxstarter::DevVs2017::vswhere')               { Install-ChocoApp vswhere }