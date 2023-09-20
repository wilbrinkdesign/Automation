### Create VM in VMware Workstation with Packer

1. Download Windows Server 2022 ISO: https://www.microsoft.com/en-us/evalcenter/download-windows-server-2022
2. Get checksum ISO: Get-FileHash <filepath_iso>
3. Install chocolatey: https://chocolatey.org/install
4. choco install packer
5. VMware Workstation => Virtual Network Editor => Restore Defaults

```powershell
packer build Win_2022_GUI.json
```