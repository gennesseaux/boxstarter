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
