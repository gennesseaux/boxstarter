# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#    Other common tools
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if(Confirm-Install 'Boxstarter::Docker::docker-for-windows')    { Install-ChocoApp docker-for-windows }
if(Confirm-Install 'Boxstarter::Docker::docker-compose')        { Install-ChocoApp docker-compose }
if(Confirm-Install 'Boxstarter::Docker::docker-kitematic')      { Install-ChocoApp docker-kitematic }