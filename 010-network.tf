###########################################
#### Create VPC
###########################################
resource "aws_vpc" "vpc-1" {
  cidr_block = "10.42.0.0/16"
  tags = {
    Name = "CL-FTD-VPC"
  }
}

###########################################
#### Create subnets in frist AZ
###########################################
resource "aws_subnet" "subnet_outside-a" {
  vpc_id     = aws_vpc.vpc-1.id
  cidr_block = "10.42.1.0/24"
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "CL-FTD-Outside-a"
  }
}

resource "aws_subnet" "subnet_inside-a" {
  vpc_id     = aws_vpc.vpc-1.id
  cidr_block = "10.42.2.0/24"
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "CL-FTD-Inside-a"
  }
}

resource "aws_subnet" "subnet_management-a" {
  vpc_id     = aws_vpc.vpc-1.id
  cidr_block = "10.42.3.0/24"
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "CL-FTD-Management-a"
  }
}

resource "aws_subnet" "subnet_diag-a" {
  vpc_id     = aws_vpc.vpc-1.id
  cidr_block = "10.42.255.0/24"
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "CL-FTD-diagnostic-a"
  }
}

###########################################
#### Create Internet Gateway
###########################################
resource "aws_internet_gateway" "igw-outside" {
  vpc_id = aws_vpc.vpc-1.id

  tags = {
    Name = "CL-FTD-igw"
  }
}

###########################################
#### Create Elastic IP (Public IP) for Nat Gateways
###########################################
resource "aws_eip" "natgw-a-eip" {
  vpc = true
  tags = {
      Name = "CL-FTD-natgw-a-eip"
  }
}

###########################################
#### Create Nat Gateway
###########################################
resource "aws_nat_gateway" "natgw-a" {
  allocation_id = aws_eip.natgw-a-eip.id
  subnet_id = aws_subnet.subnet_outside-a.id
  tags = {
    Name = "CL-FTD-NatGw-a"
  }
  depends_on = [
    aws_internet_gateway.igw-outside
  ]
}

###########################################
#### Create Route Table
###########################################
resource "aws_route_table" "outside" {
  vpc_id = aws_vpc.vpc-1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw-outside.id
  }

  tags = {
    Name = "CL-FTD-rt-outside"
  }
}

resource "aws_route_table" "internal-a" {
  vpc_id = aws_vpc.vpc-1.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.natgw-a.id
  }

  tags = {
    Name = "CL-FTD-rt-internal-a"
  }
}

###########################################
#### Associate Route Tables with Subnets
###########################################

resource "aws_route_table_association" "assoc-outside-a" {
  subnet_id      = aws_subnet.subnet_outside-a.id
  route_table_id = aws_route_table.outside.id
}

resource "aws_route_table_association" "assoc-mgmt-a" {
  subnet_id      = aws_subnet.subnet_management-a.id
  route_table_id = aws_route_table.outside.id
}

resource "aws_route_table_association" "assoc-inside-a" {
  subnet_id      = aws_subnet.subnet_inside-a.id
  route_table_id = aws_route_table.internal-a.id
}
