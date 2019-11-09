# Stuff for Server Core

## Important config

### First rhings first

* Powershell as default:

```powershell
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\' -Name Shell -Value 'powershell.exe'
```

### Get stuff

* Install Chocolatey

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; iwr https://chocolatey.org/install.ps1 -UseBasicParsing | iex
```

### Remote

* Install OpenSSH

```powershell
# Check availability
Get-WindowsCapability -Online | ? Name -like 'OpenSSH*'
# Install the OpenSSH Server
Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
```

* Config OpenSSH

```powershell
Start-Service sshd
# OPTIONAL but recommended:
Set-Service -Name sshd -StartupType 'Automatic'
# Confirm the Firewall rule is configured. It should be created automatically by setup.
Get-NetFirewallRule -Name *ssh*
# There should be a firewall rule named "OpenSSH-Server-In-TCP", which should be enabled
# If the firewall does not exist, create one
New-NetFirewallRule -Name sshd -DisplayName 'OpenSSH Server (sshd)' -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 22
```

Now you should be able to ssh into your box.


## Sources

https://sid-500.com/2017/07/11/setting-up-windows-server-core-with-powershell/

https://chocolatey.org/docs/installation#install-from-powershell-v3

https://docs.microsoft.com/en-us/windows-server/administration/openssh/openssh_install_firstuse
