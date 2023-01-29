# JEA example how to delegate permissions to maintain Windows Update

### Create mandatory directories

```powershell
New-Item -Path 'C:\Transcripts' -ItemType Directory
New-Item -Path 'C:\Program Files\WindowsPowerShell\Modules\JEA\RoleCapabilities' -ItemType Directory
```

### Create the JEA config file (who gets what permissions?)

```powershell
$Roles = @{
	'<domain>\<admin_group>'	= @{ RoleCapabilities = 'WindowsUpdateAdmin', 'WindowsUpdateUser' }
	'<domain>\<user_group>'	= @{ RoleCapabilities = 'WindowsUpdateUser' }
}

$Parameters = @{
	SessionType = 'RestrictedRemoteServer'
	Path = 'C:\Program Files\WindowsPowerShell\Modules\JEA\RoleCapabilities\WindowsUpdateConfig.pssc'
	RunAsVirtualAccount = $true
	TranscriptDirectory = 'C:\Transcripts'
	RoleDefinitions = $Roles
}

New-PSSessionConfigurationFile @Parameters
```

### Create the JEA capability file (what can the user do on the system?)

```powershell
# Admins
$Parameters = @{
	Path = "C:\Program Files\WindowsPowerShell\Modules\JEA\RoleCapabilities\WindowsUpdateAdmin.psrc"
	VisibleCmdlets = "Restart-Service", @{
		Name = "Restart-Service"
		Parameters = @{ Name = "Service"; ValidateSet = "wuauserv" }
	}
	VisibleFunctions = 'TabExpansion2'
	VisibleExternalCommands = 'usoclient', 'wuauserv'
}

New-PSRoleCapabilityFile @Parameters

# Normal users
$Parameters = @{
	Path = "C:\Program Files\WindowsPowerShell\Modules\JEA\RoleCapabilities\WindowsUpdateAdmin.psrc"
	VisibleCmdlets = "Restart-Service", @{
		Name = "Restart-Service"
		Parameters = @{ Name = "Service"; ValidateSet = "wuauserv" }
	}
	VisibleFunctions = 'TabExpansion2'
	VisibleExternalCommands = 'usoclient', 'wuauserv'
}

New-PSRoleCapabilityFile @Parameters
```

Register-PSSessionConfiguration -Name WindowsUpdate -Path 'C:\Program Files\WindowsPowerShell\Modules\JEA\RoleCapabilities\WindowsUpdateConfig.pssc' -Force

### Restart WinRM

```powershell
Restart-Service WinRM -Force
```

### Connect to server with JEA config file

```powershell
Enter-PSSession <server> -ConfigurationName WindowsUpdate
```

