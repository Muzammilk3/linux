#creating vpc --------------------->
resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "my-vpc"
  }
}

#creating public-subnet ----------------------->
resource "aws_subnet" "pub-subnet" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.0.0/23"

  tags = {
    Name = "public-subnet"
  }
}

#creating private-subnet ------------------------>
resource "aws_subnet" "pri-subnet" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.128.0/23"

  tags = {
    Name = "private-subnet"
  }
}

#createing Internet gateway [IGW] ------------------------>
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "IGW"
  }
}

#craeting public-Route-table -------------------------------->
resource "aws_route_table" "pub-RT" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "public-RT"
  }
}

#craeting private-Route-table -------------------------------->
resource "aws_route_table" "pri-RT" {
  vpc_id = aws_vpc.main.id
  

  tags = {
    Name = "private-RT"
  }
}

#attaching public-Route-table to Public-subnet -------------------------->
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.pub-subnet.id
  route_table_id = aws_route_table.pub-RT.id
}

#attaching private-Route-table to Pivate-subnet -------------------------->
resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.pri-subnet.id
  route_table_id = aws_route_table.pri-RT.id
}

