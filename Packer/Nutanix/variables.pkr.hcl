variable "nutanix_user" {
  type        = string
  description = "Nutanix admin"
}

variable "nutanix_pass" {
  type        = string
  description = "Nutanix admin password"
}

variable "nutanix_host" {
  type        = string
  description = "Nutanix host"
}

variable "nutanix_cluster" {
  type        = string
  description = "Nutanix cluster"
}

variable "nutanix_subnet" {
  type        = string
  description = "Nutanix subnet"
}

variable "nutanix_nossl" {
  type        = bool
  default     = true
  description = "Nutanix ssl"
}

variable "vm_name" {
  type        = string
  description = "Name VM"
}

variable "vm_version" {
  type        = string
  description = "Version number"
}

variable "vm_dir" {
  type        = string
  description = "Dir to store VM in"
}

variable "vm_os" {
  type        = string
  description = "Guest OS"
}

variable "vm_cpus" {
  type        = string
  description = "Amount of vCPUs"
}

variable "vm_disk_size" {
  type        = string
  description = "Harddisk size"
}

variable "vm_memory" {
  type        = string
  description = "VM Memory"
}

variable "win_iso" {
  type        = string
  description = "Windows ISO location"
}

variable "winrm_username" {
  type        = string
  description = "WinRM username"
}

variable "winrm_password" {
  type        = string
  description = "WinRM password"
}