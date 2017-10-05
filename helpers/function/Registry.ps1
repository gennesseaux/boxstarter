function Set-Registry
{
    #
    # Define a registry value.
    # If the path does not exit, it will be created
    #
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
    
    If (-Not (Test-Path $Path)) {
        New-Item -Path $Path -ItemType Directory -Force | Out-Null
    }

    Set-ItemProperty -Path $Path -Name $Name -Type $Type -Value $Value
}

function Remove-Registry
{
    #
    # Define a registry value.
    # If the path does not exit, it will be created
    #
    [CmdletBinding()]
    param(
        
        [Parameter(Mandatory=$true, Position=0)]
        [String]$Path,

        [Parameter(Position=1)]
        [String]$Name
    )
    
    If (Test-Path $Path) {
        if($Name -eq $null) {
            Remove-Item -Path $path -Confirm
        }
        else {
            Remove-ItemProperty -Path $Path -Name $Name -Confirm
        }
    }
}
