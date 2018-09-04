function Set-EnvironmentVariable
{
    <#
    .SYNOPSIS
    Sets an envrionment variable

    .PARAMETER Variable
    Name of the environment variable to add/set.

    .PARAMETER Value
    Data assigned to the environment variable.

    .PARAMETER Scope
    Can be: Machine, User or Process.
    #>

    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true, Position=0)]
        [String]$Variable,

        [Parameter(Mandatory=$true, Position=1)]
        [String]$Value,

        [Parameter(Mandatory=$true, Position=2)]
        [ValidateSet('Machine', 'User', 'Process')]
        [String]$Scope
    )

    if($Scope -eq 'Process') {
        Set-Item "env:\$Variable" "$Value"
    }
    else {
        [Environment]::SetEnvironmentVariable("$Variable", "$Value", $Scope)
    }
}

function Get-EnvironmentVariable
{
    <#
    .SYNOPSIS
    Gets an environment variable value.

    .PARAMETER Variable
    Name of environment variable.

    .PARAMETER Scope
    Can be: Machine, User or Process.
    #>

    [CmdletBinding()]
    [OutputType([String])]
    param(
        [Parameter(Mandatory=$true, Position=0)]
        [string]$Variable,

        [Parameter(Mandatory=$true, Position=1)]
        [ValidateSet('Machine', 'User', 'Process')]
        [String]$Scope
    )

    if($Scope -eq 'Process') {
        Get-Item "env:$Variable"
    }
    else {
        [Environment]::GetEnvironmentVariable("$Variable", $Scope)
    }
}

function Get-EnvironmentVariableNames
{
    <#
    .SYNOPSIS
    List all environment variables for a specified scope.

    .PARAMETER Scope
    Can be: Machine, User or Process.
    #>

    [CmdletBinding()]
    [OutputType([String])]
    param(
        [Parameter(Mandatory=$true, Position=0)]
        [ValidateSet('Machine', 'User', 'Process')]
        [String]$Scope
    )

    switch ($Scope) {
        'User' { Get-Item 'HKCU:\Environment' | Select-Object -ExpandProperty Property }
        'Machine' { Get-Item 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Environment' | Select-Object -ExpandProperty Property }
        'Process' { Get-ChildItem Env:\ | Select-Object -ExpandProperty Key }
    }
}

function Remove-EnvironmentVariable
{
    <#
    .SYNOPSIS
    Remove an environment variable.

    .PARAMETER Variable
    Name of the environment variable to remove.

    .PARAMETER Scope
    Can be: Machine, User or Process.
    #>

    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true, Position=0)]
        [string]$Variable,

        [Parameter(Mandatory=$true, Position=1)]
        [ValidateSet('Machine', 'User', 'Process')]
        [String]$Scope
    )

    if($Scope -eq 'Process') {
        Set-Item "env:$Variable" $null
    }
    else {
        [Environment]::SetEnvironmentVariable("$Variable", $null, $Scope)
    }
}