# dns

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_proxmox"></a> [proxmox](#requirement\_proxmox) | 0.76.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_container"></a> [container](#module\_container) | git::ssh://git@gitea.imkumpy.in/kumpy/tf-modules.git//modules/proxmox-lxc-container | proxmox-lxc-container-v1.0.1 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_proxmox_api_token"></a> [proxmox\_api\_token](#input\_proxmox\_api\_token) | Proxmox API token, only set this via env variable (ex: TF\_VAR\_proxmox\_api\_token) | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
