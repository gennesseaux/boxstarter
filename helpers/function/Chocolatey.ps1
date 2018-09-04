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
        [String]$Name
    )

    if( [string]::IsNullOrEmpty( $(chocolatey list -localonly -r | where {($_ -split "\|")[0] -like $Name}) ) ) {
        choco install $Name --limitoutput
    }
    else {
        choco upgrade $Name --limitoutput
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
        choco install $Feature --source windowsfeatures --limitoutput
    }
    else {
        choco upgrade $Feature --source windowsfeatures --limitoutput
    }

    if(Test-PendingReboot) { Invoke-Reboot }
}