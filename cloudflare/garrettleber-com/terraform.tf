terraform {
  required_version = "~> 1.10.6" # OpenTofu
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 5.0"
    }
  }
}
