provider "proxmox" {
  endpoint = "https://192.168.0.100:8006/"

  api_token = var.proxmox_api_token

  # because self-signed TLS certificate is in use
  insecure = true

  tmp_dir = "/var/tmp"

  ssh {
    agent    = true
    username = "root"
  }
}

provider "talos" {}

provider "gitea" {
  base_url = "https://git.imkumpy.in/"

  username = var.gitea_username
  password = var.gitea_password
}
