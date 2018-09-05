function Install-ChocoApp
{
    <#
    .SYNOPSIS
    Use this function to install chocolatey package.
    If the package already exist it will be upgraded

    .PARAMETER Name
    Package to install.
    #>

    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true, Position=0)]
        [String]$Name,

        [switch]$RefreshEnv
    )

    if( [string]::IsNullOrEmpty( $(chocolatey list -localonly -r | Where-Object {($_ -split "\|")[0] -like $Name}) ) ) {
        choco install $Name --yes --limitoutput
    }
    else {
        choco upgrade $Name --yes --limitoutput
    }

    # Updates the environment variables of the current powershell session
    if($RefreshEnv) {
        Update-SessionEnvironment
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