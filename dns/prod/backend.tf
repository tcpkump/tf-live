terraform {
  backend "s3" {
    bucket = "imkumpy-terraform-state"
    key    = "tf-live/dns/prod"
    region = "us-east-1"
  }
}
