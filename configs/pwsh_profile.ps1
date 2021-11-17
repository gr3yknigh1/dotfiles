function mklink ($target, $link) {
    New-Item -Path $link -ItemType SymbolicLink -Value $target
}


function less($cmdlet) {
    Invoke-Expression $cmdlet | out-host -paging
}

$OutputEncoding = [console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding
Set-Alias vim nvim

Import-Module oh-my-posh
Set-PoshPrompt -Theme craver
Import-Module posh-git

clear

