#     - List of installed apps
#       - Git
#       - Git Credential Manager for Windows
#       - Posh-git
#       - WinMerge
#       - Cmder
#       - Wget
#       - cURL
#       - CMake
#       - Visual Studio Code
#           - Settings Sync
#           - EditorConfig for VS Code
#           - vscode-icons
#           - PowerShell


#--- [Import] ---------------------------------------------------------------------------------------------------------
Import-Function -Path "$sRoot/helpers/install/Install-VisualStudioCode.ps1"
Import-Function -Path "$sRoot/helpers/install/Install-VisualStudioCodeExtensions.ps1"
#----------------------------------------------------------------------------------------------------------------------


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#  Other common tools
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if(Confirm-Install 'Boxstarter::DevCore::git')      { Install-ChocoApp git -Params '"/GitAndUnixToolsOnPath /WindowsTerminal"' -RefreshEnv }
if(Confirm-Install 'Boxstarter::DevCore::git')      { Install-ChocoApp git-lfs }
if(Confirm-Install 'Boxstarter::DevCore::git')      { Install-ChocoApp git-credential-manager-for-windows }
if(Confirm-Install 'Boxstarter::DevCore::git-fork') { Install-ChocoApp git-fork }
if(Confirm-Install 'Boxstarter::DevCore::poshgit')  { Install-ChocoApp poshgit }
if(Confirm-Install 'Boxstarter::DevCore::winmerge') { Install-ChocoApp winmerge }
if(Confirm-Install 'Boxstarter::DevCore::cmder')    { Install-ChocoApp cmder }
if(Confirm-Install 'Boxstarter::DevCore::wget')     { Install-ChocoApp wget }
if(Confirm-Install 'Boxstarter::DevCore::curl')     { Install-ChocoApp curl }
if(Confirm-Install 'Boxstarter::DevCore::cmake')    { Install-ChocoApp cmake }


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#  Visual studio code : https://code.visualstudio.com/
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if(Confirm-Install 'Boxstarter::DevCore::VisualStudioCode') {
    Install-VisualStudioCode
}


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#  Visual studio code extensions : https://marketplace.visualstudio.com/VSCode
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if($(Confirm-Install 'Boxstarter::DevCore::VisualStudioCodeExtensions') -And $(Confirm-Install 'Boxstarter::DevCore::VisualStudioCode')) {
    # Extensions to add to Visual studio code :
    [String[]]$extensions = @()
    $extensions += 'Shan.code-settings-sync'
    $extensions += 'EditorConfig.EditorConfig'
    $extensions += 'robertohuertasm.vscode-icons'
    $extensions += 'ms-vscode.PowerShell'
    # Get user define extensions
    $userExtensions = Get-Option 'Boxstarter::DevCore::VisualStudioCodeExtensions::Extensions'
    if(-not($null -eq $userExtensions)) { $extensions += $userExtensions.split(';, ').Trim() }

    Install-VisualStudioCodeExtensions $extensions
}


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#  Install fonts
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if(Confirm-Install 'Boxstarter::DevCore::fonts')
{
    if(Confirm-Install 'Boxstarter::DevCore::dejavufonts')      { Install-ChocoApp 'dejavufonts' }
    if(Confirm-Install 'Boxstarter::DevCore::droidfonts')       { Install-ChocoApp 'droidfonts' }
    if(Confirm-Install 'Boxstarter::DevCore::firacode')         { Install-ChocoApp 'firacode' }
    if(Confirm-Install 'Boxstarter::DevCore::hackfont')         { Install-ChocoApp 'hackfont' }
    if(Confirm-Install 'Boxstarter::DevCore::inconsolata')      { Install-ChocoApp 'inconsolata' }
    if(Confirm-Install 'Boxstarter::DevCore::robotofonts')      { Install-ChocoApp 'robotofonts' }
}