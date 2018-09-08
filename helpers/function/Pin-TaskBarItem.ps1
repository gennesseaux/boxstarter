function Pin-TaskBarItem {
    <#
    .SYNOPSIS
    Creates an item in the task bar linking to the provided path.

    .PARAMETER TargetFilePath
    The path to the application that should be launched when clicking on the task bar icon.

    .PARAMETER verb
    The verb use to pin to taskbar.
    The verb may be différent depending of your OS language.

    .EXAMPLE
    Pin-TaskBarItem "${env:ProgramFiles(x86)}\Microsoft Visual Studio 11.0\Common7\IDE\devenv.exe"
    This will create a Visual Studio task bar icon.
    #>
    param(
        [string] $targetFilePath,
        [string] $verb
    )

    Write-Debug "Running 'Pin-TaskBarItem' with targetFilePath:`'$targetFilePath`'";

    if (test-path($targetFilePath)) {

        # Define verbs used to pin to taskbar
        $verbs = @()
        $verbs += "Pin To Taskbar"                      # EN
        $verbs += "Épingler à l’écran de démarrage"     # FR
        if($null -eq $verb) {
            $verbs += $verb
        }
        # Pin
        $path = split-path $targetFilePath
        $shell = new-object -com "Shell.Application"
        $folder = $shell.Namespace($path)
        $item = $folder.Parsename((split-path $targetFilePath -leaf))
        $itemVerb = $item.Verbs() | Where-Object { $verbs -contains $_.Name.Replace("&","")}
        if($null -eq $itemVerb) {
            Write-Host "TaskBar verb not found for $($item.Name). It may have already been pinned"
        }
        else {
            $itemVerb.DoIt()
            Write-Host "`'$targetFilePath`' has been pinned to the task bar on your desktop"
        }
    }
    else {
        $errorMessage = "`'$targetFilePath`' does not exist, not able to pin to task bar"
    }

    if($errorMessage){
        Write-Error $errorMessage
        throw $errorMessage
    }
}
