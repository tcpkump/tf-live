module "cluster" {
  source = "git::ssh://git@gitea.imkumpy.in/kumpy/tf-modules.git//modules/proxmox-talos-k8s-cluster?ref=proxmox-talos-k8s-cluster-v1.2.2"

  image = {
    version = "v1.11.3"
    # update_version = "v1.11.3"
    schematic_path = "image/schematic.yaml"
    # update_schematic_path = "image/schematic-updated.yaml"
  }

  cluster = {
    name    = "talos-dev"
    vip     = "10.200.10.10"
    gateway = "10.200.0.1"
    # The version of talos features to use in generated machine configuration. Generally the same as image version.
    # See https://github.com/siderolabs/terraform-provider-talos/blob/main/docs/data-sources/machine_configuration.md
    # Uncomment to use this instead of version from talos_image.
    # talos_machine_config_version = "v1.9.5"
    proxmox_cluster    = "ryzen-proxmox"
    kubernetes_version = "v1.34.1" # only applies at bootstrap time, but try to keep in sync
  }

  flux_bootstrap_repo = {
    # Points to git.imkumpy.in/kumpy/fluxcd-demo
    username = "kumpy"
    name     = "k8s-live"
  }

  nodes = {
    "k8s-ctrl-dev-00" = {
      host_node      = "ryzen-proxmox"
      machine_type   = "controlplane"
      ip             = "10.200.10.1"
      network_bridge = "vmbr200" # dev
      vm_id          = 400
      cpu            = 2
      ram_dedicated  = 3072
      update         = false
    }
    "k8s-ctrl-dev-01" = {
      host_node      = "ryzen-proxmox"
      machine_type   = "controlplane"
      ip             = "10.200.10.2"
      network_bridge = "vmbr200" # dev
      vm_id          = 401
      cpu            = 2
      ram_dedicated  = 3072
      update         = false
    }
    "k8s-ctrl-dev-02" = {
      host_node      = "ryzen-proxmox"
      machine_type   = "controlplane"
      ip             = "10.200.10.3"
      network_bridge = "vmbr200" # dev
      vm_id          = 402
      cpu            = 2
      ram_dedicated  = 3072
      update         = false
    }
    "k8s-work-dev-00" = {
      host_node      = "ryzen-proxmox"
      machine_type   = "worker"
      ip             = "10.200.10.21"
      network_bridge = "vmbr200" # dev
      vm_id          = 421
      cpu            = 2
      ram_dedicated  = 4096
      update         = false
    }
    "k8s-work-dev-01" = {
      host_node      = "ryzen-proxmox"
      machine_type   = "worker"
      ip             = "10.200.10.22"
      network_bridge = "vmbr200" # dev
      vm_id          = 422
      cpu            = 2
      ram_dedicated  = 4096
      update         = false
    }
    "k8s-work-dev-02" = {
      host_node      = "ryzen-proxmox"
      machine_type   = "worker"
      ip             = "10.200.10.23"
      network_bridge = "vmbr200" # dev
      vm_id          = 423
      cpu            = 2
      ram_dedicated  = 4096
      update         = false
    }
  }
}
