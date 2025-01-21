### Create VM in VMware Workstation with Packer

1. Install Nutanix AHV
2. [Download Windows Server 2025 ISO](https://www.microsoft.com/en-us/evalcenter/download-windows-server-2025)
3. Log into Prism Central and upload ISO
4. winget install Hashicorp.Packer
5. winget install Microsoft.WindowsADK

#### Set packer_cache directory (optional)

```powershell
[System.Environment]::SetEnvironmentVariable('PACKER_CACHE_DIR',"$env:TEMP", 'User')
```

#### Get latest required plugins (working directory)

```powershell
packer init .
```

#### Validate Packer config (working directory)

```powershell
packer validate .
```

#### Build VM (working directory)

```powershell
packer build .
packer build -var "vm_dir=$env:TEMP\Packer" -var "win_iso=<dir_iso>" .
```

#### Default credentials

| Username      | Password    |
| ------------- | ----------- |
| Administrator | `P@cker`    |
