

# Don't want to use those default parameters
# just add this option to the starter script
#
#       Boxstarter::End=false
#

# Restore temporary settings
Enable-UAC
if(Test-PendingReboot) { Invoke-Reboot }

#
if(Confirm-Install 'Boxstarter::End')
{
    # Install Windows update
    if(Confirm-Install 'Boxstarter::WindowsUpdate') {
        Start-UpdateServices
        Install-WindowsUpdate -AcceptEula
        if(Test-PendingReboot) { Invoke-Reboot }
    }


    # Cleanup
    Remove-Item -Recurse -Force -ErrorAction SilentlyContinue "C:\eula*.txt"
    Remove-Item -Recurse -Force -ErrorAction SilentlyContinue "C:\install*"
    Remove-Item -Recurse -Force -ErrorAction SilentlyContinue "C:\vcredist*"
    Remove-Item -Recurse -Force -ErrorAction SilentlyContinue "C:\vc_red*"
}

# Clean environnement variables
foreach($var in Get-EnvironmentVariableNames('Machine')) {
    $toRemove = $var.StartsWith("Boxstarter::")
    if($toRemove) {
        Remove-EnvironmentVariable $var 'Machine'
    }
}
foreach($var in Get-EnvironmentVariableNames('User')) {
    $toRemove = $var.StartsWith("Boxstarter::")
    if($toRemove) {
        Remove-EnvironmentVariable $var 'User'
    }
}
