#--- [Import] ---------------------------------------------------------------------------------------------------------
Import-Function -Path "$sRoot/helpers/install/Install-VisualStudio2017.ps1"
Import-Function -Path "$sRoot/helpers/install/Install-VisualStudio2017VsixPackage.ps1"
#----------------------------------------------------------------------------------------------------------------------


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#    Visual studio 2017
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if(Confirm-Install 'Boxstarter::DevVs2017::VisualStudio2017') {
    Install-VisualStudio2017 `
        -Community `
        -NativeDesktop
}


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#    Visual studio packages
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if($(Confirm-Install 'Boxstarter::DevVs2017::VisualStudio2017VsixPackage') -And $(Confirm-Install 'Boxstarter::DevVs2017::VisualStudio2017')) {
    # Packages to add to Visual studio 2017 :
    [String[]]$packages = @()
    $packages += 'AddNewFile:https://marketplace.visualstudio.com/items?itemName=MadsKristensen.AddNewFile'
    $packages += 'ClangFormat:https://marketplace.visualstudio.com/items?itemName=LLVMExtensions.ClangFormat'
    $packages += 'CodeCompare:https://marketplace.visualstudio.com/items?itemName=DevartSoftware.CodeCompare'
    $packages += 'CodeMaid:https://marketplace.visualstudio.com/items?itemName=SteveCadwallader.CodeMaid'
    $packages += 'CommentsPlus:https://marketplace.visualstudio.com/items?itemName=mhoumann.CommentsPlus'
    $packages += 'CQuickFixes2017:https://marketplace.visualstudio.com/items?itemName=VisualCppDevLabs.CQuickFixes2017'
    $packages += 'EditorConfig:https://marketplace.visualstudio.com/items?itemName=MadsKristensen.EditorConfig'
    $packages += 'EditorGuidelines:https://marketplace.visualstudio.com/items?itemName=PaulHarrington.EditorGuidelines'
    $packages += 'IncludeToolbox:https://marketplace.visualstudio.com/items?itemName=Wumpf.IncludeToolbox'
    $packages += 'IndentGuides:https://marketplace.visualstudio.com/items?itemName=SteveDowerMSFT.IndentGuides'
    $packages += 'MultiEditMode:https://marketplace.visualstudio.com/items?itemName=MadsKristensen.MultiEditMode'
    $packages += 'OpeninNotepad:https://marketplace.visualstudio.com/items?itemName=CalvinAAllen.OpeninNotepad'
    $packages += 'OpeninVisualStudioCode:https://marketplace.visualstudio.com/items?itemName=MadsKristensen.OpeninVisualStudioCode'
    $packages += 'Outputenhancer:https://marketplace.visualstudio.com/items?itemName=NikolayBalakin.Outputenhancer'
    $packages += 'PowerCommandsforVisualStudio:https://marketplace.visualstudio.com/items?itemName=VisualStudioPlatformTeam.PowerCommandsforVisualStudio'
    $packages += 'PowerShellToolsForVisualStudio2017:https://marketplace.visualstudio.com/items?itemName=AdamRDriscoll.PowerShellToolsforVisualStudio2017-18561'
    $packages += 'PrettyPaste:https://marketplace.visualstudio.com/items?itemName=MadsKristensen.PrettyPaste'
    $packages += 'SolutionErrorVisualizer:https://marketplace.visualstudio.com/items?itemName=VisualStudioPlatformTeam.SolutionErrorVisualizer'
    $packages += 'StopOnFirstBuildError:https://marketplace.visualstudio.com/items?itemName=EinarEgilsson.StopOnFirstBuildError'
    $packages += 'Structure Visualizer:https://marketplace.visualstudio.com/items?itemName=VisualStudioPlatformTeam.StructureVisualizer'
    $packages += 'Viasfora:https://marketplace.visualstudio.com/items?itemName=TomasRestrepo.Viasfora'

    # Get user define packages
    $userPackages = Get-Option 'Boxstarter::DevVs2017::VisualStudio2017VsixPackage::Packages'
    if(-not($null -eq $userPackages)) { $packages += $userPackages.split(';, ').Trim() }

    Install-VisualStudioCodeExtensions $packages
}


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#    Other common tools
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if(Confirm-Install 'Boxstarter::DevVs2017::vswhere')               { Install-ChocoApp vswhere }