#Requires -version 3
#Requires -RunAsAdministrator

# Clear output console
Clear-Host

# Clean the powershell session
Get-PSSession | Remove-PSSession

# Change the current process policy to Unrestricted
Set-ExecutionPolicy Unrestricted -Scope Process -Force

# Profiles to install
$profiles = @(
    'Essential'
)

# Define options
$options = @(
    'Boxstarter::WindowsUpdate=false'
)

# Download my boxstarter bootstrap
Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/AbsCoDes/boxstarter/master/boxstarter.ps1' -OutFile "$($env:temp)\boxstarter.ps1"

# Start the setup process
&Invoke-Command -ScriptBlock {
    &"$($env:temp)\boxstarter.ps1" -profiles $profiles -options $options
}
