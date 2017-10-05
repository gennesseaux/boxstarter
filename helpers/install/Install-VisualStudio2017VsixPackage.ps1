function Install-VisualStudio2017VsixPackage
{
    param(
        [Parameter(Mandatory=$True)]
        [string[]]$packages
    )
    

    # install visual studio code extensions
    foreach ($package in $packages) {
        [String]$name,[String]$url=$package.split(':')
        Install-ChocolateyVsixPackage $name $url
    }

}