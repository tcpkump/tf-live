terraform {
  required_version = "~> 1.10.6" # OpenTofu
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.76.0"
    }
  }
}
