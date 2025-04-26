output "talosconfig" {
  description = "Talos client configuration (talosconfig)."
  value       = module.cluster.client_configuration.talos_config
  sensitive   = true
}
