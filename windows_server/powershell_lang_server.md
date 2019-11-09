# PowerShell Language Server

## Intro

I am using Linux on my client endpoints but need to write Powershell for
Windows Server/Windows 10 clients. My text editor of choice is
https://neovim.io/ and i use [coc.vim](https://github.com/neoclide/coc.nvim) as
well as [coc-powershell](https://github.com/coc-extensions/coc-powershell) for
completion. One major drawback of this setup is that this system uses `pwsh` on
Linux, but it would be really useful if i could connect `coc` directly with the
[PowerShell language
server](https://github.com/PowerShell/PowerShellEditorServices) running on a
remote host, preferably something that has all the interesting server-related
Powershell modules installed.

In this scenario i will be installing the language server on an evaluation
version of Windows Server 2019 Standard through a SSH session. Before you
attempt to follow these steps you should read my article about essential
configuration steps on Windows Server.

## Installation

```powershell
choco install -y git neovim nodejs
$env:Path += ";C:\Program Files\nodejs"
$base=:"$env:USERPROFILE\langserver"
New-Item -Type Directory $base
Set-Location $base
git clone https://github.com/PowerShell/PowerShellEditorServices.git .
Install-Module -Confirm:$false InvokeBuild
. .\build.ps1
```
