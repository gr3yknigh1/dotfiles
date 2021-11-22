function mklink ($target, $link) {
    New-Item -Path $link -ItemType SymbolicLink -Value $target
}

Set-Alias vim nvim


# TODO(gr3yknigh1): Test `Write-Host` and installation
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

Set-PoshPrompt -Theme star

