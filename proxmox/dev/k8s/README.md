# k8s

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_flux"></a> [flux](#requirement\_flux) | 1.5.1 |
| <a name="requirement_gitea"></a> [gitea](#requirement\_gitea) | 0.6.0 |
| <a name="requirement_http"></a> [http](#requirement\_http) | 3.4.5 |
| <a name="requirement_proxmox"></a> [proxmox](#requirement\_proxmox) | 0.76.0 |
| <a name="requirement_talos"></a> [talos](#requirement\_talos) | 0.8.0-alpha.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cluster"></a> [cluster](#module\_cluster) | git::ssh://git@gitea.imkumpy.in/kumpy/tf-modules.git//modules/proxmox-talos-k8s-cluster | proxmox-talos-k8s-cluster-v1.2.3 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_gitea_password"></a> [gitea\_password](#input\_gitea\_password) | Gitea password | `string` | n/a | yes |
| <a name="input_gitea_username"></a> [gitea\_username](#input\_gitea\_username) | Gitea username | `string` | n/a | yes |
| <a name="input_proxmox_api_token"></a> [proxmox\_api\_token](#input\_proxmox\_api\_token) | Proxmox API token, only set this via env variable (ex: TF\_VAR\_proxmox\_api\_token) | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_kube_config"></a> [kube\_config](#output\_kube\_config) | Kubernetes client configuration (kubeconfig). |
| <a name="output_talos_config"></a> [talos\_config](#output\_talos\_config) | Talos client configuration (talosconfig). |
<!-- END_TF_DOCS -->
