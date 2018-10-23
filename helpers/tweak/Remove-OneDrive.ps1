function Remove-OneDrive
{
    Write-BoxstarterMessage 'Removing OneDrive...'

    Write-Host 'Disable OneDrive via Group Policies'
    Set-Registry -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\OneDrive' -Name 'DisableFileSyncNGSC' -Type 'DWord' -Value 1
    Set-Registry -Path 'HKLM:\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\OneDrive' -Name 'DisableFileSyncNGSC' -Type 'DWord' -Value 1

    Write-Host 'Stop OneDrive process'
    Stop-Process -Name 'OneDrive' -Force -ErrorAction SilentlyContinue
    Start-Sleep -s 2

    Write-Host 'Uninstall OneDrive'
    $onedrive = "$env:SYSTEMROOT\SysWOW64\OneDriveSetup.exe"
	if(!(Test-Path $onedrive)) {
		$onedrive = "$env:SYSTEMROOT\System32\OneDriveSetup.exe"
    }
    Start-Process $onedrive '/uninstall' -NoNewWindow -Wait
    Start-Sleep -s 2

    Write-Host 'Stop Explorer process'
    Stop-Process -Name 'explorer' -Force -ErrorAction SilentlyContinue
	Start-Sleep -s 2

    Write-Host 'Removing OneDrive leftovers trash'
    Remove-Item -Path "$env:USERPROFILE\OneDrive" -Force -Recurse -ErrorAction SilentlyContinue
	Remove-Item -Path "$env:LOCALAPPDATA\Microsoft\OneDrive" -Force -Recurse -ErrorAction SilentlyContinue
	Remove-Item -Path "$env:PROGRAMDATA\Microsoft OneDrive" -Force -Recurse -ErrorAction SilentlyContinue
	Remove-Item -Path "$env:SYSTEMDRIVE\OneDriveTemp" -Force -Recurse -ErrorAction SilentlyContinue

    Write-Host 'Remove Onedrive from explorer sidebar'
    if(!(Test-Path 'HKCR:')) {
		New-PSDrive -Name 'HKCR' -PSProvider 'Registry' -Root 'HKEY_CLASSES_ROOT' | Out-Null
	}
    Set-Registry -Path 'HKCR:\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}' -Name 'System.IsPinnedToNameSpaceTree' -Type 'DWord' -Value 0
    Set-Registry -Path 'HKCR:\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6' -Name 'System.IsPinnedToNameSpaceTree' -Type 'DWord' -Value 0
    Remove-PSDrive 'HKCR'

    Write-Host 'Removing run option for new users'
    reg load 'hku\Default' 'C:\Users\Default\NTUSER.DAT'
    reg delete 'HKEY_USERS\Default\SOFTWARE\Microsoft\Windows\CurrentVersion\Run' /v 'OneDriveSetup' /f
    reg unload 'hku\Default'

    Write-Host 'Removing startmenu junk entry'
    if(!(Test-Path "${env:userprofile}\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\OneDrive.lnk")) {
	    Remove-Item -Path "${env:userprofile}\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\OneDrive.lnk" -Force -ErrorAction SilentlyContinue
    }

    Write-Host 'Restart Explorer'
    if(!(Get-Process -Name explorer -ErrorAction SilentlyContinue)) {
        start-Process -FilePath explorer
    }
}