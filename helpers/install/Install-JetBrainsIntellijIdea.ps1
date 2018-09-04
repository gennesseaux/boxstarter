function Install-JetBrainsIntellijIdea
{
    param(
        # JetBrains IntelliJ IDEA Community
        [switch]$Community,
        # JetBrains IntelliJ IDEA Ultimate
        [switch]$Ultimate
    )

    #
    if($Community)  { $Ultimate=$false }
    if($Ultimate)   { $Community=$false }

    # install visual studio code
    if($Community)  { Install-ChocoApp intellijidea-community }
    if($Ultimate)   { Install-ChocoApp intellijidea-ultimate }
}