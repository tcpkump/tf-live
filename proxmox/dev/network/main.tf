data "proxmox_virtual_environment_node" "main" {
  node_name = var.proxmox_node_name
}

resource "proxmox_virtual_environment_network_linux_vlan" "main" {
  node_name = data.proxmox_virtual_environment_node.main.node_name
  name      = "vlan_${var.env}"

  interface = "enp4s0"
  vlan      = var.vlan
  comment   = "VLAN ${var.vlan} - ${var.env}"
}

resource "proxmox_virtual_environment_network_linux_bridge" "vmbr99" {
  depends_on = [
    proxmox_virtual_environment_network_linux_vlan.main
  ]

  node_name = data.proxmox_virtual_environment_node.main.node_name
  name      = "vmbr${var.vlan}"

  address = "10.90.0.100/16"

  comment = "vmbr${var.env} - VLAN ${var.vlan}"

  ports = [
    proxmox_virtual_environment_network_linux_vlan.main.name
  ]
}
