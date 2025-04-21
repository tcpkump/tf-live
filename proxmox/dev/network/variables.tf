variable "proxmox_api_token" {
  type        = string
  description = "Proxmox API token, only set this via env variable (ex: TF_VAR_proxmox_api_token)"
}

variable "proxmox_node_name" {
  type        = string
  description = "Proxmox node name"
}

variable "proxmox_vm_datastore_id" {
  type        = string
  description = "Proxmox datastore ID"
}

variable "proxmox_iso_datastore_id" {
  type        = string
  description = "Proxmox datastore ID"
}

variable "env" {
  type        = string
  description = "Environment name (dev, prod, etc.)"
}

variable "vlan" {
  type        = number
  description = "VLAN ID"
}
