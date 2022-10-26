# Creates a VPC
resource "aws_vpc" "VPC" {
    cidr_block       = "172.31.0.0/16"
    instance_tenancy = "default"

    tags = {
      Name = "VPC"
    }
}

# Creates a Subnets
resource "aws_subnet" "SUBNET-1A" {
  vpc_id            = aws_vpc.VPC.id
  cidr_block        = "172.31.0.0/20"
  availability_zone = "us-east-1a"

  tags = {
    Name = "SUBNET-1A"
  }
}

# Creates a Network Interface
resource "aws_network_interface" "network_interface" {
  subnet_id = aws_subnet.SUBNET-1A.id

  tags = {
    Name = "network_interface"
  }
}

# Creates a VPC Internet Gateway
resource "aws_internet_gateway" "kme-igt" {
  vpc_id = aws_vpc.VPC.id

  tags = {
    "Name" = "kme-igt"
  }
}