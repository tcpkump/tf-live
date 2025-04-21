data "proxmox_virtual_environment_node" "main" {
  node_name = var.proxmox_node_name
}

resource "proxmox_virtual_environment_vm" "talos" {
  name      = "test-talos"
  node_name = data.proxmox_virtual_environment_node.main.node_name

  agent {
    enabled = true
  }

  initialization {
    user_account {
      keys = var.ssh_public_keys
    }
  }

  cpu {
    cores = 2
    type  = "x86-64-v2-AES"
  }

  network_device {
    bridge = "vmbr200"
  }

  disk {
    datastore_id = var.proxmox_vm_datastore_id
    file_id      = proxmox_virtual_environment_download_file.talos_image.id
    interface    = "virtio0"
    iothread     = true
    discard      = "on"
    size         = 20
  }
}

resource "proxmox_virtual_environment_download_file" "talos_image" {
  content_type = "iso"
  datastore_id = var.proxmox_iso_datastore_id
  node_name    = data.proxmox_virtual_environment_node.main.node_name
  url          = data.talos_image_factory_urls.this.urls.iso
  file_name    = "talos-${var.talos_version}.img"
}
