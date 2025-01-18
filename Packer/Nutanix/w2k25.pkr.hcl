packer {
  required_version = ">= 1.9.4"
  
  required_plugins {
    nutanix = {
      version = ">= 0.8.0"
      source  = "github.com/nutanix-cloud-native/nutanix"
    }
  }

  required_plugins {
    windows-update = {
      version = ">= 0.14.3"
      source  = "github.com/rgl/windows-update"
    }
  }
}

source "nutanix" "server" {
  nutanix_username = var.nutanix_user
  nutanix_password = var.nutanix_pass
  nutanix_endpoint = var.nutanix_host
  nutanix_insecure = var.nutanix_nossl
  cluster_uuid     = var.nutanix_cluster

  vm_disks {
      image_type        = "DISK_IMAGE"
      source_image_name = var.win_iso
  }

  vm_disks {
      image_type   = "DISK"
      disk_size_gb = var.vm_disk_size
  }

  vm_nics {
    subnet_name = var.nutanix_subnet
  }

  cd_files         = ["Resources/Configs/unattend.xml"]

  boot_priority    = "disk"

  vm_name          = "${title(var.vm_name)}_${var.vm_version}"
  image_name       = "win-{{isotime `Jan-_2-15:04:05`}}"
  shutdown_command = "shutdown /s /t 10 /f /d p:4:1 /c \"Packer Shutdown\""
  shutdown_timeout = "3m"
  cpu              = var.vm_cpus
  os_type          = var.vm_os
  memory_mb        = var.vm_memory
  communicator     = "winrm"
  winrm_port       = "5985"
  winrm_insecure   = true
  winrm_use_ssl    = false
  winrm_timeout    = "12h"
  winrm_username   = var.winrm_username
  winrm_password   = var.winrm_password
}

build {
  sources = ["nutanix.server"]

  provisioner "powershell" {
    scripts = ["Resources/Scripts/VMware_Tools.ps1"]
  }
  
  provisioner "powershell" {
    scripts = ["Resources/Scripts/Updates.ps1"]
  }
}