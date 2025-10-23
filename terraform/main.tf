locals {
  private_key_path = "${var.key_dir}/${var.key_name}"
}

# Look up the provided subnet to validate it's in the right VPC and is public
data "aws_subnet" "public" {
  id = var.public_subnet_id
}

# ---- AMI: Amazon Ubuntu ----
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }
}

# ---- Security Group: allow SSH from configured CIDR ----
resource "aws_security_group" "builder_ssh" {
  name        = "builder-ssh"
  description = "Allow SSH access"
  vpc_id      = var.vpc_id

ingress {
  description = "SSH"
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = [var.ssh_ingress_cidr]  # your IP 46.121.130.167/32
}

 ingress {
  description = "App HTTP (port 5001)"
  from_port   = 5001
  to_port     = 5001
  protocol    = "tcp"
  cidr_blocks = [var.ssh_ingress_cidr]  # uses your IP/CIDR, e.g. 46.121.130.167/32
}
  egress {
    description = "All egress"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "builder-ssh"
  }
}

# ---- Register PUBLIC key with AWS (reads the .pub file) ----
resource "aws_key_pair" "builder" {
  key_name   = var.key_name
  public_key = file("${local.private_key_path}.pub")
}

# ---- EC2 Instance in the provided PUBLIC subnet ----
resource "aws_instance" "builder" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  subnet_id                   = data.aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.builder_ssh.id]
  key_name                    = aws_key_pair.builder.key_name
  associate_public_ip_address = true

  tags = {
    Name = "builder"
  }


}
