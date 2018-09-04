function Set-Option
{
    <#
    .SYNOPSIS
    Store the option in environnement variable.

    .PARAMETER Option
    Name of the option to add/set.

    .PARAMETER Value
    Data assigned to the option.
    #>

    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true, Position=0)]
        [String]$Option,

        [Parameter(Mandatory=$true, Position=1)]
        [String]$Value
    )

    Set-EnvironmentVariable $Option $Value 'Machine'
    Set-EnvironmentVariable $Option $Value 'Process'
}

function Set-DefaultOption
{
    <#
    .SYNOPSIS
    Define an option as default.
    Store the option in environnement variable, but if
    the option already exist, it will not be overwritten.

    .PARAMETER Option
    Name of the option to add/set.

    .PARAMETER Value
    Data assigned to the option.
    #>

    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true, Position=0)]
        [String]$Option,

        [Parameter(Mandatory=$true, Position=1)]
        [String]$Value
    )

    if($null -eq (Get-Option $Option)) {
        Set-Option $Option $Value;
    }
}

function Get-Option
{
    <#
    .SYNOPSIS
    Get an option value.

    .PARAMETER Option
    Name of the option to get.
    #>

    [CmdletBinding()]
    [OutputType([String])]
    param(
        [Parameter(Mandatory=$true, Position=0)]
        [String]$Option
    )

    return Get-EnvironmentVariable $Option 'Machine'
}

function Get-OptionBool
{
    <#
    .SYNOPSIS
    Get an option value as boolean.

    .PARAMETER Option
    Name of the option to get.
    #>

    [CmdletBinding()]
    [OutputType([Boolean])]
    param(
        [Parameter(Mandatory=$true, Position=0)]
        [String]$Option
    )

    $Value = Get-Option $Option
    if($null -eq $Value) {
        return $false;
    }

    return [System.Convert]::ToBoolean($Value)
}

function Remove-Option
{
    <#
    .SYNOPSIS
    Remove an option.

    .PARAMETER Option
    Name of the option to remove.
    #>

    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true, Position=0)]
        [String]$Option
    )

    Remove-EnvironmentVariable $Option 'Machine'
    Remove-EnvironmentVariable $Option 'Process'
}

function Confirm-Install
{
    <#
    .SYNOPSIS
    Check if an install has to be done, base on the option value.

    .PARAMETER Option
    Name of the option to test.
    #>

    [CmdletBinding()]
    [OutputType([Boolean])]
    param(
        [Parameter(Mandatory=$true, Position=0)]
        [String]$Option
    )

    $Value = Get-Option $Option
    if($null -eq $Value) {
        return $true;
    }

    return [System.Convert]::ToBoolean($Value)
}