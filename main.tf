provider "aws" {
    region = "eu-west-2"
}

resource "aws_vpc" "dutch" {
  cidr_block       = "10.8.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "${var.se-name}-vpc"
  }
}

resource "aws_subnet" "mgmt" {
  vpc_id     = aws_vpc.dutch.id
  cidr_block = "10.8.1.0/24"
  map_public_ip_on_launch=true
  tags = {
    Name = "${var.se-name}-mgmt"
  }
}

resource "aws_route_table" "mgmt-rt" {
  vpc_id = aws_vpc.dutch.id

  tags = {
    Name = "${var.se-name}-mgmt-rt"
  }
}

resource "aws_route_table_association" "mgmt-rt-subnet-assoc" {
  subnet_id      = aws_subnet.mgmt.id
  route_table_id = aws_route_table.mgmt-rt.id
}