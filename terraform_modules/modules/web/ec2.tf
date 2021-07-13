# web module

variable "ec2_instance_name" {}
variable "ec2_ami" {}
variable "ec2_instance_type" {}
variable "ec2_instance_number" {}

resource "aws_instance" "web" {
  count         = var.ec2_instance_number
  ami           = var.ec2_ami
  instance_type = var.ec2_instance_type

  tags = {
    Name = "${var.ec2_instance_name}-${count.index}"
  }
}
