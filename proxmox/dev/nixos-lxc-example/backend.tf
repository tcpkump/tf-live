terraform {
  backend "s3" {
    bucket = "imkumpy-terraform-state"
    key    = "tf-live/proxmox/dev/nixos-lxc-example/terraform.tfstate"
    region = "us-east-1"
  }
}
