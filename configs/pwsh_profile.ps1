function mklink ($target, $link) {
    New-Item -Path $link -ItemType SymbolicLink -Value $target
}


# --- Completion
Import-Module PSReadLine
Set-PSReadLineKeyHandler -Chord Tab -Function MenuComplete


# --- PowerColorLS
if (-not (Get-Module -ListAvailable -Name PowerColorLS)) {
	Install-Module -Name PowerColorLS -Repository PSGallery -Scope CurrentUser
}

Import-Module PowerColorLS

# --- Terminal Icons
if (-not (Get-Module -ListAvailable -Name Terminal-Icons)) {
	Install-Module Terminal-Icons -Scope CurrentUser
}
Import-Module Terminal-Icons

# --- Oh My Posh
if (-not (Get-Module -ListAvailable -Name oh-my-posh)) {
	Install-Module oh-my-posh -Scope CurrentUser
	
	Write-Host "Install Nerd font: https://www.nerdfonts.com/font-downloads"
}

if (-not (Get-Module -ListAvailable -Name posh-git)) {
	Install-Module posh-git -Scope CurrentUser
}

Import-Module oh-my-posh
Import-Module posh-git

Set-PoshPrompt -Theme stelbent.minimal


# --- Aliasing
Set-Alias vim nvim
Set-Alias ls PowerColorLS 
