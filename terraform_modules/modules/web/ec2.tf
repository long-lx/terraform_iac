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

  key_name = aws_key_pair.dev.key_name
  security_groups = [aws_security_group.allow_ssh.name]
}

resource "aws_key_pair" "dev" {
  key_name   = "dev-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC4dhkt//ESjV/76kqgwmInONqqEybypz2YRGpyt519uTpnwthIF2MmN0JqcBr/T6+UJvg0LtzkMuJ/KKwzX7TYhYocun6ipkLFnetxM37EUnAEeQAIjduLAaUbwhvz0Hs1/OiTDttW7WDqvhIZzIY0boUbecYn7aE0+EySj0J6zrARLZE9555XAy08jCxXASEkOKi8je7sINSRyAQFnOnKnlNUResHrUm3LEfGE2ne5F1YYBqtX5QSx5Iyp8tmCPqv/CsxCoKrcFnk+DFFK5p0UdDMww7UrPdhbVj7o/FmRsstwIQJ6/QVdWhrhnUGEo3t+tZkwLfeBdB8oSpieiJNJz5CP0zvHsssE4IxeDl1CZ2yfUgl+VhyYkrcdCiadGUE+GKoTLOkjM0cTkZb7NEFFtfudxGmosNOd0NqqfY1nO/Lt9jbfDMmst6U9f1NYJP6CbSAwPvjLcfV+I+eRBgPZQGLTNHFdB4zcomHDBC7zlB9kMUlIIIRPeEWX/o0058= dev@MacBook-Pro"
}

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

  ingress {
    description      = "HTTP from specify IPs"
    from_port        = 80
    to_port          = 80
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

output "ec2_instance_public_ips" {
  value = aws_instance.web.*.public_ip
}