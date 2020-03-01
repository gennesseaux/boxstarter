#--- [Import] ---------------------------------------------------------------------------------------------------------
Import-Function -Path "$sRoot/helpers/install/Install-vcpkg.ps1"
#----------------------------------------------------------------------------------------------------------------------

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#  Other common tools
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

if(Confirm-Install 'Boxstarter::DevCpp::git')      { Install-ChocoApp git -Params '"/GitAndUnixToolsOnPath /WindowsTerminal"' -RefreshEnv }
if(Confirm-Install 'Boxstarter::DevCpp::git')      { Install-ChocoApp git-lfs }
if(Confirm-Install 'Boxstarter::DevCpp::git')      { Install-ChocoApp git-credential-manager-for-windows }
if(Confirm-Install 'Boxstarter::DevCpp::cmake')    { Install-ChocoApp cmake }
if(Confirm-Install 'Boxstarter::DevCpp::llvm')     { Install-ChocoApp llvm }
if(Confirm-Install 'Boxstarter::DevCpp::ninja')    { Install-ChocoApp ninja }
if(Confirm-Install 'Boxstarter::DevCpp::doxygen')  { Install-ChocoApp doxygen.install }
if(Confirm-Install 'Boxstarter::DevCpp::vcpkg')    { Install-vcpkg c:\tools\vcpkg }
if(Confirm-Install 'Boxstarter::DevCpp::cygwin')   {

    Install-ChocoApp cygwin
    Install-ChocoApp cyg-get -RefreshEnv

    # git
    if(Confirm-Install 'Boxstarter::DevCpp::git') {
        if( ! ([string]::IsNullOrEmpty($proxyLocation))) {
            cyg-get -proxy $proxyLocation git gitk
        }
        else {
            cyg-get git gitk
        }
    }

    # cmake
    if(Confirm-Install 'Boxstarter::DevCpp::cmake') {
        if( ! ([string]::IsNullOrEmpty($proxyLocation))) {
            cyg-get -proxy $proxyLocation cmake
        }
        else {
            cyg-get cmake
        }
    }

    # llvm
    if(Confirm-Install 'Boxstarter::DevCpp::cmake') {
        if( ! ([string]::IsNullOrEmpty($proxyLocation))) {
            cyg-get -proxy $proxyLocation llvm
        }
        else {
            cyg-get llvm
        }
    }

    # ninja
    if(Confirm-Install 'Boxstarter::DevCpp::ninja') {
        if( ! ([string]::IsNullOrEmpty($proxyLocation))) {
            cyg-get -proxy $proxyLocation ninja
        }
        else {
            cyg-get ninja
        }
    }

    # doxygen
    if(Confirm-Install 'Boxstarter::DevCpp::doxygen') {
        if( ! ([string]::IsNullOrEmpty($proxyLocation))) {
            cyg-get -proxy $proxyLocation doxygen
        }
        else {
            cyg-get doxygen
        }
    }
}
