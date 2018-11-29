function Install-ChocoApp
{
    <#
    .SYNOPSIS
    Use this function to install chocolatey package.
    If the package already exist it will be upgraded

    .PARAMETER Name
    Package to install.

    .PARAMETER Params
    Parameters to pass to the package.

    .PARAMETER RefreshEnv
    Update environment variables without restarting the shell.

    .PARAMETER NoUpgrade
    Pin a package to suppress upgrades.
    #>

    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true, Position=0)]
        [String]$Name,

        [alias("p","parameters","pkgParams")]
        [string]$Params = '',

        [alias("r","refresh")]
        [switch]$RefreshEnv,

        [alias("pin")]
        [switch]$NoUpgrade
    )

    # Workaround choco / boxstarter path too long error
    $ChocoCachePath = "$env:USERPROFILE\AppData\Local\Temp\chocolatey"
    New-Item -Path $ChocoCachePath -ItemType Directory -Force

    if( [string]::IsNullOrEmpty( $(choco list --local-only --limitoutput | Where-Object {($_ -split "\|")[0] -like $Name}) ) ) {
        choco install $Name --params $Params --yes --limitoutput --cacheLocation="$ChocoCachePath"
    }
    else {
        choco upgrade $Name --params $Params --yes --limitoutput --cacheLocation="$ChocoCachePath"
    }

    # Updates the environment variables of the current powershell session
    if($RefreshEnv) {
        Update-SessionEnvironment
    }

    # Updates the environment variables of the current powershell session
    if($NoUpgrade) {
        choco pin add -n="$Name" --cacheLocation="$ChocoCachePath"
    }

    # Update path
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")

    if(Test-PendingReboot) { Invoke-Reboot }
}

function Install-ChocoWindowsFeature
{
    <#
    .SYNOPSIS
    Use this function to install windows feature.

    .PARAMETER Name
    Feature to install.
    #>

    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true, Position=0)]
        [String]$Feature
    )

    if( [string]::IsNullOrEmpty( $(chocolatey list -localonly -r | Where-Object {($_ -split "\|")[0] -like $Name}) ) ) {
        choco install $Feature --source windowsfeatures --yes --limitoutput --cacheLocation="$ChocoCachePath"
    }
    else {
        choco upgrade $Feature --source windowsfeatures --yes --limitoutput --cacheLocation="$ChocoCachePath"
    }

    if(Test-PendingReboot) { Invoke-Reboot }
}