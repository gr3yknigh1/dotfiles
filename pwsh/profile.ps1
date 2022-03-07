function Install-Vim-Plug {
	iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
	ni "$(@($env:XDG_DATA_HOME, $env:LOCALAPPDATA)[$null -eq $env:XDG_DATA_HOME])/nvim-data/site/autoload/plug.vim" -Force
}

function mklink ($target, $link) {
    New-Item -Path $link -ItemType SymbolicLink -Value $target
}

function Try-Import-Module {

    param (
        $ModuleName
    )

    if (-not (Get-Module -ListAvailable -Name $ModuleName)) {
        Install-Module $ModuleName -Scope CurrentUser -Repository PSGallery
    }

    Import-Module $ModuleName
}


Import-Module PSReadLine
Set-PSReadLineKeyHandler -Chord Tab -Function MenuComplete

Try-Import-Module Terminal-Icons
Try-Import-Module PowerColorLS
Try-Import-Module oh-my-posh
Try-Import-Module posh-git

Set-PoshPrompt -Theme star

Set-Alias l PowerColorLS
Set-Alias e nvim
Set-Alias g git
Set-Alias p python
Set-Alias v neovide

$USERBIN = "$ENV:USERPROFILE\bin"
$USERTOOLS = "$ENV:USERPROFILE\tools\bin"

$ENV:Path = "$USERBIN;$USERTOOLS;" + $ENV:Path

