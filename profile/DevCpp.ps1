#--- [Import] ---------------------------------------------------------------------------------------------------------
Import-Function -Path "$sRoot/helpers/install/Install-vcpkg.ps1"
#----------------------------------------------------------------------------------------------------------------------

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#  Other common tools
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

if(Confirm-Install 'Boxstarter::DevCpp::cmake')    { Install-ChocoApp cmake }
if(Confirm-Install 'Boxstarter::DevCpp::LLVM')     { Install-ChocoApp llvm }
if(Confirm-Install 'Boxstarter::DevCpp::doxygen')  { Install-ChocoApp doxygen.install }
if(Confirm-Install 'Boxstarter::DevCpp::vcpkg')    { Install-vcpkg c:\tools\vcpkg }
