provider "aws" {
	region = "ap-southeast-1"
}

resource "aws_instance" "web" {
	ami = "ami-06fb5332e8e3e577a"
	instance_type = "t2.micro"

	tags = {
		Name = "web-0"
	}
}