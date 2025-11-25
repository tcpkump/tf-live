module "container" {
  source = "git::ssh://git@gitea.imkumpy.in/kumpy/tf-modules.git//modules/proxmox-lxc-container?ref=proxmox-lxc-container-v1.1.0"

  host_node       = "ryzen-proxmox"
  container_count = 1
  name            = "bobadev"

  id            = [500]
  ip            = ["10.200.1.90"]
  cidr          = "16"
  disk_location = ["local-lvm"]
  disk_size     = "10G"

  cpu = 1
  mem = 512

  template_file_id = "local:vztmpl/ubuntu-24.04-standard_24.04-2_amd64.tar.zst"
  os_type          = "ubuntu"

  network_bridge = "vmbr200" # dev
  gateway        = "10.200.0.1"

  ssh_keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINc+H1jscK8Hx1B2LvNHjXBqx3FSlr8LTzXR85R73ClW Fett",
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCmh8Pn/HwXN+nqLZSsFdVH4FeXNyyTPstZak7iv45qbo32XQ2F4dKBBNy83Y4woDbzi5HqPU+s5mUA9t2DBx7UvJseGcXSSdtm/xkXZwVTxUCd8OlNd3NVm4mlIwXRRUztT3bLqfqHP7XV4uQqSHtBzTIlj4EWsIpfSn8Y6bneFGMI04NqePGmS7Cx6ahO2FqtESy1YTb1Ahwsxd8cgCs4/nVbzXtbCd3AUvvs9htsVMyORNMgQd44+KkXseFyQ3cvDVog07ThepTh2VcN8ei6pKrNRen/Qx+Oomn8gKz9Eu7JJWinQCjJeSrPxrFXJWjEnyFcEubAc/2YBx/9TT8tBUGKLLfmc+teVQyhb8JrAGPd7WDL2XCmjgCEZEa4MijrQsZg1vLUZRu6Yde/N0lhHIDD8SZ2h6aUh9cTQAJr8Va5uhDiiTB4HojSUEv9meCCvnoO8mXZoQ5URTfL8Qwy/zJr1M60S/hte8gqdNowPhWbpz7ziSgWm6/0QUugsjs= garrett@Garretts-MBP"
  ]
}
