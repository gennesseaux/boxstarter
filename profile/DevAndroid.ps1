# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#    Common tools
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if(Confirm-Install 'Boxstarter::DevAndroid::jdk7')          { Install-ChocoApp jdk7 }
if(Confirm-Install 'Boxstarter::DevAndroid::jdk8')          { Install-ChocoApp jdk8 }
if(Confirm-Install 'Boxstarter::DevAndroid::gradle')        { Install-ChocoApp gradle }
if(Confirm-Install 'Boxstarter::DevAndroid::android-sdk')   { Install-ChocoApp android-sdk }
if(Confirm-Install 'Boxstarter::DevAndroid::androidstudio') { Install-ChocoApp androidstudio }
if(Confirm-Install 'Boxstarter::DevAndroid::apktool')       { Install-ChocoApp apktool }