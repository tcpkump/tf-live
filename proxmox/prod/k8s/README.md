# k8s

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.10.6 |
| <a name="requirement_flux"></a> [flux](#requirement\_flux) | 1.5.1 |
| <a name="requirement_gitea"></a> [gitea](#requirement\_gitea) | 0.6.0 |
| <a name="requirement_http"></a> [http](#requirement\_http) | 3.4.5 |
| <a name="requirement_proxmox"></a> [proxmox](#requirement\_proxmox) | 0.76.0 |
| <a name="requirement_talos"></a> [talos](#requirement\_talos) | 0.9.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_proxmox"></a> [proxmox](#provider\_proxmox) | 0.76.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cluster"></a> [cluster](#module\_cluster) | git::ssh://git@gitea.imkumpy.in/kumpy/tf-modules.git//modules/proxmox-talos-k8s-cluster | proxmox-talos-k8s-cluster-v1.4.3 |

## Resources

| Name | Type |
|------|------|
| [proxmox_virtual_environment_role.csi_prod](https://registry.terraform.io/providers/bpg/proxmox/0.76.0/docs/resources/virtual_environment_role) | resource |
| [proxmox_virtual_environment_user.kubernetes_csi_prod](https://registry.terraform.io/providers/bpg/proxmox/0.76.0/docs/resources/virtual_environment_user) | resource |
| [proxmox_virtual_environment_user_token.kubernetes_csi_prod](https://registry.terraform.io/providers/bpg/proxmox/0.76.0/docs/resources/virtual_environment_user_token) | resource |

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
| <a name="output_proxmox_csi_token_id"></a> [proxmox\_csi\_token\_id](#output\_proxmox\_csi\_token\_id) | The token ID for the Proxmox CSI plugin (use for PROXMOX\_CSI\_TOKEN\_ID) |
| <a name="output_proxmox_csi_token_secret"></a> [proxmox\_csi\_token\_secret](#output\_proxmox\_csi\_token\_secret) | The token secret for the Proxmox CSI plugin (use for PROXMOX\_CSI\_TOKEN\_SECRET) |
| <a name="output_talos_config"></a> [talos\_config](#output\_talos\_config) | Talos client configuration (talosconfig). |
<!-- END_TF_DOCS -->
