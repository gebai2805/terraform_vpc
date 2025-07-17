provider "aws" {
  region     = "ap-south-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}
resource "aws_instance" "example_1" {
  ami           = "ami-0f918f7e67a3323f0"
  instance_type = "t2.micro"
  key_name      = "geetha"
  tags = {
    Name = "node"
  }
  security_groups = [aws_security_group.terraformsg.name]
}

resource "aws_security_group" "terraformsg" {
  tags = {
    Name = "terraformsg"
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
output "master_public_ip" {
  value = aws_instance.example_1.public_ip
}

output "master_private_ip" {
  value = aws_instance.example_1.private_ip
}

