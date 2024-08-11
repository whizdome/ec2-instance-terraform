resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "dev"
  }
}

resource "aws_subnet" "main_public_subnet" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.0.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"

  tags = {
    name = "dev-public"
  }
}

resource "aws_internet_gateway" "main_internet_gateway" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "dev-internet-gateway"
  }
}

resource "aws_route_table" "main_public_route_table" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "dev-public-route-table"
  }
}

resource "aws_route" "main_public_route" {
  route_table_id         = aws_route_table.main_public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main_internet_gateway.id
}

resource "aws_route_table_association" "main_public_route_table_association" {
  subnet_id      = aws_subnet.main_public_subnet.id
  route_table_id = aws_route_table.main_public_route_table.id
}

resource "aws_security_group" "main_security_group" {
  name        = "dev-security-group"
  description = "dev-security-group"
  vpc_id      = aws_vpc.main.id

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

  tags = {
    Name = "dev-security-group"
  }
}

resource "aws_key_pair" "main_key_pair" {
  key_name   = "dev-key-pair"
  public_key = file("~/.ssh/mainkey.pub")
}

resource "aws_instance" "dev_node_instance" {
  ami                   =  data.aws_ami.server_ami.id
  instance_type         = "t2.micro"
  key_name              = aws_key_pair.main_key_pair.id
  vpc_security_group_ids = [aws_security_group.main_security_group.id]
  subnet_id                = aws_subnet.main_public_subnet.id
  user_data = file("userdata.tpl")

root_block_device {
    volume_size = 10
}

  tags = {
    Name = "dev-node-instance"
  }

provisioner "local-exec" {
    command = <<-EOT
      Add-Content -Path "$env:USERPROFILE\.ssh\config" -Value @"

Host ${self.public_ip}
  Hostname ${self.public_ip}
  User ubuntu
  IdentityFile ~/.ssh/mainkey
"@
    EOT
    interpreter = ["PowerShell", "-Command"]
  }
}
