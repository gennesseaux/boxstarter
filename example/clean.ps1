#Requires -version 3
#Requires -RunAsAdministrator

Remove-Item $env:USERPROFILE\AppData\Local\Apps -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item $env:USERPROFILE\AppData\Local\BoxStarter -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item $env:USERPROFILE\Chocolately -Recurse -Force -ErrorAction SilentlyContinue