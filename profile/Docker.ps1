# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#    Other common tools
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if(Confirm-Install 'Boxstarter::Docker::docker-desktop')        { Install-ChocoApp docker-desktop }
if(Confirm-Install 'Boxstarter::Docker::docker-compose')        { Install-ChocoApp docker-compose }
if(Confirm-Install 'Boxstarter::Docker::docker-kitematic')      { Install-ChocoApp docker-kitematic }