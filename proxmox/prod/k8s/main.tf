module "cluster" {
  source = "git::ssh://git@gitea.imkumpy.in/kumpy/tf-modules.git//modules/proxmox-talos-k8s-cluster?ref=proxmox-talos-k8s-cluster-v1.4.3"

  image = {
    version = "v1.11.3"
    # update_version = "v1.11.3"
    schematic_path = "image/schematic.yaml"
    # update_schematic_path = "image/schematic-updated.yaml"
    file_prefix = "prod"
  }

  cluster = {
    name    = "talos-prod"
    vip     = "10.100.10.10"
    gateway = "10.100.0.100"
    # The version of talos features to use in generated machine configuration. Generally the same as image version.
    # See https://github.com/siderolabs/terraform-provider-talos/blob/main/docs/data-sources/machine_configuration.md
    # Uncomment to use this instead of version from talos_image.
    # talos_machine_config_version = "v1.9.5"
    proxmox_cluster    = "ryzen-proxmox"
    kubernetes_version = "v1.34.1" # only applies at bootstrap time, but try to keep in sync
  }

  flux_bootstrap_repo = {
    # Points to git.imkumpy.in/kumpy/k8s-live
    username = "kumpy"
    name     = "k8s-live"
    branch   = "production"
  }

  nodes = {
    "k8s-ctrl-prod-00" = {
      host_node      = "ryzen-proxmox"
      machine_type   = "controlplane"
      ip             = "10.100.10.1"
      network_bridge = "vmbr100" # prod
      vm_id          = 800
      cpu            = 2
      ram_dedicated  = 4096
      update         = false
    }
    "k8s-ctrl-prod-01" = {
      host_node      = "ryzen-proxmox"
      machine_type   = "controlplane"
      ip             = "10.100.10.2"
      network_bridge = "vmbr100" # prod
      vm_id          = 801
      cpu            = 2
      ram_dedicated  = 4096
      update         = false
    }
    "k8s-ctrl-prod-02" = {
      host_node      = "ryzen-proxmox"
      machine_type   = "controlplane"
      ip             = "10.100.10.3"
      network_bridge = "vmbr100" # prod
      vm_id          = 802
      cpu            = 2
      ram_dedicated  = 4096
      update         = false
    }
    "k8s-work-prod-00" = {
      host_node      = "ryzen-proxmox"
      machine_type   = "worker"
      ip             = "10.100.10.21"
      network_bridge = "vmbr100" # prod
      vm_id          = 821
      cpu            = 2
      ram_dedicated  = 4096
      update         = false
    }
    "k8s-work-prod-01" = {
      host_node      = "ryzen-proxmox"
      machine_type   = "worker"
      ip             = "10.100.10.22"
      network_bridge = "vmbr100" # prod
      vm_id          = 822
      cpu            = 2
      ram_dedicated  = 4096
      update         = false
    }
    "k8s-work-prod-02" = {
      host_node      = "ryzen-proxmox"
      machine_type   = "worker"
      ip             = "10.100.10.23"
      network_bridge = "vmbr100" # prod
      vm_id          = 823
      cpu            = 2
      ram_dedicated  = 4096
      update         = false
    }
  }
}
