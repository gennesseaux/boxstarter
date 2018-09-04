function Install-VisualStudio2017
{
    param(
        # Visual Studio 2017 Community
        [switch]$Community,
        # Visual Studio 2017 Enterprise
        [switch]$Entreprise,

        # Azure development
        [switch]$Azure,
        # Data storage and processing
        [switch]$Data,
        # .NET desktop dev.
        [switch]$ManagedDesktop,
        # Game dev. with Unity
        [switch]$ManagedGame,
        # Linux dev. with C++
        [switch]$NativeCrossPlat,
        # Desktop dev. with C++
        [switch]$NativeDesktop,
        # Game dev. with C++
        [switch]$NativeGame,
        # Mobile dev. with C++
        [switch]$NativeMobile,
        # .NET Core cross-platform dev.
        [switch]$NetCoreTools,
        # Mobile dev. with .NET
        [switch]$NetCrossPlat,
        # ASP.NET and web dev.
        [switch]$NetWeb,
        # Node.js dev.
        [switch]$Node,
        # Office/SharePoint dev.
        [switch]$Office,
        # Universal Windows Platform dev.
        [switch]$Universal,
        # Visual Studio extension dev.
        [switch]$VisualStudioExtension,
        # Mobile dev. with JavaScript
        [switch]$WebCrossPlat
    )

    #
    if($Community)  { $Entreprise=$false }
    if($Entreprise) { $Community=$false }

    # install visual studio code
    if($Community)              { Install-ChocoApp VisualStudio2017Community }
    if($Entreprise)             { Install-ChocoApp visualstudio2017enterprise }

    if($Azure)                  { Install-ChocoApp visualstudio2017-workload-azure }
    if($Data)                   { Install-ChocoApp visualstudio2017-workload-data }
    if($ManagedDesktop)         { Install-ChocoApp visualstudio2017-workload-manageddesktop }
    if($ManagedGame)            { Install-ChocoApp visualstudio2017-workload-managedgame }
    if($NativeCrossPlat)        { Install-ChocoApp visualstudio2017-workload-nativecrossplat }
    if($NativeDesktop)          { Install-ChocoApp visualstudio2017-workload-nativedesktop }
    if($NativeGame)             { Install-ChocoApp visualstudio2017-workload-nativegame }
    if($NativeMobile)           { Install-ChocoApp visualstudio2017-workload-nativemobile }
    if($NetCoreTools)           { Install-ChocoApp visualstudio2017-workload-netcoretools }
    if($NetCrossPlat)           { Install-ChocoApp visualstudio2017-workload-netcrossplat }
    if($NetWeb)                 { Install-ChocoApp visualstudio2017-workload-netweb }
    if($Node)                   { Install-ChocoApp visualstudio2017-workload-node }
    if($Office)                 { Install-ChocoApp visualstudio2017-workload-office }
    if($Universal)              { Install-ChocoApp visualstudio2017-workload-universal }
    if($VisualStudioExtension)  { Install-ChocoApp visualstudio2017-workload-visualstudioextension }
    if($WebCrossPlat)           { Install-ChocoApp visualstudio2017-workload-webcrossplat }

    # Pin to task bar
    if($Community) {
        Install-ChocolateyPinnedTaskBarItem "${env:ProgramFiles(x86)}\Microsoft Visual Studio\2017\Community\Common7\IDE\devenv.exe"
    }
    if($Entreprise) {
        Install-ChocolateyPinnedTaskBarItem "${env:ProgramFiles(x86)}\Microsoft Visual Studio\2017\Enterprise\Common7\IDE\devenv.exe"
    }
}