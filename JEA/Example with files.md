# JEA Example: Windows Update admin capabilities

```powershell
# Create mandatory directories
New-Item -Path 'C:\Transcripts' -ItemType Directory
New-Item -Path 'C:\Program Files\WindowsPowerShell\Modules\JEA\RoleCapabilities' -ItemType Directory

# Create the JEA config file (who gets what permissions?)
New-PSSessionConfigurationFile -Path 'C:\Program Files\WindowsPowerShell\Modules\JEA\RoleCapabilities\WindowsUpdateConfig.pssc'

# Create the JEA capability file (what can the user do on the system?)
New-PSRoleCapabilityFile -Path 'C:\Program Files\WindowsPowerShell\Modules\JEA\RoleCapabilities\WindowsUpdateAdmin.psrc'

# Register the JEA config file
Register-PSSessionConfiguration -Name WindowsUpdate -Path 'C:\Program Files\WindowsPowerShell\Modules\JEA\RoleCapabilities\WindowsUpdateConfig.pssc'

# Restart WinRM
Restart-Service WinRM

# Connect to server with JEA config file
Enter-PSSession <server> -ConfigurationName WindowsUpdate
```

### Content of file: WindowsUpdateConfig.pssc

```powershell
@{
SessionType = 'RestrictedRemoteServer'
TranscriptDirectory = 'C:\Transcripts\'
RunAsVirtualAccount = $true
RoleDefinitions = @{ '<domain>\<group>' = @{ RoleCapabilities = 'WindowsUpdateAdmin' }}
}
```

### Content of file: WindowsUpdateAdmin.psrc

```powershell
@{
VisibleCmdlets = @{ Name = 'Restart-Service'; Parameters = @{ Name = 'Name'; ValidateSet = 'wuauserv' } }
VisibleFunctions = 'TabExpansion2'
VisibleExternalCommands = 'C:\Windows\System32\UsoClient.exe', 'C:\Windows\wuauclt.exe'
}
```