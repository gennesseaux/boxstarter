function Remove-WindowsApp
{
    param(
        [Parameter(Mandatory=$True)]
        [string[]]$apps
    )

    # Try to remove  apps
    foreach ($app in $apps) {
        Write-BoxstarterMessage "Removing ${app}..."

        $PackageName = (Get-AppxPackage -Name $app -AllUsers).PackageFullName
        if ($PackageName) {
            Remove-AppxPackage -Package $PackageName -ErrorAction SilentlyContinue
        }

        $ProvisionedPackageName = (Get-AppxProvisionedPackage -Online | Where-Object {$_.DisplayName -eq $app}).PackageName
        if ($ProvisionedPackageName) {
            Remove-AppxProvisionedPackage -Online -Package $ProvisionedPackageName -ErrorAction SilentlyContinue
        }
    }
}