# Scripts location
$sRoot="#SCRIPT_PATH#"

# Define the import function
Function Import-Function {
    <#
    .SYNOPSIS
    Dote source a local file or a web file.
    .PARAMETER Path
    Parth to the file. The path can point to a local file or web file.
    .PARAMETER Credential
    Used to acces the web file when behind a proxy.
    #>
    param(
        [String]$Path,
        [PSCredential]$Credential
	  )

    # Check if path is an url
    [String]$urlRegex = '(http[s]?)(:\/\/)([^\s,]+)(.ps1)'
    [bool]$isUrl = $Path -match $urlRegex

    # Get the script content from the web
    if($isUrl -eq $true) {
        # Create the Web Client object
        $webclient = New-Object System.Net.WebClient

        # Tell it to use our default creds for the proxy
        if($Credential -eq $null) {
            $webclient.Proxy.Credentials = [System.Net.CredentialCache]::DefaultNetworkCredentials
        }
        # Tell it to use the provided credential
        else {
            $webclient.Proxy.Credentials = $Credential
        }

        # Define the TLS versions to use
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 -bor [Net.SecurityProtocolType]::Tls1

        # Download the script file
        $script = $webclient.DownloadString($Path)
    }

    # Get the script content from the local storage
    else {
        $script = (Get-Content $Path) -join [environment]::newline
    }

    # Dot source the functions as global function
    if([String]::IsNullOrEmpty($script) -eq $false) {
        $script = $script -replace '(?m)^function\s+((?!global[:]|local[:]|script[:]|private[:])[\w-]+)', 'function Global:$1'
        . ([scriptblock]::Create($script))
    }
}

# Defautl import
Import-Function -Path "$sRoot/helpers/function/EnvironmentVariable.ps1"
Import-Function -Path "$sRoot/helpers/function/Options.ps1"
Import-Function -Path "$sRoot/helpers/function/OsInformation.ps1"
Import-Function -Path "$sRoot/helpers/function/Registry.ps1"
Import-Function -Path "$sRoot/helpers/function/Chocolatey.ps1"
