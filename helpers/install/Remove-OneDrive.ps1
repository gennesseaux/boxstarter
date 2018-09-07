function Remove-OneDrive
{
    Write-Host "Kill OneDrive process and explorer"
    Get-Process -Name OneDrive -ErrorAction SilentlyContinue | taskkill.exe /IM OneDrive* /F
    Get-Process -Name explorer* -ErrorAction SilentlyContinue | taskkill.exe /IM explorer* /F

    Write-Host "Remove OneDrive"
    if(Test-Path "${env:systemroot}\System32\OneDriveSetup.exe") {
        & "${env:systemroot}\System32\OneDriveSetup.exe" /uninstall
    }
    if(Test-Path "${env:systemroot}\SysWOW64\OneDriveSetup.exe") {
        & "${env:systemroot}\SysWOW64\OneDriveSetup.exe" /uninstall
    }

    Write-Host "Disable OneDrive via Group Policies"
    Set-Registry -Path 'HKLM:\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\OneDrive' -Name 'DisableFileSyncNGSC' -Type 'DWord' -Value 1

    Write-Host "Removing OneDrive leftovers trash"
    Remove-Item -Recurse -Force -ErrorAction SilentlyContinue "${env:LocalAppData}\Microsoft\OneDrive"
    Remove-Item -Recurse -Force -ErrorAction SilentlyContinue "${env:ProgramData}\Microsoft OneDrive"
    Remove-Item -Recurse -Force -ErrorAction SilentlyContinue "C:\OneDriveTemp"

    Write-Host "Remove Onedrive from explorer sidebar"
    New-PSDrive -PSProvider "Registry" -Root "HKEY_CLASSES_ROOT" -Name "HKCR"
    Set-Registry -Path 'HKCR:\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}' -Name 'System.IsPinnedToNameSpaceTree' -Type 'DWord' -Value 0
    Set-Registry -Path 'HKCR:\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6' -Name 'System.IsPinnedToNameSpaceTree' -Type 'DWord' -Value 0
    Remove-PSDrive "HKCR"

    Write-Host "Removing run option for new users"
    reg load "hku\Default" "C:\Users\Default\NTUSER.DAT"
    reg delete "HKEY_USERS\Default\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "OneDriveSetup" /f
    reg unload "hku\Default"

    Write-Host "Removing startmenu junk entry"
    Remove-Item -Force -ErrorAction SilentlyContinue "${env:userprofile}\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\OneDrive.lnk"

    Restart-Explorer
}