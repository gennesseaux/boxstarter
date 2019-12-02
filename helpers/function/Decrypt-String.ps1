function Decrypt-String {
    param (
        [String]$string
    )
    if ([string]::IsNullOrWhiteSpace($string)) {
        return $null;
    }
    $securestring = convertto-securestring -string $string
    $bstr = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($securestring)
    return [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($bstr)
}