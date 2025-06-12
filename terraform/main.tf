provider "aws" {
  region = var.aws_region
}

resource "aws_key_pair" "github_actions_key" {
  key_name   = "github-actions"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_security_group" "web_sg" {
  name        = "web-sg"
  description = "Allow SSH and HTTP"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

data "aws_vpc" "default" {
  default = true
}

resource "aws_instance" "web" {
  ami                    = "ami-08c40ec9ead489470" # Ubuntu 22.04
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.github_actions_key.key_name
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash
              apt-get update -y
              apt-get install -y nginx
              systemctl start nginx
              systemctl enable nginx
              EOF

  tags = {
    Name = "GitHub Deployer"
  }
}

output "instance_ip" {
  value = aws_instance.web.public_ip
}
