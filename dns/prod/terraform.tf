terraform {
  required_version = "~> 1.10.6" # OpenTofu
  required_providers {
    dns = {
      source  = "hashicorp/dns"
      version = "3.4.3"
    }
  }
}
