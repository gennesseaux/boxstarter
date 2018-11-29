#Requires -version 3
#Requires -RunAsAdministrator

# Clear output console
Clear-Host

# Change the current process policy to Unrestricted
Set-ExecutionPolicy Unrestricted -Scope Process -Force

# Proxy parameters
$proxyAdress = "http://proxy.adress:port"
$proxyUser = "Domaine\username"
$proxyPassword = "password"
$webProxy = New-Object System.Net.WebProxy($proxyAdress, $true)

# Web client
$webClient = New-Object System.Net.WebClient
$webclient.Proxy = $webProxy
$webclient.Proxy.Credentials = New-Object System.Net.NetworkCredential($proxyUser, $proxyPassword)

# Install chocolatey prior to boxstarter
$env:chocolateyProxyLocation = $proxyAdress
$env:chocolateyProxyUser = $proxyUser
$env:chocolateyProxyPassword = $proxyPassword
Invoke-Expression ($webclient.DownloadString('https://chocolatey.org/install.ps1'))
# Set Proxy for package download
choco config set proxy $env:chocolateyProxyLocation
choco config set proxyUser $env:chocolateyProxyUser
choco config set proxyPassword $env:chocolateyProxyPassword

# Profiles to install
$profiles = @(
    'Essential'
    #'Tools'
    #'DevCore'
    #'DevJava'
)

# Define options
$options = @(
    'Boxstarter::Begin=true'
    'Boxstarter::Begin::WindowsUpdate=false'

    'Boxstarter::End=true'
    'Boxstarter::End::WindowsUpdate=false'

    'Boxstarter::Essential::Privacy=true'
    'Boxstarter::Essential::Security=true'
    'Boxstarter::Essential::Service=true'
    'Boxstarter::Essential::UI=true'
    'Boxstarter::Essential::UI-Preferences=true'
    'Boxstarter::Essential::Application=true'
    'Boxstarter::Essential::RemoteDesktop=true'
    'Boxstarter::Essential::InternetExplorerESC=true'
    'Boxstarter::Essential::TaskbarOptions=true'
    'Boxstarter::Essential::CornerNavigationOptions=true'
    'Boxstarter::Essential::Windows-Update=true'
    'Boxstarter::Essential::Remove-Apps=true'

    'Boxstarter::DevCore::VisualStudioCodeExtensions::Extensions=ms-vscode.PowerShell,bibhasdn.git-easy'
)

# User scripts
$scripts = @(
)

# Packages
$packages = @(
)

# Download my boxstarter bootstrap
$webClient.DownloadFile('https://raw.githubusercontent.com/AbsCoDes/boxstarter/master/boxstarter.ps1', "$($env:temp)\boxstarter.ps1")

# Start the setup process
&Invoke-Command -ScriptBlock {
    &"$($env:temp)\boxstarter.ps1" -profiles $profiles -options $options -scripts $scripts -packages $packages -webClient $webClient
}

