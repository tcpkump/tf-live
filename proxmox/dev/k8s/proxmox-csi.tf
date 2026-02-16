# Proxmox CSI Plugin Infrastructure
# This creates the necessary Proxmox user, role, and API token for the CSI plugin

resource "proxmox_virtual_environment_role" "csi_dev" {
  role_id = "CSI-Dev"

  privileges = [
    "VM.Audit",
    "VM.Config.Disk",
    "Datastore.Allocate",
    "Datastore.AllocateSpace",
    "Datastore.Audit",
    "Sys.Audit",
  ]
}

resource "proxmox_virtual_environment_user" "kubernetes_csi_dev" {
  comment = "Kubernetes CSI Plugin (Dev) - Managed by Terraform"
  enabled = true
  user_id = "kubernetes-csi-dev@pve"

  acl {
    path      = "/"
    propagate = true
    role_id   = proxmox_virtual_environment_role.csi_dev.role_id
  }
}

resource "proxmox_virtual_environment_user_token" "kubernetes_csi_dev" {
  comment               = "Kubernetes CSI Plugin Token (Dev) - Managed by Terraform"
  token_name            = "csi"
  user_id               = proxmox_virtual_environment_user.kubernetes_csi_dev.user_id
  privileges_separation = false # Token inherits full user privileges

  # Note: The token value is only available at creation time
  # It will be stored in terraform state and exposed via output
}
