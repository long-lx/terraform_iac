# web module

variable "ec2_instance_name" {}
variable "ec2_ami" {}
variable "ec2_instance_type" {}

resource "aws_instance" "web" {
	ami = var.ec2_ami
	instance_type = var.ec2_instance_type

	tags = {
		Name = var.ec2_instance_name
	}
}