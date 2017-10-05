# Boxstarter

[Boxstarter](http://boxstarter.org/) setup script for setting up a customized windows environment in a completely unattended manner using PowerShell and [Chocolatey](https://chocolatey.org/) packages. 


## How To Use
Open an elevated PowerShell console and run the following command:

``` Powershell
PS > Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/AbsCoDes/boxstarter/master/boxstarter.ps1' -OutFile "$($env:temp)\boxstarter.ps1"; &Invoke-Command -ScriptBlock { &"$($env:temp)\boxstarter.ps1" -profiles @('<Profile>') -options @('<Option>') }
```
 
I have setup different profile which can be installed separately or not. For the full list, look in the profile folder.

However, if you want to launch your own script (from gist) and take benefit of my premade function then run the following command

``` Powershell
PS > Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/AbsCoDes/boxstarter/master/boxstarter.ps1' -OutFile "$($env:temp)\boxstarter.ps1"; &Invoke-Command -ScriptBlock { &"$($env:temp)\boxstarter.ps1" -Scripts @('<YourScript>') }
```



## Examples

1. Deploy the Essential profile.

``` Powershell
PS > Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/AbsCoDes/boxstarter/master/boxstarter.ps1' -OutFile "$($env:temp)\boxstarter.ps1"; &Invoke-Command -ScriptBlock { &"$($env:temp)\boxstarter.ps1" -profiles @('Essential') }
```

2. Deploy the Essential profile without windows updates.

``` Powershell
PS > Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/AbsCoDes/boxstarter/master/boxstarter.ps1' -OutFile "$($env:temp)\boxstarter.ps1"; &Invoke-Command -ScriptBlock { &"$($env:temp)\boxstarter.ps1" -profiles @('Essential') -options @('Boxstarter::WindowsUpdate=false') }
```

3. Deploy the Essential and DevCore profiles without windows updates and visual studio code default extentensions.

``` Powershell
PS > Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/AbsCoDes/boxstarter/master/boxstarter.ps1' -OutFile "$($env:temp)\boxstarter.ps1"; &Invoke-Command -ScriptBlock { &"$($env:temp)\boxstarter.ps1" -profiles @('Essential', 'DevCore') -options @('Boxstarter::WindowsUpdate=false', 'Boxstarter::DevCore::VisualStudioCodeExtensions=false') }
```

4. Deploy your own boxstarter script.

``` Powershell
PS > Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/AbsCoDes/boxstarter/master/boxstarter.ps1' -OutFile "$($env:temp)\boxstarter.ps1"; &Invoke-Command -ScriptBlock { &"$($env:temp)\boxstarter.ps1" -Scripts @('https://raw.githubusercontent.com/AbsCoDes/boxstarter/master/example/gist/MyGist.ps1') }
```


## Troubleshooting
If you are behind a proxy, you may be unable to execute boxstarter.

Then you have few options to get it working:

1. Using default proxy credential
``` Powershell
PS > $webclient = New-Object System.Net.WebClient
PS > $webclient.Proxy.Credentials = [System.Net.CredentialCache]::DefaultNetworkCredentials
PS > wget -Uri 'https://raw.githubusercontent.com/AbsCoDes/boxstarter/master/boxstarter.ps1' -OutFile "$($env:temp)\boxstarter.ps1";&Invoke-Command -ScriptBlock { &"$($env:temp)\boxstarter.ps1" -profiles @('<Profile>') -options @('<Option>') }
```

2. Using basic authentication
``` Powershell
PS > $user = "Domaine\username"
PS > $pass= "password"
PS > $headers = @{ Authorization = "Basic {0}" -f [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $($user),$($pass)))) }
PS > wget -Uri 'https://raw.githubusercontent.com/AbsCoDes/boxstarter/master/boxstarter.ps1' -Headers $headers -OutFile "$($env:temp)\boxstarter.ps1";&Invoke-Command -ScriptBlock { &"$($env:temp)\boxstarter.ps1" -profiles @('<Profile>') -options @('<Option>') }
```

3. Using credential
``` Powershell
PS > $user = "Domaine\username"
PS > $pass= "password"
PS > $credential = New-Object System.Management.Automation.PSCredential($user, (ConvertTo-SecureString $pass -AsPlainText -Force))
PS > wget -Uri 'https://raw.githubusercontent.com/AbsCoDes/boxstarter/master/boxstarter.ps1' -Credential $credential -OutFile "$($env:temp)\boxstarter.ps1";&Invoke-Command -ScriptBlock { &"$($env:temp)\boxstarter.ps1" -profiles @('<Profile>') -options @('<Option>') }
```

4. Using proxy credential
``` Powershell
PS > $user = "Domaine\username"
PS > $pass= "password"
PS > $credential = New-Object System.Management.Automation.PSCredential($user, (ConvertTo-SecureString $pass -AsPlainText -Force))
PS > $webclient = New-Object System.Net.WebClient
PS > $webclient.Proxy.Credentials = $credential
PS > wget -Uri 'https://raw.githubusercontent.com/AbsCoDes/boxstarter/master/boxstarter.ps1' -OutFile "$($env:temp)\boxstarter.ps1";&Invoke-Command -ScriptBlock { &"$($env:temp)\boxstarter.ps1" -profiles @('<Profile>') -options @('<Option>') }
```

5.  Defining your proxy settings
``` Powershell
PS > $user="Domaine\username"
PS > $pass="password"
PS > $webProxy = New-Object System.Net.WebProxy("http://your.webproxy:8080",$true)
PS > $webclient = New-Object System.Net.webclient
PS > $webclient.Proxy=$webproxy
PS > $webclient.proxy.Credentials = New-Object System.Net.NetworkCredential($user, $pass)
PS > wget -Uri 'https://raw.githubusercontent.com/AbsCoDes/boxstarter/master/boxstarter.ps1' -OutFile "$($env:temp)\boxstarter.ps1";&Invoke-Command -ScriptBlock { &"$($env:temp)\boxstarter.ps1" -profiles @('<Profile>') -options @('<Option>') }
```


## Real life example
Look at the scripts in the example folder to find real examples.