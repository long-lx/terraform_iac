provider "aws" {
  region = "ap-southeast-1"
}

module "web" {
  source = "../modules/web"

  ec2_instance_number = 1
  ec2_instance_name   = "web-testing"
  ec2_ami             = "ami-06fb5332e8e3e577a"
  ec2_instance_type   = "t2.micro"
}

terraform {
  backend "s3" {
    bucket = "terraform-s3-state-techmaster-2021-devops-long"
    key    = "testing/terraform.tfstate"
    region = "ap-southeast-1"
  }
}