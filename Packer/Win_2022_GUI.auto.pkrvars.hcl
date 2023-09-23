// VM config
vm_name                 = "GI-W10-001"
operating_system_vm     = "windows2019srvnext-64"
vm_cdrom_type           = "ide"
vm_cpus                 = "1"
vm_cores                = "2"
vm_memory               = "2048"
vm_disk_controller_type = "nvme"
vm_disk_size            = "32768"
vm_network_adapter_type = "e1000e"
vm_dir                  = ""

// Use the NAT Network
vm_network              = "VMnet8"
vm_hardwareversion      = "20"

// Removeable media
win_iso = "<iso_path>" # https://go.microsoft.com/fwlink/p/?LinkID=2195280&clcid=0x409&culture=en-us&country=US
win_iso_checksum = "3E4FA6D8507B554856FC9CA6079CC402DF11A8B79344871669F0251535255325" # PS > Get-FileHash to find the checksum of the ISO

// WinRM
winrm_username          = "Administrator"
winrm_password          = "P@cker"