
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#    Common tools
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if(Confirm-Install 'Boxstarter::Game::geforce')         { Install-ChocoApp geforce-experience }
if(Confirm-Install 'Boxstarter::Game::discord')         { Install-ChocoApp discord.install }
if(Confirm-Install 'Boxstarter::Game::teamspeak')       { Install-ChocoApp teamspeak }