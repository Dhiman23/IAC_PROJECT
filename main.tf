resource "aws_security_group" "web-sg-1" {
  dynamic "ingress" {
    for_each = var.ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
    
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "jenkins" {
  ami             = "ami-0e86e20dae9224db8"
  instance_type   = "t2.medium"
  key_name        = "imp"
  security_groups = [aws_security_group.web-sg-1.name]
  user_data       = templatefile("./installConfig.sh",{})

  root_block_device {
    volume_size = 20
  }

  tags = {
    Name = "server"
  }

  associate_public_ip_address = true
}