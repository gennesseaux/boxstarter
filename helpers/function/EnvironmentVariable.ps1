function Set-EnvironmentVariable
{
    #
    # Define an environment variable
    #
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true, Position=0)]
        [String]$variable,

        [Parameter(Mandatory=$true, Position=1)]
        [String]$value,

        [Parameter(Mandatory=$true, Position=2)]
        [ValidateSet('Machine', 'User', 'Process')]
        [String]$target
    )

    if($target -eq 'Process') {
        Set-Item "env:\$variable" "$value"
    }
    else {
        [Environment]::SetEnvironmentVariable("$variable", "$value", $target)
    }
}

function Get-EnvironmentVariable
{
    #
    # Get an environment variable
    #
    [CmdletBinding()]
    [OutputType([String])]
    param(
        [Parameter(Mandatory=$true, Position=0)]
        [string]$variable,

        [Parameter(Mandatory=$true, Position=1)]
        [ValidateSet('Machine', 'User', 'Process')]
        [String]$target
    )

    if($target -eq 'Process') {
        Get-Item "env:$variable"
    }
    else {
        [Environment]::GetEnvironmentVariable("$variable", $target)
    }
}

function Get-EnvironmentVariableNames {
    #
    # Get an environment variables
    #
    [CmdletBinding()]
    [OutputType([String])]
    param(
        [Parameter(Mandatory=$true, Position=0)]
        [ValidateSet('Machine', 'User', 'Process')]
        [String]$target
    )
    
    switch ($target) {
        'User' { Get-Item 'HKCU:\Environment' | Select-Object -ExpandProperty Property }
        'Machine' { Get-Item 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Environment' | Select-Object -ExpandProperty Property }
        'Process' { Get-ChildItem Env:\ | Select-Object -ExpandProperty Key }
    }
}

function Remove-EnvironmentVariable
{
    #
    # Remove an environment variable
    #
   [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true, Position=0)]
        [string]$variable,

        [Parameter(Mandatory=$true, Position=1)]
        [ValidateSet('Machine', 'User', 'Process')]
        [String]$target
    )

    if($target -eq 'Process') {
        Set-Item "env:$variable" $null
    }
    else {
        [Environment]::SetEnvironmentVariable("$variable", $null, $target)
    }
}