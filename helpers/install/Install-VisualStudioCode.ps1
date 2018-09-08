function Install-VisualStudioCode
{
    # install visual studio code
    Install-ChocoApp vscode -RefreshEnv -NoUpgrade

    # Pin to task bar
	if (test-path("${$env:LOCALAPPDATA}\Programs\Microsoft VS Code\Code.exe")) {
        Pin-TaskBarItem "${env:LOCALAPPDATA}\Programs\Microsoft VS Code\Code.exe"
    }
    elseif (test-path("${env:ProgramFiles}\Microsoft VS Code\Code.exe")) {
        Pin-TaskBarItem "${env:ProgramFiles}\Microsoft VS Code\Code.exe"
    }
}
