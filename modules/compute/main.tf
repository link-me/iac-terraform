data "aws_ami" "al2023" {
  count       = var.ami_id == null ? 1 : 0
  owners      = ["137112412989"] # Amazon
  most_recent = true

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}

resource "aws_security_group" "web" {
  name        = "${var.project_name}-${var.environment}-web-sg"
  description = "Allow SSH and HTTP"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.allow_ssh_cidr]
  }

  ingress {
    description = "HTTP"
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
    Name        = "${var.project_name}-${var.environment}-web-sg"
    Environment = var.environment
  }
}

resource "aws_instance" "web" {
  ami                         = var.ami_id != null ? var.ami_id : data.aws_ami.al2023[0].id
  instance_type               = var.instance_type
  subnet_id                   = var.public_subnet_id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.web.id]

  user_data = <<-EOF
              #!/bin/bash
              dnf install -y httpd
              echo "<h1>${var.project_name} (${var.environment}) is up</h1>" > /var/www/html/index.html
              systemctl enable httpd
              systemctl start httpd
              EOF

  tags = {
    Name        = "${var.project_name}-${var.environment}-web"
    Environment = var.environment
  }
}