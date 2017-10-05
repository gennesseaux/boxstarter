#--- [Import] ---------------------------------------------------------------------------------------------------------
Import-Function -Path "$sRoot/helpers/install/Install-VisualStudioCode.ps1"
Import-Function -Path "$sRoot/helpers/install/Install-VisualStudioCodeExtensions.ps1"
#----------------------------------------------------------------------------------------------------------------------


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#    Visual studio code : https://code.visualstudio.com/
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if(Confirm-Install 'Boxstarter::DevCore::VisualStudioCode') {
    Install-VisualStudioCode
}


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#    Visual studio code extensions : https://marketplace.visualstudio.com/VSCode
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if($(Confirm-Install 'Boxstarter::DevCore::VisualStudioCodeExtensions') -And $(Confirm-Install 'Boxstarter::DevCore::VisualStudioCode')) {
    # Extensions to add to Visual studio code :
    [String[]]$extensions = @()
    $extensions += 'Shan.code-settings-sync'
    # Get user define extensions
    $userExtensions = Get-Option 'Boxstarter::DevCore::VisualStudioCodeExtensions::Extensions'
    if(-not($userExtensions -eq $null)) { $extensions += $userExtensions.split(';, ').Trim() }

    Install-VisualStudioCodeExtensions $extensions
}


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#    Other common tools
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if(Confirm-Install 'Boxstarter::DevCore::git')      { Install-ChocoApp git.install }
if(Confirm-Install 'Boxstarter::DevCore::git')      { Install-ChocoApp git-credential-manager-for-windows }
if(Confirm-Install 'Boxstarter::DevCore::poshgit')  { Install-ChocoApp poshgit }
if(Confirm-Install 'Boxstarter::DevCore::winmerge') { Install-ChocoApp winmerge }
if(Confirm-Install 'Boxstarter::DevCore::cmder')    { Install-ChocoApp cmder }
if(Confirm-Install 'Boxstarter::DevCore::wget')     { Install-ChocoApp wget }
if(Confirm-Install 'Boxstarter::DevCore::curl')     { Install-ChocoApp curl }
if(Confirm-Install 'Boxstarter::DevCore::cmake')    { Install-ChocoApp cmake.install }


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#    Install fonts
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if(Confirm-Install 'Boxstarter::DevCore::fonts')
{
    if(Confirm-Install 'Boxstarter::DevCore::dejavufonts')      { Install-ChocoApp 'dejavufonts' }
    if(Confirm-Install 'Boxstarter::DevCore::inconsolata')      { Install-ChocoApp 'inconsolata' }
    if(Confirm-Install 'Boxstarter::DevCore::robotofonts')      { Install-ChocoApp 'robotofonts' }
}