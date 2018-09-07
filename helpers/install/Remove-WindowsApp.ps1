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
            try {
                Remove-AppxPackage -Package $PackageName
            }
            catch {
                Write-BoxstarterMessage "Error while removing ${app}..."
            }
        }

        $ProvisionedPackageName = (Get-AppxProvisionedPackage -Online | Where-Object {$_.DisplayName -eq $app}).PackageName
        if ($ProvisionedPackageName) {
            try {
                Remove-AppxProvisionedPackage -Online -Package $ProvisionedPackageName
            }
            catch {
                Write-BoxstarterMessage "Error while removing ${app}..."
            }
        }
    }
}