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

    # proxy
    if( ! ([string]::IsNullOrEmpty($proxyLocation) -and [string]::IsNullOrEmpty($proxyUser)  -and [string]::IsNullOrEmpty($proxyPassword) ) ) {
        $proxyport = $proxyLocation.Substring($proxyLocation.LastIndexOf('/')+1)
        $proxy = $proxyport.Substring(0, $proxyport.LastIndexOf(':'))
        $port = $proxyport.Substring($proxyport.LastIndexOf(':')+1)
        $user = $proxyUser.Substring($proxyUser.LastIndexOf('\')+1)
        $http_proxy = "http://${user}:${proxyPassword}@${proxy}:${port}"
    }

    #--- Enable hyper-V
    Install-ChocoWindowsFeature Microsoft-Hyper-V-All

    #--- Enable Windows Subsystem for Linux
    Install-ChocoWindowsFeature Microsoft-Windows-Subsystem-Linux

    #--- Install lxrunoffline
    Install-ChocoApp lxrunoffline -RefreshEnv
    $tools_path = Get-ToolsLocation
    $lxrun_path = join-path $tools_path 'lxrunoffline'
    if(!(Test-Path $lxrun_path)) {
        Add-Path $lxrun_path
        Update-SessionEnvironment
    }

    #--- Download Ubuntu image
    Get-WebFile -url 'https://partner-images.canonical.com/core/bionic/current/ubuntu-bionic-core-cloudimg-amd64-root.tar.gz' -fileName "$env:TMP\ubuntu.tar.gz"

    #--- Install Ubuntu 18.04
    $wsl_path = join-path $tools_path 'ubuntu'
    lxrunoffline install -n ubuntu -d "$wsl_path" -f "$env:TMP\ubuntu.tar.gz" -s
    if(!(Test-Path $wsl_path)) {
        Add-Path $wsl_path
        Update-SessionEnvironment
    }

    #--- Decent bash/WSL terminal - wsltty
    Install-ChocoApp wsltty

    # Finish wsltty setup by setting up shortcuts
    $wsl_gen_short = 'C:\ProgramData\Microsoft\Windows\Start Menu\Programs\WSL Generate Shortcuts.lnk'
    if(Test-Path $wsl_gen_short) {
        Invoke-Item $wsl_gen_short
    }

    # Install Hack font used in wsltty
    Install-ChocoApp hackfont

    # Configure wsltty
    Get-WebFile -url 'https://raw.githubusercontent.com/treffynnon/Windows-Boxstarter-with-WSL-Ubuntu/master/config_files/wsltty/paraiso_dark.mintty' -fileName "$env:APPDATA\wsltty\themes"
    Get-WebFile -url 'https://raw.githubusercontent.com/treffynnon/Windows-Boxstarter-with-WSL-Ubuntu/master/config_files/wsltty/config' -fileName "$env:APPDATA\wsltty\config"

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

    # Update ubuntu
    wsl bash -c "test -r /etc/environment && source /etc/environment"

    wsl bash -c "apt-get update -y && apt-get upgrade -y"
    wsl bash -c "apt-get autoremove -y && apt-get autoclean -y"

    wsl bash -c "apt-get install -y build-essential bzip2 cmake colordiff coreutils curl dos2unix doxygen git git-lfs linux-tools-common llvm rsync unzip wget"
    wsl bash -c "curl -L --output /tmp/nord-dircolors.zip https://github.com/arcticicestudio/nord-dircolors/archive/develop.zip && mkdir -p ~/.dircolors && unzip -o -d ~/.dircolors /tmp/nord-dircolors.zip"

    wsl bash -c "mkdir -p ~/.bashrc.d && chmod 700 ~/.bashrc.d"
    wsl bash -c "grep ~/.bashrc.d ~/.bashrc ||  echo >> ~/.bashrc"
    wsl bash -c "grep ~/.bashrc.d ~/.bashrc ||  echo 'for file in ~/.bashrc.d/*.bashrc; do source '\\$'{file}; done' >> ~/.bashrc"
    wsl bash -c "echo 'test -r ~/.dir_colors && eval '\\$'(dircolors ~/.dir_colors)' > ~/.bashrc.d/dir_colors.bashrc"
    wsl bash -c "chmod +x ~/.bashrc.d/*"

    #
    Update-SessionEnvironment

    #
    if(Test-PendingReboot) { Invoke-Reboot }
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
    wsl bash -c "apt-get update -y && apt-get upgrade -y"
    wsl bash -c "apt-get autoremove -y && apt-get autoclean -y"

    # Install Docker's package dependencies.
    wsl bash -c "apt-get install -y apt-transport-https ca-certificates curl software-properties-common"

    # Download and add Docker's official public PGP key.
    wsl bash -c "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -"

    # Verify the fingerprint.
    wsl bash -c "apt-key fingerprint 0EBFCD88"

    # Add the `stable` channel's Docker upstream repository.
    wsl bash -c "add-apt-repository 'deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable'"

    # Update the apt package list (for the new apt repo).
    wsl bash -c "apt-get update -y"

    # Install the latest version of Docker and docker compose.
    wsl bash -c "apt-get install -y docker.io docker-compose"

    # Connect to a remote Docker daemon
    wsl bash -c "echo export DOCKER_HOST=tcp://localhost:2375 > ~/.bashrc.d/docker.bashrc && source ~/.bashrc.d/docker.bashrc && chmod +x ~/.bashrc.d/docker.bashrc"

    # Verify Everything Works
    wsl bash -c "docker info"
    wsl bash -c "docker-compose --version"

    # Ensure Volume Mounts Work
    wsl bash -c "echo [automount] > /etc/wsl.conf"
    wsl bash -c "echo root = / >> /etc/wsl.conf"
    wsl bash -c "echo options = ""metadata"" >> /etc/wsl.conf"

    #
    if(Test-PendingReboot) { Invoke-Reboot }
}