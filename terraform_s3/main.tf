provider "aws" {
  region = "ap-southeast-1"
}

terraform {
  backend "s3" {
    bucket = "terraform-s3-state-techmaster-2021-devops-long"
    key    = "statefile/terraform.tfstate"
    region = "ap-southeast-1"
  }
}