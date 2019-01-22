#requires -version 3
#Requires -RunAsAdministrator

# Helper function testing if git is installed
function Test-IsGitInstalled {
    try { Get-Command git | Out-Null }
    catch { return $false }
    return $true
}

function Test-IsVcpkgInstalled {
    $root = [Environment]::GetEnvironmentVariable("VCPKG_ROOT", 'Machine')
    if($null -eq $root) {
        return $null
    }
    if(-Not (Test-Path $root\vcpkg.exe)) {
        return $null
    }
    return $root
}

function Add-Path {
    param (
        [ValidateScript({[String]::IsNullOrEmpty($_) -eq $false})]
        [string[]]$Directory
    )

    $Path = $env:PATH.Split(';')

    foreach ($dir in $Directory) {
        if($Path -contains $dir) {
            Write-Debug "$dir is already present in PATH"
        } else {
            if(-not (Test-Path $dir)) {
                Write-Debug "$dir does not exist in the filesystem"
            } else {
                $Path += $dir
            }
        }
    }

    $env:PATH = [String]::Join(';', $Path)
    [Environment]::SetEnvironmentVariable("PATH", $env:PATH, 'Machine')
}

function Update-vcpkg {

    # Vcpkg must be installed
    $root = Test-IsVcpkgInstalled
    if($null -eq $root ) {
        Write-Error "Vcpkg must be installed"
        return
    }

    # Git must be installed in order to download vcpkg source files
    if( (Test-IsGitInstalled) -eq $false) {
        Write-Error "Git must be installed in order to download vcpkg source files"
        return
    }

    Write-debug 'Updating vcpkg ...'
    git -C $root pull
    & $root\bootstrap-vcpkg.bat
    & $root\vcpkg integrate install
    & $root\vcpkg integrate powershell
    & $root\vcpkg upgrade --no-dry-run
}


function Install-vcpkg {
    param(
        [ValidateScript({[String]::IsNullOrEmpty($_) -eq $false})]
        [String]$Root
    )

    # Git must be installed in order to download vcpkg source files
    if( (Test-IsGitInstalled) -eq $false) {
        Write-Error "Git must be installed in order to download vcpkg source files"
        return
    }

    # Make sure root folder is created
    if(-Not (Test-Path $Root)) {
        New-Item -Path $Root -ItemType Directory -Force | Out-Null
    }

    # Test if vcpkg is already installed
    if($null -eq [Environment]::GetEnvironmentVariable("VCPKG_ROOT", 'Machine')) {
        Write-debug 'vcpkg is not installed'

        Write-debug "Make sure $Root is empty"
        Remove-Item $Root -Recurse -Force -ErrorAction SilentlyContinue | Out-Null

        Write-debug 'Installing vcpkg ...'
        git clone https://github.com/Microsoft/vcpkg $Root

        Write-debug 'Define VCPKG_ROOT ...'
        [Environment]::SetEnvironmentVariable("VCPKG_ROOT", $Root, 'Machine')
        Add-Path $Root
    }
    else {
        Write-debug 'vcpkg is installed'
        Update-vcpkg
    }
}


function Add-Vcpkg {
    param(
        [ValidateScript({[String]::IsNullOrEmpty($_) -eq $false})]
        [String]$pkg
    )

    $root = [Environment]::GetEnvironmentVariable("VCPKG_ROOT", 'Machine')
    & $root\vcpkg install $pkg
}