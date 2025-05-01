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
