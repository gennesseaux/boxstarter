function Set-Registry
{
    <#
    .SYNOPSIS
    Define a registry value.
    If the path does not exit, it will be created.

    .PARAMETER Path
    The path to the registry key where the value should be set. Will be created if it doesn't exist.

    .PARAMETER Name
    The name of the value being set.

    .PARAMETER Type
    Type of data to store.
    Can be one of: String, DWord, Binary, ExpandString, MultiString, None, QWord, Unknown

    .PARAMETER Value
    Value to store.
    #>

    [CmdletBinding()]
    param(

        [Parameter(Mandatory=$true, Position=0)]
        [String]$Path,

        [Parameter(Mandatory=$true, Position=1)]
        [String]$Name,

        [Parameter(Mandatory=$true, Position=2)]
        [ValidateSet('String','DWord','Binary','ExpandString','MultiString','None','QWord','Unknown')]
        [String]$Type,

        [Parameter(Mandatory=$true, Position=3)]
        [Object]$Value
    )

    if(-Not (Test-Path $Path)) {
        New-Item -Path $Path -ItemType Directory -Force | Out-Null
    }

    Set-ItemProperty -Path $Path -Name $Name -Type $Type -Value $Value
}

function Remove-Registry
{
    <#
    .SYNOPSIS
    Removes a value from a registry key, if it exists.

    .PARAMETER Path
    The path to the registry key where the value should be removed.

    .PARAMETER Name
    The name of the value to remove.
    #>

    [CmdletBinding()]
    param(

        [Parameter(Mandatory=$true, Position=0)]
        [String]$Path,

        [Parameter(Position=1)]
        [String]$Name
    )

    if(Test-Path $Path) {
        if($Name -eq $null) {
            Remove-Item -Path $path -Confirm
        }
        else {
            Remove-ItemProperty -Path $Path -Name $Name -Confirm
        }
    }
}
