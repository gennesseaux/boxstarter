#--- [Import] ---------------------------------------------------------------------------------------------------------
Import-Function -Path "$sRoot/helpers/install/Install-JetBrainsIntellijIdea.ps1"
#----------------------------------------------------------------------------------------------------------------------

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#    Common tools
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if(Confirm-Install 'Boxstarter::DevJava::jdk8')         { Install-ChocoApp jdk8 }
if(Confirm-Install 'Boxstarter::DevJava::maven')        { Install-ChocoApp maven }
if(Confirm-Install 'Boxstarter::DevJava::gradle')       { Install-ChocoApp gradle }
if(Confirm-Install 'Boxstarter::DevJava::intellijidea') { Install-JetBrainsIntellijIdea -ultimate }