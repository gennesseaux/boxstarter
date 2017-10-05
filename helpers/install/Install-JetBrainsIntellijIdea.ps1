function Install-JetBrainsIntellijIdea
{
    param(
        # JetBrains IntelliJ IDEA Community 
        [switch]$community,
        # JetBrains IntelliJ IDEA Ultimate
        [switch]$ultimate
    )

    #
    if($community)  { $ultimate=$false }
    if($ultimate)   { $community=$false }
    
    # install visual studio code
    if($community)  { Install-ChocoApp intellijidea-community }
    if($ultimate)   { Install-ChocoApp intellijidea-ultimate }
}