# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#  Visual Studio 2017
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
$Vs2017Params = Get-Option 'Boxstarter::DevVs2017::Params'
if(Confirm-Install 'Boxstarter::DevVs2017::Community')              { Install-ChocoApp VisualStudio2017Community -Params $Vs2017Params }
elseif(Confirm-Install 'Boxstarter::DevVs2017::Professional')       { Install-ChocoApp visualstudio2017professional -Params $Vs2017Params }
elseif(Confirm-Install 'Boxstarter::DevVs2017::Entreprise')         { Install-ChocoApp visualstudio2017enterprise -Params $Vs2017Params }

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#  Tools
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if(Confirm-Install 'Boxstarter::DevVs2017::vswhere')                { Install-ChocoApp vswhere }

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#  Workload
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if(Confirm-Install 'Boxstarter::DevVs2017::azure')                  { Install-ChocoApp visualstudio2017-workload-azure }
if(Confirm-Install 'Boxstarter::DevVs2017::data')                   { Install-ChocoApp visualstudio2017-workload-data }
if(Confirm-Install 'Boxstarter::DevVs2017::datascience')            { Install-ChocoApp visualstudio2017-workload-datascience }
if(Confirm-Install 'Boxstarter::DevVs2017::manageddesktop')         { Install-ChocoApp visualstudio2017-workload-manageddesktop }
if(Confirm-Install 'Boxstarter::DevVs2017::managedgame')            { Install-ChocoApp visualstudio2017-workload-managedgame }
if(Confirm-Install 'Boxstarter::DevVs2017::nativecrossplat')        { Install-ChocoApp visualstudio2017-workload-nativecrossplat }
if(Confirm-Install 'Boxstarter::DevVs2017::nativedesktop')          { Install-ChocoApp visualstudio2017-workload-nativedesktop }
if(Confirm-Install 'Boxstarter::DevVs2017::nativegame')             { Install-ChocoApp visualstudio2017-workload-nativegame }
if(Confirm-Install 'Boxstarter::DevVs2017::nativemobile')           { Install-ChocoApp visualstudio2017-workload-nativemobile }
if(Confirm-Install 'Boxstarter::DevVs2017::netcoretools')           { Install-ChocoApp visualstudio2017-workload-netcoretools }
if(Confirm-Install 'Boxstarter::DevVs2017::netcrossplat')           { Install-ChocoApp visualstudio2017-workload-netcrossplat }
if(Confirm-Install 'Boxstarter::DevVs2017::netweb')                 { Install-ChocoApp visualstudio2017-workload-netweb }
if(Confirm-Install 'Boxstarter::DevVs2017::node')                   { Install-ChocoApp visualstudio2017-workload-node }
if(Confirm-Install 'Boxstarter::DevVs2017::office')                 { Install-ChocoApp visualstudio2017-workload-office }
if(Confirm-Install 'Boxstarter::DevVs2017::python')                 { Install-ChocoApp visualstudio2017-workload-python }
if(Confirm-Install 'Boxstarter::DevVs2017::universal')              { Install-ChocoApp visualstudio2017-workload-universal }
if(Confirm-Install 'Boxstarter::DevVs2017::visualstudioextension')  { Install-ChocoApp visualstudio2017-workload-visualstudioextension }
if(Confirm-Install 'Boxstarter::DevVs2017::webcrossplat')           { Install-ChocoApp visualstudio2017-workload-webcrossplat }

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#  Packages
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if(Confirm-Install 'Boxstarter::DevVs2017::packages') {
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
    $userPackages = Get-Option 'Boxstarter::DevVs2017::Packages::UserPackages'
    if(-not($null -eq $userPackages)) { $packages += $userPackages.split(';, ').Trim() }

    # install packages
    foreach ($package in $packages) {
        [String]$name,[String]$url=$package.split(':')
        Install-ChocolateyVsixPackage $name $url
    }
}


if(Confirm-Install 'Boxstarter::DevVs2017::Community') {
    Pin-TaskBarItem "${env:ProgramFiles(x86)}\Microsoft Visual Studio\2017\Community\Common7\IDE\devenv.exe"
}
elseif(Confirm-Install 'Boxstarter::DevVs2017::Professional') {
    Pin-TaskBarItem "${env:ProgramFiles(x86)}\Microsoft Visual Studio\2017\Professional\Common7\IDE\devenv.exe"
}
elseif(Confirm-Install 'Boxstarter::DevVs2017::Entreprise') {
    Pin-TaskBarItem "${env:ProgramFiles(x86)}\Microsoft Visual Studio\2017\Enterprise\Common7\IDE\devenv.exe"
}
