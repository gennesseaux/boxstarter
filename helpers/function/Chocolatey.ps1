function Install-ChocoApp
{
    #
    # Use this function to install chocolatey package
    #
    # If the package already exist it will be upgraded 
    #
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true, Position=0)]
        [String]$name
    )

    if( [string]::IsNullOrEmpty( $(chocolatey list -localonly -r | where {($_ -split "\|")[0] -like $name}) ) ) {
        choco install $name --limitoutput
    }
    else { 
        choco upgrade $name --limitoutput
    }

    # Update path
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")

    if (Test-PendingReboot) { Invoke-Reboot }
}

function Install-ChocoWindowsFeature
{
    #
    # Use this function to install windows feature
    #
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true, Position=0)]
        [String]$feature
    )

    if( [string]::IsNullOrEmpty( $(chocolatey list -localonly -r | where {($_ -split "\|")[0] -like $name}) ) ) {
        choco install $feature --source windowsfeatures --limitoutput
    }
    else { 
        choco upgrade $feature --source windowsfeatures --limitoutput
    }

    if (Test-PendingReboot) { Invoke-Reboot }
}