function Install-VisualStudioCodeExtensions
{
    param(
        [Parameter(Mandatory=$True)]
        [string[]]$Extensions
    )

    # Updates the environment variables of the current powershell session
    Update-SessionEnvironment

    # install visual studio code extensions
    foreach ($extension in $Extensions) {
        code --install-extension $extension
    }
}