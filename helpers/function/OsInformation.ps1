
function Get-OSInformation
{
    <#
    .SYNOPSIS
    Get OS informations.
    #>

    $osInfo = Get-WmiObject -class Win32_OperatingSystem | Select-Object -First 1

    return ConvertFrom-String -Delimiter \. -PropertyNames Major, Minor, Build  $osInfo.version
}

function Get-IsOSWindows10
{
    <#
    .SYNOPSIS
    Test if OS is windows 10.
    #>

    $osInfo = Get-OSInformation

    return $osInfo.Major -eq 10
}

function Get-SystemDrive
{
    <#
    .SYNOPSIS
    Get the system drive.
    #>

    return $env:SystemDrive[0]
}