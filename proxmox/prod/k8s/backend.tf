terraform {
  backend "s3" {
    bucket = "imkumpy-terraform-state"
    key    = "tf-live/proxmox/prod/k8s/terraform.tfstate"
    region = "us-east-1"
  }
}
