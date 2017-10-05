function Install-VisualStudioCode
{
    # install visual studio code
    Install-ChocoApp visualstudiocode

    # Prevent from upgrade when using choco upgrade as it update ittself
    chocolatey pin add -n=visualstudiocode
    
    # Pin to task bar
    Install-ChocolateyPinnedTaskBarItem "${env:ProgramFiles}\Microsoft VS Code\Code.exe"
}
