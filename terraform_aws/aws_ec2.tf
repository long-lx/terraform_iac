# khai báo provider, xác thực
provider "aws" {
	access_key = "AKIAXCI6MERHSQAK5M77"
	secret_key = "**********************"
	region = "ap-southeast-1" # Singapore region
}

# tạo 1 server instance cấu hình t2.micro
# ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance
resource "aws_instance" "web" {
	count = 2
	ami = "ami-06fb5332e8e3e577a" # Ubuntu OS
	instance_type = "t2.micro"
	key_name = "dev-key"
	security_groups = [aws_security_group.allow_ssh.name]
	
	tags = {
		Name = "web-${count.index}"
	}
}

# tạo 1 ssh key
resource "aws_key_pair" "dev" {
  key_name   = "dev-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDk82OQhlDriNdyKcila7hgvBAA+sFukmQwMS1Z8WGMdMu6jowdrmMIx4eAfGkj0L/LNdpX8uKN8mRH+wcRbWq0lJQEy4sqUIV+4uyVd7FdjWS0n59lnTzykiaAZA2ARIEm5tv8Npy6VNZF3f68Jd74q4T4YTUtF81d2ndhfizNzZQTjz8nb7ZMYEPwQ8eiQiI2yUpsqEjUD4TO/0orRmz31FZ2ipgtUtBMaO4AhlUSGs31Msl0M0LnitXXEXtw8iNsXRxply5dd9eNHJ3Yd1HteO/EQS5XmLdvUIPnDCSxuQg8Y6H8Wydoin07Sp4hwSH1OIwueON0BnQS8c76o46/YUC/sg6cYKNeImF6hFge57+fXG0RVMcwZF2Ti+20TRXkLtujv00XP22yJ2iu+bbhvOF0WhYyAhfB1iyTPrVCR+RCNuMoXkgTmtomSvAiFpRYYwX5vFtO+JeikAgrkW/hHYYh+cHjej6lvKdbFmJ8x3vVnXDRRPZRG2ONH1WnI30= longlx@MacBook-Pro"
}


# tạo security group
resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"

  ingress {
    description      = "SSH from specify IPs"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["14.232.243.111/32"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}

# in ra public ip của ec2 instance
output "ec2_instance_public_ips" {
  value = aws_instance.web.*.public_ip
}
