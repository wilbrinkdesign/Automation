## Printer spooler example

```powershell
# Create directories
New-Item -Path 'C:\Transcripts' -ItemType Directory
New-Item -Path 'C:\Program Files\WindowsPowerShell\Modules\JEA\RoleCapabilities' -ItemType Directory

# Create JEA file - Who?
New-PSSessionConfigurationFile -Path 'C:\Program Files\WindowsPowerShell\Modules\JEA\RoleCapabilities\spooler_conf.pssc'

# Create JEA file - What?
New-PSRoleCapabilityFile -Path 'C:\Program Files\WindowsPowerShell\Modules\JEA\RoleCapabilities\spooler_admins.psrc'

# Register JEA role config
Register-PSSessionConfiguration -Name Spooler_Admins -Path 'C:\Program Files\WindowsPowerShell\Modules\JEA\RoleCapabilities\spooler_conf.pssc'

# Restart WinRM
Restart-Service WinRM
```

### spooler_conf.pssc

```powershell
@{
# Version number of the schema used for this document
SchemaVersion = '2.0.0.0'

# ID used to uniquely identify this document
GUID = 'e9fc4801-8d27-4a09-9968-3a5e466d497c'

# Author of this document
Author = 'Administrator'

# Session type defaults to apply for this session configuration. Can be 'RestrictedRemoteServer' (recommended), 'Empty', or 'Default'
SessionType = 'RestrictedRemoteServer'

# Directory to place session transcripts for this session configuration
TranscriptDirectory = 'C:\Transcripts\'

# Whether to run this session configuration as the machine's (virtual) administrator account
RunAsVirtualAccount = $true

# User roles (security groups), and the role capabilities that should be applied to them when applied to a session
RoleDefinitions = @{ '<domain>\Spooler_Admins' = @{ RoleCapabilities = 'spooler_admins' }}
}
```

### spooler_admins.psrc

```powershell
@{
# ID used to uniquely identify this document
GUID = 'b223120f-b50a-488b-8516-150b4fe81ccf'

# Author of this document
Author = 'Administrator'

# Company associated with this document
CompanyName = 'Unknown'

# Copyright statement for this document
Copyright = '(c) 2023 Administrator. All rights reserved.'

# Cmdlets to make visible when applied to a session
VisibleCmdlets = @{ Name = 'Restart-Service'; Parameters = @{ Name = 'Name'; ValidateSet = 'Spooler' } }

# Functions to make visible when applied to a session
VisibleFunctions = 'TabExpansion2'

# External commands (scripts and applications) to make visible when applied to a session
VisibleExternalCommands = 'c:\windows\system32\whoami.exe'
}
```

### Connect to server with the specified configuration file

```powershell
Enter-PSSession <server> -ConfigurationName Spooler_Admins
```
