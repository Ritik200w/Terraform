resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name = "my-vpc"
  }
}
#publicsubnet
resource "aws_subnet" "main_subnet" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name                     = "main-subnet"
    "kubernetes.io/role/elb" = "1"
  }

}
#privatesubnet
resource "aws_subnet" "main_private_subnet" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true
  tags = {
    Name                              = "main-private-subnet"
    "kubernetes.io/role/internal-elb" = "1"
  }

}



resource "aws_internet_gateway" "main_igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "main-igw"
  }

}



#elastic Ip
resource "aws_eip" "eks_nat_eip" {
  domain     = "vpc"
  depends_on = [aws_internet_gateway.main_igw]

}


#nat gateway
resource "aws_nat_gateway" "eks_nat_gateway" {
  allocation_id = aws_eip.eks_nat_eip.id
  subnet_id     = aws_subnet.main_subnet.id

  tags = {
    Name = "eks-nat-gateway"
  }

}



#routetable public
resource "aws_route_table" "main_route" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main_igw.id
  }
  tags = {
    Name = "main-route-table"
  }

}

resource "aws_route_table" "main_private_route" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.eks_nat_gateway.id
  }


  tags = {
    Name = "main-private-route-table"
  }

}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.main_subnet.id
  route_table_id = aws_route_table.main_route.id

}

resource "aws_route_table_association" "a1" {
  subnet_id      = aws_subnet.main_private_subnet.id
  route_table_id = aws_route_table.main_private_route.id

}
