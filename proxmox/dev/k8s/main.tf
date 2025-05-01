module "cluster" {
  source = "git::ssh://git@gitea.imkumpy.in/kumpy/tf-modules.git//modules/proxmox-talos-k8s-cluster?ref=proxmox-talos-k8s-cluster-v1.1.0"

  image = {
    version        = "v1.9.5"
    update_version = "v1.9.5"
    schematic_path = "image/schematic.yaml"
    # Point this to a new schematic file to update the schematic
    # update_schematic_path = "talos/image/schematic.yaml"
  }

  cluster = {
    name    = "talos-dev"
    vip     = "10.200.10.10"
    gateway = "10.200.0.1"
    # The version of talos features to use in generated machine configuration. Generally the same as image version.
    # See https://github.com/siderolabs/terraform-provider-talos/blob/main/docs/data-sources/machine_configuration.md
    # Uncomment to use this instead of version from talos_image.
    # talos_machine_config_version = "v1.9.5"
    proxmox_cluster                         = "ryzen-proxmox"
    kubernetes_version                      = "v1.32.3"
    allow_scheduling_on_control_plane_nodes = true
  }

  flux_bootstrap_repo = {
    # Points to example.gitea.com/kumpy/fluxcd-demo
    username = "kumpy"
    name     = "fluxcd-demo"
  }

  nodes = {
    "k8s-ctrl-dev-00" = {
      host_node      = "ryzen-proxmox"
      machine_type   = "controlplane"
      ip             = "10.200.10.1"
      network_bridge = "vmbr200" # dev
      vm_id          = 400
      cpu            = 2
      ram_dedicated  = 2048
    }
    "k8s-ctrl-dev-01" = {
      host_node      = "ryzen-proxmox"
      machine_type   = "controlplane"
      ip             = "10.200.10.2"
      network_bridge = "vmbr200" # dev
      vm_id          = 401
      cpu            = 2
      ram_dedicated  = 2048
    }
    "k8s-ctrl-dev-02" = {
      host_node      = "ryzen-proxmox"
      machine_type   = "controlplane"
      ip             = "10.200.10.3"
      network_bridge = "vmbr200" # dev
      vm_id          = 402
      cpu            = 2
      ram_dedicated  = 2048
    }
  }
}
