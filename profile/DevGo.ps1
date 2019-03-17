# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#  Other common tools
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

if(Confirm-Install 'Boxstarter::DevGo::golang')   { Install-ChocoApp golang }
if(Confirm-Install 'Boxstarter::DevGo::liteide')  { Install-ChocoApp liteide }
if(Confirm-Install 'Boxstarter::DevGo::goland')   { Install-ChocoApp goland }
