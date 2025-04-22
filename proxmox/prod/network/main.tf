module "network_vlan" {
  source = "git::ssh://git@gitea.imkumpy.in/kumpy/tf-modules.git//modules/proxmox-network-vlan"

  proxmox_node_name = "ryzen-proxmox"

  env            = "prod"
  vlan_id        = 100
  vlan_interface = "enp4s0"
  bridge_address = "10.100.0.100/16"
}
