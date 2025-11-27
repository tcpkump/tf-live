terraform {
  backend "s3" {
    bucket = "imkumpy-terraform-state"
    key    = "tf-live/proxmox/prod/ns1/terraform.tfstate"
    region = "us-east-1"
  }
}
