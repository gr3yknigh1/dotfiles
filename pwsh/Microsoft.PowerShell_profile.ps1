Set-Variable -Name NVIMINIT -Value C:\Users\gr3yknigh1\AppData\Local\nvim\init.vim

function Install-Vim-Plug {
	iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
	ni "$(@($env:XDG_DATA_HOME, $env:LOCALAPPDATA)[$null -eq $env:XDG_DATA_HOME])/nvim-data/site/autoload/plug.vim" -Force
}

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

Set-PoshPrompt -Theme ys


# --- Aliasing
Set-Alias ls PowerColorLS 
Set-Alias e nvim
