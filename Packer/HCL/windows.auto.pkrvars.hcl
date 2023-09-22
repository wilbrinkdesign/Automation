// VM config
vm_name                 = "GI-W10-001"
operating_system_vm     = "windows9-64"
vm_firmware             = "bios"
vm_cdrom_type           = "ide"
vm_cpus                 = "2"
vm_cores                = "1"
vm_memory               = "2048"
vm_disk_controller_type = "nvme"
vm_disk_size            = "32768"
vm_network_adapter_type = "e1000e"
// Use the NAT Network
vm_network              = "VMnet8"
vm_hardwareversion      = "19"

// Removeable media
win_iso = "C:\\Users\\markw\\OneDrive\\Software\\SERVER_EVAL_x64FRE_en-us.iso"
// In Powershell use the "get-filehash" command to find the checksum of the ISO
win_iso_checksum = "3E4FA6D8507B554856FC9CA6079CC402DF11A8B79344871669F0251535255325"

winrm_username          = "winrm"
winrm_password          = "Welkom1#"