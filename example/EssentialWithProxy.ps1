#Requires -version 3
#Requires -RunAsAdministrator

# Clear output console
Clear-Host

# Clean the powershell session
Get-PSSession | Remove-PSSession

# Proxy credentials
$webclient = New-Object System.Net.webclient
$webclient.Proxy.Credentials = [System.Net.CredentialCache]::DefaultNetworkCredentials

# Change the current process policy to Unrestricted
Set-ExecutionPolicy Unrestricted -Scope Process -Force

# Profiles to install
$profiles = @(
    #'Essential',
    'DevCore'#,
    #'DevWindows',
    #'DevJava'
)

# Define options
$options = @(
    'Boxstarter::Begin=false',
    'Boxstarter::WindowsUpdate=false',
    'Boxstarter::DevCore::VisualStudioCodeExtensions::Extensions=ms-vscode.PowerShell,bibhasdn.git-easy'
)

# Download my boxstarter bootstrap
Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/AbsCoDes/boxstarter/master/boxstarter.ps1' -OutFile "$($env:temp)\boxstarter.ps1"

# Start the setup process
&Invoke-Command -ScriptBlock {
    $webclient = New-Object System.Net.webclient
    $webclient.Proxy.Credentials = [System.Net.CredentialCache]::DefaultNetworkCredentials
    &"$($env:temp)\boxstarter.ps1" -profiles $profiles -options $options
}

