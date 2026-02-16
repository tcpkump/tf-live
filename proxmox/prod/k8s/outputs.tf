output "talos_config" {
  description = "Talos client configuration (talosconfig)."
  value       = module.cluster.client_configuration.talos_config
  sensitive   = true
}

output "kube_config" {
  description = "Kubernetes client configuration (kubeconfig)."
  value       = module.cluster.kube_config
  sensitive   = true
}

output "proxmox_csi_token_id" {
  description = "The token ID for the Proxmox CSI plugin (use for PROXMOX_CSI_TOKEN_ID)"
  value       = proxmox_virtual_environment_user_token.kubernetes_csi_prod.id
}

output "proxmox_csi_token_secret" {
  description = "The token secret for the Proxmox CSI plugin (use for PROXMOX_CSI_TOKEN_SECRET)"
  value       = proxmox_virtual_environment_user_token.kubernetes_csi_prod.value
  sensitive   = true
}
