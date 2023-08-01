# AWS VPC
resource "aws_vpc" "tech" {
  cidr_block           = var.vpc_cidrs[0]
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    "Name" = "vpc-tech"
  }
}

# VPC Subnets
resource "aws_subnet" "public-subnet-1" {
  vpc_id                  = aws_vpc.tech.id
  cidr_block              = var.vpc_cidrs[1]
  availability_zone       = var.vpc_az[0]
  map_public_ip_on_launch = true
  tags = {
    "Name" = "public-subnet-1"
  }
}

resource "aws_subnet" "public-subnet-2" {
  vpc_id                  = aws_vpc.tech.id
  cidr_block              = var.vpc_cidrs[2]
  availability_zone       = var.vpc_az[1]
  map_public_ip_on_launch = true
  tags = {
    "Name" = "public-subnet-2"
  }
}

resource "aws_subnet" "private-subnet-1" {
  vpc_id            = aws_vpc.tech.id
  cidr_block        = var.vpc_cidrs[3]
  availability_zone = var.vpc_az[2]
  tags = {
    "Name" = "private-subnet-1"
  }
}

resource "aws_subnet" "private-subnet-2" {
  vpc_id            = aws_vpc.tech.id
  cidr_block        = var.vpc_cidrs[4]
  availability_zone = var.vpc_az[3]
  tags = {
    "Name" = "private-subnet-2"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "tech-igw" {
  vpc_id = aws_vpc.tech.id
  tags = {
    "Name" = "tech-igw"
  }
}

# Route Tables
resource "aws_route_table" "tech-public-rt" {
  vpc_id = aws_vpc.tech.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tech-igw.id
  }
  tags = {
    "Name" = "tech-public-rt"
  }
}
resource "aws_route_table" "tech-private-rt" {
  vpc_id = aws_vpc.tech.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat.id
  }
  tags = {
    "Name" = "tech-private-rt"
  }
}

# Subnet Association
resource "aws_route_table_association" "public-rt-association-1" {
  subnet_id      = aws_subnet.public-subnet-1.id
  route_table_id = aws_route_table.tech-public-rt.id
}

resource "aws_route_table_association" "public-rt-association-2" {
  subnet_id      = aws_subnet.public-subnet-2.id
  route_table_id = aws_route_table.tech-public-rt.id
}

resource "aws_route_table_association" "private-rt-association-1" {
  subnet_id      = aws_subnet.private-subnet-1.id
  route_table_id = aws_route_table.tech-private-rt.id
}

resource "aws_route_table_association" "private-rt-association-2" {
  subnet_id      = aws_subnet.private-subnet-2.id
  route_table_id = aws_route_table.tech-private-rt.id
}

resource "aws_eip" "nat" {
  vpc = true
  tags = {
    Name = "nat"
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public-subnet-1.id

  tags = {
    Name = "nat"
  }
  depends_on = [aws_internet_gateway.tech-igw]
}