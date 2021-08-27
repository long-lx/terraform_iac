provider "aws" {
  region = "ap-southeast-1"
}

module "web" {
  source = "../modules/web"

  ec2_instance_number = var.production_ec2_instance_number
  ec2_instance_name   = var.production_ec2_instance_name
  ec2_ami             = var.production_ec2_ami
  ec2_instance_type   = var.production_ec2_instance_type
}

terraform {
  backend "s3" {
    bucket = "terraform-s3-state-techmaster-2021-devops-long"
    key    = "production/terraform.tfstate"
    region = "ap-southeast-1"
  }
}