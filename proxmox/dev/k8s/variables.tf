variable "proxmox_api_token" {
  type        = string
  description = "Proxmox API token, only set this via env variable (ex: TF_VAR_proxmox_api_token)"
}

variable "gitea_username" {
  type        = string
  description = "Gitea username"
  sensitive   = true
}

variable "gitea_password" {
  type        = string
  description = "Gitea password"
  sensitive   = true
}
