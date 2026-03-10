terraform {
  backend "s3" {
    bucket = "ec2-td--new-bc"
    key    = "ec2/terraform.tfstate"
    region = "eu-north-1"
  }
}

resource "aws_security_group" "mysg" {
  name = "tom-sg"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "random_string" "mystring" {
  length  = 10
  special = false
  upper   = false
}

resource "aws_instance" "myec2" {
  ami           = var.myami
  instance_type = var.myinstance
  lifecycle {
    create_before_destroy = true
  }
  security_groups = [aws_security_group.mysg.name]
  user_data       = <<EOF
#!/bin/bash
apt update -y
apt install -y nginx
systemctl enable nginx
systemctl start nginx
echo "<h1>Welcome to Structure AWS with Terraform </h1>" > /var/www/html/index.html
EOF

  tags = {
    Name = "tom-${random_string.mystring.result}"
  }
}