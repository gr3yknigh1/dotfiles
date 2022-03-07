
New-Item -PATH "$ENV:USERPROFILE\Documents\PowerShell" -ItemType Directory

$InvokationDirectory = Split-Path $MyInvokation.MyCommand.Path -Parent
$DOTPROFILE = Join-Path -Path $InvokationDirectory -ChildPath "profile.ps1"
Copy-Item -Path $DOTPROFILE -Destination $PROFILE

