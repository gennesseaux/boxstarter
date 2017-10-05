function Install-VisualStudio2017
{
    param(
        # Visual Studio 2017 Community
        [switch]$community,
        # Visual Studio 2017 Enterprise
        [switch]$entreprise,
        
        # Azure development
        [switch]$azure,
        # Data storage and processing
        [switch]$data,
        # .NET desktop dev.
        [switch]$manageddesktop,
        # Game dev. with Unity
        [switch]$managedgame,
        # Linux dev. with C++
        [switch]$nativecrossplat,
        # Desktop dev. with C++
        [switch]$nativedesktop,
        # Game dev. with C++
        [switch]$nativegame,
        # Mobile dev. with C++
        [switch]$nativemobile,
        # .NET Core cross-platform dev.
        [switch]$netcoretools,
        # Mobile dev. with .NET
        [switch]$netcrossplat,
        # ASP.NET and web dev.
        [switch]$netweb,
        # Node.js dev.
        [switch]$node,
        # Office/SharePoint dev.
        [switch]$office,
        # Universal Windows Platform dev.
        [switch]$universal,
        # Visual Studio extension dev.
        [switch]$visualstudioextension,
        # Mobile dev. with JavaScript
        [switch]$webcrossplat
    )

    #
    if($community)  { $entreprise=$false }
    if($entreprise) { $community=$false }
    
    # install visual studio code
    if($community)              { Install-ChocoApp VisualStudio2017Community }
    if($entreprise)             { Install-ChocoApp visualstudio2017enterprise }

    if($azure)                  { Install-ChocoApp visualstudio2017-workload-azure }
    if($data)                   { Install-ChocoApp visualstudio2017-workload-data }
    if($manageddesktop)         { Install-ChocoApp visualstudio2017-workload-manageddesktop }
    if($managedgame)            { Install-ChocoApp visualstudio2017-workload-managedgame }
    if($nativecrossplat)        { Install-ChocoApp visualstudio2017-workload-nativecrossplat }
    if($nativedesktop)          { Install-ChocoApp visualstudio2017-workload-nativedesktop }
    if($nativegame)             { Install-ChocoApp visualstudio2017-workload-nativegame }
    if($nativemobile)           { Install-ChocoApp visualstudio2017-workload-nativemobile }
    if($netcoretools)           { Install-ChocoApp visualstudio2017-workload-netcoretools }
    if($netcrossplat)           { Install-ChocoApp visualstudio2017-workload-netcrossplat }
    if($netweb)                 { Install-ChocoApp visualstudio2017-workload-netweb }
    if($node)                   { Install-ChocoApp visualstudio2017-workload-node }
    if($office)                 { Install-ChocoApp visualstudio2017-workload-office }
    if($universal)              { Install-ChocoApp visualstudio2017-workload-universal }
    if($visualstudioextension)  { Install-ChocoApp visualstudio2017-workload-visualstudioextension }
    if($webcrossplat)           { Install-ChocoApp visualstudio2017-workload-webcrossplat }
     
    # Pin to task bar
    if($community) {
        Install-ChocolateyPinnedTaskBarItem "${env:ProgramFiles(x86)}\Microsoft Visual Studio\2017\Community\Common7\IDE\devenv.exe"
    }
    if($entreprise) {
        Install-ChocolateyPinnedTaskBarItem "${env:ProgramFiles(x86)}\Microsoft Visual Studio\2017\Enterprise\Common7\IDE\devenv.exe"
    }
}