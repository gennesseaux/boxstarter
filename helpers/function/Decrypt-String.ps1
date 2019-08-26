function Decrypt-String {
    param (
        [Parameter(Mandatory=$true)]
        [ValidateNotNull()]
        [String]$string
    )
    $securestring = convertto-securestring -string $string
    $bstr = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($securestring)
    return [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($bstr)
}