# This profile will install:
#     - Microsoft-Hyper-V-All
#     - Microsoft-Windows-Subsystem-Linux
#     - LxRunOffline
#     - cygwin
#     - wsltty
#     - weasel-pageant

## Credits
#
#  Much of the configuration is taken from Simon Holywell, Windows-Boxstarter-with-WSL-Ubuntu repository :
#  https://github.com/treffynnon/Windows-Boxstarter-with-WSL-Ubuntu

#--- [Import] ---------------------------------------------------------------------------------------------------------
Import-Function -WebClient $webclient -Path "$sRoot/helpers/function/Decrypt-String.ps1"
Import-Function -WebClient $webclient -Path "$sRoot/helpers/function/EnvironmentVariable.ps1"
Import-Function -WebClient $webclient -Path "$sRoot/helpers/function/OsInformation.ps1"
#----------------------------------------------------------------------------------------------------------------------


# Get proxy info
$proxyLocation = Get-EnvironmentVariable chocolateyProxyLocation 'User'
$proxyUser = Get-EnvironmentVariable chocolateyProxyUser 'User'
$proxyPassword = Decrypt-String (Get-EnvironmentVariable chocolateyProxyPassword 'User')


if(Confirm-Install 'Boxstarter::WSL') {

    # Windows 10 is required
    if(! (Get-IsOSWindows10)) {
        Write-Error 'Upgrade to Windows 10 before running this script'
        return
    }

    # Windows 10 - 1803 is required
    if((Get-OSReleaseId) -lt 1803) {
        Write-Error 'You need to run Windows Update and install Feature Updates to at least version 1803'
        return
    }

    # 64-bit Windows
    if (-not [Environment]::Is64BitOperatingSystem) {
        Write-Error "This package requires a 64-bit Windows."
        return
    }

    #--- Enable hyper-V
    Install-ChocoWindowsFeature Microsoft-Hyper-V-All

    #--- Enable Windows Subsystem for Linux
    Install-ChocoApp wsl

    #--- Install lxrunoffline
    Install-ChocoApp lxrunoffline -RefreshEnv
    $tools_path = Get-ToolsLocation
    $lxrun_path = join-path $tools_path 'lxrunoffline'
    if(Test-Path $lxrun_path) {
        Add-Path $lxrun_path
        Update-SessionEnvironment
    }

    #--- Install Ubuntu 18.04
    Install-ChocoApp wsl-ubuntu-1804

    #--- X server ---
    Install-ChocoApp cyg-get -RefreshEnv        # install cygwin
    cyg-get xorg-server xinit                   # install cygwin/x

    #--- Decent bash/WSL terminal - wsltty
    Install-ChocoApp wsltty

    # Finish wsltty setup by setting up shortcuts
    $wsl_gen_short = 'C:\ProgramData\Microsoft\Windows\Start Menu\Programs\WSL Generate Shortcuts.lnk'
    if(Test-Path $wsl_gen_short) {
        Invoke-Item $wsl_gen_short
    }

    # Install Hack font used in wsltty
    Install-ChocoApp hackfont

    # Update wsl proxy
    if( ! ([string]::IsNullOrEmpty($proxyLocation) -and [string]::IsNullOrEmpty($proxyUser)  -and [string]::IsNullOrEmpty($proxyPassword) ) ) {
        $proxyport = $proxyLocation.Substring($proxyLocation.LastIndexOf('/')+1)
        $proxy = $proxyport.Substring(0, $proxyport.LastIndexOf(':'))
        $port = $proxyport.Substring($proxyport.LastIndexOf(':')+1)
        $user = $proxyUser.Substring($proxyUser.LastIndexOf('\')+1)
        $http_proxy = "http://${user}:${proxyPassword}@${proxy}:${port}"

        wsl sudo bash -c "echo export http_proxy=$http_proxy >> /etc/environment"
        wsl sudo bash -c "echo export https_proxy=$http_proxy >> /etc/environment"
        wsl sudo bash -c "echo export ftp_proxy=$http_proxy >> /etc/environment"
    }

    # Configure wsltty
    Get-WebFile -url 'https://raw.githubusercontent.com/treffynnon/Windows-Boxstarter-with-WSL-Ubuntu/master/config_files/wsltty/paraiso_dark.mintty' -fileName "$env:APPDATA\wsltty\themes"
    Get-WebFile -url 'https://raw.githubusercontent.com/treffynnon/Windows-Boxstarter-with-WSL-Ubuntu/master/config_files/wsltty/config' -fileName "$env:APPDATA\wsltty\config"

    # Setup weasel-pageant
    $url = 'https://github.com/vuori/weasel-pageant/releases/download/v1.4/weasel-pageant-1.4.zip'
    $archive = "$($env:temp)\weasel-pageant-1-4.zip"
    if(!(Test-Path $archive)) {

        Get-WebFile -url $url -fileName $archive

        if(Test-Path "$archive") {
            $zipfile = Get-Item "$archive"
            Write-Host "[installer.weasel-pageant] Downloaded successfully"
            Write-Host "[installer.weasel-pageant] Extracting $archive to ${zipfile.DirectoryName}..."
            Expand-Archive $archive -DestinationPath $zipfile.DirectoryName
        } else {
            Write-Error "[installer.weasel-pageant] Download failed"
        }
    }

    #
    if((wsl awk '/^ID=/' /etc/*-release | wsl awk -F'=' '{ print tolower(\$2) }') -ne 'ubuntu') {
        Write-Error 'Ensure Windows Subsystem for Linux is setup to run the Ubuntu distribution'
        return
    } else {
        Write-Host "Ubuntu installed"
    }

    #
    if((wsl awk '/^DISTRIB_RELEASE=/' /etc/*-release | wsl awk -F'=' '{ print tolower(\$2) }') -lt 16.04) {
        Write-Error 'You need to install a minimum of Ubuntu 16.04 Xenial Xerus before running this script'
        return
    } else {
        Write-Host "Ubuntu version is compatible"
    }

    #
    Get-WebFile -url 'https://raw.githubusercontent.com/treffynnon/Windows-Boxstarter-with-WSL-Ubuntu/master/install.sh' -fileName "$($env:temp)\install.sh"
    $windows_bash_script_path = [regex]::Escape("$($env:temp)\install.sh")
    $linux_bash_script_path=(wsl wslpath -a "$windows_bash_script_path")
    wsl cp "$linux_bash_script_path" "/tmp/"
    wsl bash -c "/tmp/install.sh"

    #
    Update-SessionEnvironment
}


if(Confirm-Install 'Boxstarter::WSL-docker') {

    # Windows 10 is required
    if(! (Get-IsOSWindows10)) {
        Write-Error 'Upgrade to Windows 10 before running this script'
        return
    }

    # Windows 10 - 1803 is required
    if((Get-OSReleaseId) -lt 1803) {
        Write-Error 'You need to run Windows Update and install Feature Updates to at least version 1803'
        return
    }

    # 64-bit Windows
    if (-not [Environment]::Is64BitOperatingSystem) {
        Write-Error "This package requires a 64-bit Windows."
        return
    }

    # Bring Ubuntu's apt-get up to date
    Start-Process "wsl" -argumentlist "sudo apt-get update -y" -wait
    Start-Process "wsl" -argumentlist "sudo apt-get upgrade -y" -wait

    # Install Docker's package dependencies.
    Start-Process "wsl" -argumentlist "sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common" -wait

    # Download and add Docker's official public PGP key.
    Start-Process "wsl" -argumentlist "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -" -wait

    # Verify the fingerprint.
    Start-Process "wsl" -argumentlist "sudo apt-key fingerprint 0EBFCD88" -wait

    # Add the `stable` channel's Docker upstream repository.
    Start-Process "wsl" -argumentlist 'sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"' -wait

    # Update the apt package list (for the new apt repo).
    Start-Process "wsl" -argumentlist "sudo apt-get update -y" -wait

    # Install the latest version of Docker and docker compose.
    Start-Process "wsl" -argumentlist "sudo apt-get install -y docker.io docker-compose" -wait

    # Connect to a remote Docker daemon
    wsl sudo bash -c "echo export DOCKER_HOST=tcp://localhost:2375 >> ~/.bashrc && source ~/.bashrc"

    # Verify Everything Works
    Start-Process "wsl" -argumentlist "docker info" -wait
    Start-Process "wsl" -argumentlist "docker-compose --version" -wait

    # Ensure Volume Mounts Work
    wsl sudo bash -c "echo [automount] > /etc/wsl.conf"
    wsl sudo bash -c "echo root = / >> /etc/wsl.conf"
    wsl sudo bash -c "echo options = ""metadata"" >> /etc/wsl.conf"
}