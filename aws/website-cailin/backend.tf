terraform {
  backend "s3" {
    bucket = "imkumpy-terraform-state"
    key    = "tf-live/aws/website-cailin"
    region = "us-east-1"
  }
}
