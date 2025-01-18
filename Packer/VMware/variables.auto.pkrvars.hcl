# VM config
vm_name                 = "W2K25"
vm_version              = "v1.0"
operating_system_vm     = "windows2019srvnext-64"
vm_cdrom_type           = "ide"
vm_cpus                 = "1"
vm_cores                = "2"
vm_memory               = "2048"
vm_disk_controller_type = "nvme"
vm_disk_size            = "32768"
vm_network_adapter_type = "e1000e"
vm_dir                  = ""
vm_network              = "VMnet8"
vm_hardwareversion      = "20"

# ISO
image_index = {
  "core"         = 1
  "desktop"      = 2
}
win_iso          = ""
win_iso_checksum = ""

# WinRM
winrm_username = "Administrator"
winrm_password = "P@cker"