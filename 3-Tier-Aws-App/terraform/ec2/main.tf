data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}


resource "aws_security_group" "web_sg" {
  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id
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

  tags = {
    Name = "ec2-web-sg"
  }
}

resource "aws_instance" "web" {
  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = var.instance_type
  subnet_id                   = data.terraform_remote_state.vpc.outputs.Public_subnet_id
  vpc_security_group_ids      = [aws_security_group.web_sg.id]
  key_name      = "my-vpc-server-key"
  associate_public_ip_address = true
   user_data = <<-EOF
  #!/bin/bash
  dnf update -y
  dnf install -y httpd
  systemctl enable httpd
  systemctl start httpd
  echo "Hello from EC2 $(hostname)" > /var/www/html/index.html
EOF

  tags = {
    Name = "aws-backend-ec2"
  }
}
