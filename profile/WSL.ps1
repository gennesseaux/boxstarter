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
Import-Function -WebClient $webclient -Path "$sRoot/helpers/function/OsInformation.ps1"
#----------------------------------------------------------------------------------------------------------------------

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

    #--- Windows Subsystems/Features ---
    Install-ChocoWindowsFeature Microsoft-Hyper-V-All
    Install-ChocoWindowsFeature Microsoft-Windows-Subsystem-Linux

    #--- Install lxrunoffline
    Install-ChocoApp lxrunoffline -RefreshEnv
    $tools_path = Get-ToolsLocation
    $lxrun_path = join-path $tools_path 'lxrunoffline'
    if(Test-Path $lxrun_path) {
        Add-Path $lxrun_path
        Update-SessionEnvironment
    }

    #--- Download Ubuntu ---
    $ubuntu_codename = 'Ubuntu_Bionic'
    $ubuntu_folder = join-path ([System.IO.Path]::GetTempPath())  $ubuntu_codename
    $ubuntu_file = 'ubuntu-bionic-core-cloudimg-amd64-root.tar.gz'
    $ubuntu_dest = join-path $ubuntu_folder $ubuntu_file
    if(!(Test-Path("$ubuntu_dest"))) {
        Get-WebFile -url 'https://partner-images.canonical.com/core/bionic/current/ubuntu-bionic-core-cloudimg-amd64-root.tar.gz' -fileName $ubuntu_dest
    }

    #--- Install Ubuntu in WSL
    $wsl_folder = Join-Path $env:systemdrive -ChildPath 'wsl' | Join-Path -ChildPath $ubuntu_codename
    lxrunoffline install -n $ubuntu_codename -d $wsl_folder -f $ubuntu_dest -s

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

    # Configure wsltty
    Get-WebFile -url 'https://raw.githubusercontent.com/treffynnon/Windows-Boxstarter-with-WSL-Ubuntu/master/config_files/wsltty/paraiso_dark.mintty' -fileName "$env:APPDATA\wsltty\themes"
    Get-WebFile -url 'https://raw.githubusercontent.com/treffynnon/Windows-Boxstarter-with-WSL-Ubuntu/master/config_files/wsltty/config' -fileName "$env:APPDATA\wsltty\config"

    # Setup weasel-pageant
    $url = 'https://github.com/vuori/weasel-pageant/releases/download/v1.1/weasel-pageant-1.1.zip'
    $archive = "$($env:temp)\weasel-pageant-1-1.zip"
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
    }

    #
    if((wsl awk '/^DISTRIB_RELEASE=/' /etc/*-release | wsl awk -F'=' '{ print tolower(\$2) }') -lt 16.04) {
        Write-Error 'You need to install a minimum of Ubuntu 16.04 Xenial Xerus before running this script'
        return
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





