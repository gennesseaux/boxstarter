function Out-HasteBin
{
    #
    # Output to hastebin.com
    #
    [CmdletBinding()]
    [OutputType([String])]
    param(
        [Parameter(Mandatory=$True)]
        [string]$content
    )

    $serviceUrl = "https://hastebin.com/"
    
    # Create paste
    $response = Invoke-RestMethod ($serviceUrl + "documents") -Method Post -Body $content

    # return full url
    return ($serviceUrl + 'raw/' + $response.key)
}