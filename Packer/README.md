### Create VM in VMware Workstation with Packer

1. Download Windows Server 2022 ISO: https://www.microsoft.com/en-us/evalcenter/download-windows-server-2022
2. Get checksum ISO: Get-FileHash <filepath_iso>
3. Install chocolatey: https://chocolatey.org/install
4. choco install packer
5. VMware Workstation => Virtual Network Editor => Restore Defaults

#### Set packer_cache directory (optional)

```powershell
[System.Environment]::SetEnvironmentVariable('PACKER_CACHE_DIR',$env:TEMP, 'User')
```

#### Get latest required plugins (working directory)

```powershell
packer init .
```

#### Validate Packer config (working directory)

```powershell
packer validate .
```

#### Build VM with HCL (working directory)

```powershell
packer build -force -var-file=".\Win_2022_GUI.auto.pkrvars.hcl" -var "vm_dir=$env:TEMP" -var "win_iso=<dir_iso>" ".\Win_2022_GUI.pkr.hcl"
```

#### Default credentials

| Username      | Password    |
| ------------- | ----------- |
| Administrator | `P@cker`    |