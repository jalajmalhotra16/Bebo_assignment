resource "aws_vpc" "vpc_assignment" {
  cidr_block = var.vpc_cidr
}

resource "aws_internet_gateway" "internet_assignment" {
  vpc_id = aws_vpc.vpc_assignment.id

}

resource "aws_subnet" "public_subnets" {
  count                   = var.public_subnets
  vpc_id                  = aws_vpc.vpc_assignment.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 4, count.index)
  availability_zone       = element(var.azs, count.index)
  map_public_ip_on_launch = true
  tags = {
    Name = "Public_subnet"
  }

}

resource "aws_subnet" "private_subnets" {
  count             = var.private_subnets
  vpc_id            = aws_vpc.vpc_assignment.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 4, count.index + var.public_subnets)
  availability_zone = element(var.azs, count.index)
  tags = {
    Name = "Private Subnet"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc_assignment.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_assignment.id
  }

}

resource "aws_route_table_association" "public_rt_assoc" {
  count          = var.public_subnets
  subnet_id      = element(aws_subnet.public_subnets[*].id, count.index)
  route_table_id = aws_route_table.public_rt.id

}

#creating subnets for database
resource "aws_subnet" "private_subnets_for_db" {
  count             = var.private_subnets
  vpc_id            = aws_vpc.vpc_assignment.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 4, count.index + var.public_subnets + var.private_subnets)
  availability_zone = element(var.azs, count.index)
  tags = {
    Name = "Private Subnet_for_db"
  }
}
 
resource "aws_eip" "nat" {
  count  = var.public_subnets
  domain = "vpc"
}


resource "aws_nat_gateway" "nat_assignment" {
  count         = var.public_subnets
  allocation_id = element(aws_eip.nat[*].id, count.index)
  subnet_id     = element(aws_subnet.public_subnets[*].id, count.index)
}

resource "aws_route_table" "private_rt" {
  count  = var.private_subnets
  vpc_id = aws_vpc.vpc_assignment.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = element(aws_nat_gateway.nat_assignment[*].id, count.index)
  }
}

resource "aws_route_table" "private_rt_for_db" {
  count  = var.private_subnets
  vpc_id = aws_vpc.vpc_assignment.id
}


resource "aws_route_table_association" "private_rt_assoc" {
  count          = var.private_subnets
  subnet_id      = element(aws_subnet.private_subnets[*].id, count.index)
  route_table_id = element(aws_route_table.private_rt[*].id, count.index)
}


resource "aws_route_table_association" "private_rt_assoc_for_db" {
  count          = var.private_subnets
  subnet_id      = element(aws_subnet.private_subnets_for_db[*].id, count.index)
  route_table_id = element(aws_route_table.private_rt_for_db[*].id, count.index)
}

resource "aws_ec2_transit_gateway" "transit_assignment" {
  count       = var.enable_transit_gateway ? 1 : 0
  description = "My Transit Gateway"
  tags = {
    Name = "My transit gateway"
  }

}
