function Install-VisualStudio2017VsixPackage
{
    param(
        [Parameter(Mandatory=$True)]
        [string[]]$Packages
    )

    # install visual studio 2017 extensions
    foreach ($package in $Packages) {
        [String]$name,[String]$url=$package.split(':')
        Install-ChocolateyVsixPackage $name $url
    }

}