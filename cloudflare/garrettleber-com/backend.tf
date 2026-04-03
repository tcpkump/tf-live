terraform {
  backend "s3" {
    bucket = "imkumpy-terraform-state"
    key    = "tf-live/cloudflare/garrettleber-com"
    region = "us-east-1"
  }
}
