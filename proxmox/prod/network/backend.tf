terraform {
  backend "s3" {
    bucket = "imkumpy-terraform-state"
    key    = "tf-live/proxmox/prod/network/terraform.tfstate"
    region = "us-east-1"
  }
}
