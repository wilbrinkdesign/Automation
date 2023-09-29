### Create VM in VMware Workstation with Packer

1. Download Windows Server 2022 ISO: https://www.microsoft.com/en-us/evalcenter/download-windows-server-2022
2. Get checksum ISO: Get-FileHash <iso>
3. Install chocolatey: https://chocolatey.org/install
4. choco install packer
5. VMware Workstation 17 Pro => Virtual Network Editor => Restore Defaults

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
packer build -var-file=".\W2K22.auto.pkrvars.hcl" -var "vm_dir=$env:TEMP\Packer" -var "win_iso=<dir_iso>" ".\W2K22.pkr.hcl"
packer build -var-file=".\W2K22.auto.pkrvars.hcl" -var "vm_dir=$env:TEMP\Packer" -var "win_iso=<dir_iso>" .
```

#### Default credentials

| Username      | Password    |
| ------------- | ----------- |
| Administrator | `P@cker`    |