function Install-JetBrainsResharper
{
    param(
        # ReSharper
        [switch]$Resharper,
        # ReSharper C++
        [switch]$Cpp,
        # ReSharper Ultimate
        [switch]$Ultimate
    )

    #
    if($Resharper)  { $Cpp=$false; $Ultimate=$false }
    if($Cpp)        { $Resharper=$false; $Ultimate=$false }
    if($Ultimate)   { $Resharper=$false; $Cpp=$false }

    # install Resharper
    if($Resharper)  { Install-ChocoApp resharper }
    if($Cpp)        { Install-ChocoApp cpp }
    if($Ultimate)   { Install-ChocoApp resharper-platform }
}