function Set-Option
{
    #
    # Store the option in environnement variable
    #
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true, Position=0)]
        [String]$option,

        [Parameter(Mandatory=$true, Position=1)]
        [String]$value
    )

    Set-EnvironmentVariable $option $value 'Machine'
    Set-EnvironmentVariable $option $value 'Process'
}

function Set-DefaultOption
{
    #
    # Define a default option.
    # If the option already exist, then the option will not be overwritten
    #
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true, Position=0)]
        [String]$option,

        [Parameter(Mandatory=$true, Position=1)]
        [String]$value
    )

    if((Get-Option $option) -eq $null) {
        Set-Option $option $value;
    }
}

function Get-Option
{
    #
    # Get an option value
    #
    [CmdletBinding()]
    [OutputType([String])]
    param(
        [Parameter(Mandatory=$true, Position=0)]
        [String]$option
    )

    return Get-EnvironmentVariable $option 'Machine'
}

function Get-OptionBool
{
    #
    # Get an option value as boolean
    #
    [CmdletBinding()]
    [OutputType([Boolean])]
    param(
        [Parameter(Mandatory=$true, Position=0)]
        [String]$option
    )

    $value = Get-Option $option
    if($value -eq $null) {
        return $false;
    }

    return [System.Convert]::ToBoolean($value)
}

function Remove-Option
{
    #
    # Remove an option
    #
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true, Position=0)]
        [String]$option
    )

    Remove-EnvironmentVariable $option 'Machine'
    Remove-EnvironmentVariable $option 'Process'
}

function Confirm-Install
{
    #
    # Check if an install has to be done, base on the option value
    #
    [CmdletBinding()]
    [OutputType([Boolean])]
    param(
        [Parameter(Mandatory=$true, Position=0)]
        [String]$option
    )

    $value = Get-Option $option
    if($value -eq $null) {
        return $true;
    }
    
    return [System.Convert]::ToBoolean($value)
}