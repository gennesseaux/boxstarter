function Out-HasteBin
{
    <#
    .SYNOPSIS
    Post a string to hastebin.com.
    Out-HasteBin returns the hastebin.com raw url.

    .PARAMETER Content
    Content string to post.
    #>

    [CmdletBinding()]
    [OutputType([String])]
    param(
        [Parameter(Mandatory=$True)]
        [string]$Content
    )

    $serviceUrl = "https://hastebin.com/"

    # Create paste
    $response = Invoke-RestMethod ($serviceUrl + "documents") -Method Post -Body $Content

    # return full url
    return ($serviceUrl + 'raw/' + $response.key)
}