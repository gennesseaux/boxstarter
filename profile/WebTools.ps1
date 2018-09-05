

if(Confirm-Install 'Boxstarter::WebTools::sysinternals')    { Install-ChocoApp sysinternals }
if(Confirm-Install 'Boxstarter::WebTools::wget')            { Install-ChocoApp wget }
if(Confirm-Install 'Boxstarter::WebTools::curl')            { Install-ChocoApp curl }
if(Confirm-Install 'Boxstarter::WebTools::putty')           { Install-ChocoApp putty.install }
if(Confirm-Install 'Boxstarter::WebTools::winscp')          { Install-ChocoApp winscp.install }
if(Confirm-Install 'Boxstarter::WebTools::filezilla')       { Install-ChocoApp filezilla }
if(Confirm-Install 'Boxstarter::WebTools::postman')         { Install-ChocoApp postman }
