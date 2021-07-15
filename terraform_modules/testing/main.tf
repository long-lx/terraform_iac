provider "aws" {
  region = "ap-southeast-1"
}

module "web" {
  source = "../modules/web"

  ec2_instance_number = 2
  ec2_instance_name   = "web-testing"
  ec2_ami             = "ami-06fb5332e8e3e577a"
  ec2_instance_type   = "t2.micro"
}
