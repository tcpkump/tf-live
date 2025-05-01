terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.76.0"
    }
    talos = {
      source  = "siderolabs/talos"
      version = "0.8.0-alpha.0"
    }
    http = {
      source  = "hashicorp/http"
      version = "3.4.5"
    }
    flux = {
      source  = "fluxcd/flux"
      version = "1.5.1"
    }
    gitea = {
      source  = "go-gitea/gitea"
      version = "0.6.0"
    }
  }
}
