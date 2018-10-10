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

    if( [string]::IsNullOrEmpty( $(choco list --local-only --limitoutput | Where-Object {($_ -split "\|")[0] -like $Name}) ) ) {
        choco install $Name --params $Params --yes --limitoutput
    }
    else {
        choco upgrade $Name --params $Params --yes --limitoutput
    }

    # Updates the environment variables of the current powershell session
    if($RefreshEnv) {
        Update-SessionEnvironment
    }

    # Updates the environment variables of the current powershell session
    if($NoUpgrade) {
        choco pin add -n="$Name"
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
        choco install $Feature --source windowsfeatures --yes --limitoutput
    }
    else {
        choco upgrade $Feature --source windowsfeatures --yes --limitoutput
    }

    if(Test-PendingReboot) { Invoke-Reboot }
}