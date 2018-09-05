#requires -version 3
#Requires -RunAsAdministrator

Param (
    # Profile to install
    [String[]]$Profiles=$null,

    # Options to use during install
    [String[]]$Options=$null,

    # Add your personnal boxstarter scripts
    [String[]]$Scripts=$null
)

#--- [Declarations] ---------------------------------------------------------------------------------------------------
# Script infos
$global:sVersion = '1.0'
$global:sName = "boxstarter"
# Script Path
$global:sRoot = 'https://raw.githubusercontent.com/AbsCoDes/boxstarter/master/'
#----------------------------------------------------------------------------------------------------------------------


#--- [Functions] ------------------------------------------------------------------------------------------------------
Function Import-File {
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

    return $script
}
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

    $script = Import-File -Path $Path -Credential $Credential

    # Dot source the functions as global function
    if([String]::IsNullOrEmpty($script) -eq $false) {
        $script = $script -replace '(?m)^function\s+((?!global[:]|local[:]|script[:]|private[:])[\w-]+)', 'function Global:$1'
        . ([scriptblock]::Create($script))
    }
}
#----------------------------------------------------------------------------------------------------------------------


#--- [Import] ---------------------------------------------------------------------------------------------------------
Import-Function -Path "$sRoot/helpers/function/EnvironmentVariable.ps1"
Import-Function -Path "$sRoot/helpers/function/HasteBin.ps1"
Import-Function -Path "$sRoot/helpers/function/Options.ps1"
#----------------------------------------------------------------------------------------------------------------------


#--- [Execution] ------------------------------------------------------------------------------------------------------

  # Define all options used during install
  if(!($null -eq $Options)) {
    foreach ($option in $Options) {
        [String]$Key,[String]$Value=$option.split('= ')
        Set-Option $Key $Value
    }
  }

  # Install scripts to use with boxstarter
  $installScript = @()
  $installScript += Import-File -Path "$sRoot/helpers/profile/Import.ps1"

  # Add profiles to install scripts
  if(!($null -eq $Profiles)) {
    $installScript += Import-File -Path "$sRoot/helpers/profile/Begin.ps1"
    $installScript += ($Profiles | ForEach-Object {Import-File -Path "$sRoot/profile/$_.ps1"})
    $installScript += Import-File -Path "$sRoot/helpers/profile/End.ps1"
  }

  # Add personnal boxstarter scripts
  if(!($null -eq $Scripts)) {
    $installScript += ($Scripts | ForEach-Object {Import-File -Path "$_"})
  }

  # Rename #SCRIPT_PATH#
  $installScript = $installScript -replace "#SCRIPT_PATH#", $sRoot

  # Create a haste bin file to give to boxstarter
  # To use any credential in your scipt
  $installScriptUrl = Out-HasteBin $($installScript -join [environment]::newline)

  # Get login credential for reboot
  $userCredential = Get-Credential -UserName $env:username -Message "Enter the login that will be used on reboot"

  # Launch boxstarter
  . { Invoke-WebRequest -useb http://boxstarter.org/bootstrapper.ps1 } | Invoke-Expression; get-boxstarter -Force
  Install-BoxstarterPackage -PackageName $installScriptUrl -Credential $userCredential

  #----------------------------------------------------------------------------------------------------------------------