#     - List of installed apps
#       - Google Chrome
#       - 7zip
#       - Adobe reader
#       - Paint.net
#       - Notepad ++
#       - Vlc


if(Confirm-Install 'Boxstarter::Tools::googlechrome')    { Install-ChocoApp googlechrome -NoUpgrade }
if(Confirm-Install 'Boxstarter::Tools::7zip')            { Install-ChocoApp 7zip }
if(Confirm-Install 'Boxstarter::Tools::adobereader')     { Install-ChocoApp adobereader }
if(Confirm-Install 'Boxstarter::Tools::adobereader')     { Install-ChocoApp adobereader-update }
if(Confirm-Install 'Boxstarter::Tools::paint.net')       { Install-ChocoApp paint.net -NoUpgrade }
if(Confirm-Install 'Boxstarter::Tools::notepadplusplus') { Install-ChocoApp notepadplusplus -NoUpgrade }
if(Confirm-Install 'Boxstarter::Tools::vlc')             { Install-ChocoApp vlc -NoUpgrade }
if(Confirm-Install 'Boxstarter::Tools::sysinternals')    { Install-ChocoApp sysinternals }


if(Confirm-Install 'Boxstarter::Tools::googlechrome')    { Pin-TaskBarItem "${Env:ProgramFiles(x86)}\Google\Chrome\Application\chrome.exe" }




