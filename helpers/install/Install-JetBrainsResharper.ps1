function Install-JetBrainsResharper
{
    param(
        # ReSharper 
        [switch]$resharper,
        # ReSharper C++
        [switch]$cpp,
        # ReSharper Ultimate
        [switch]$ultimate
    )

    #
    if($resharper)  { $cpp=$false; $ultimate=$false }
    if($cpp)        { $resharper=$false; $ultimate=$false }
    if($ultimate)   { $resharper=$false; $cpp=$false }
    
    # install visual studio code
    if($resharper)  { Install-ChocoApp resharper }
    if($cpp)        { Install-ChocoApp cpp }
    if($ultimate)   { Install-ChocoApp resharper-platform }
}