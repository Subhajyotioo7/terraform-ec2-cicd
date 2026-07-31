provider "aws" {
  region = "ap-south-1"
}

resource "aws_security_group" "web_sg" {
  name        = "web-sg"
  description = "Allow HTTP and SSH"

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

resource "aws_instance" "my_ec2" {
  ami                    = "ami-0287a05f0ef0e9d9a"
  instance_type          = "t3.micro"
  key_name               = "python-to-aws"
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  user_data = templatefile("user_data.sh.tpl", {
    html_content = file("app/index.html")
  })

  tags = {
    Name = "python-terraform-ec2"
  }
}

output "public_ip" {
  value = aws_instance.my_ec2.public_ip
}

output "site_url" {
  value = "http://${aws_instance.my_ec2.public_ip}"
}