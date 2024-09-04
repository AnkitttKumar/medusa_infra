resource "aws_vpc" "medusa_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "medusa_subnet" {
  count                   = 2
  vpc_id                  = aws_vpc.medusa_vpc.id
  cidr_block              = cidrsubnet(aws_vpc.medusa_vpc.cidr_block, 8, count.index)
  map_public_ip_on_launch = true
  availability_zone       = element(data.aws_availability_zones.available.names, count.index)
}

resource "aws_internet_gateway" "medusa_igw" {
  vpc_id = aws_vpc.medusa_vpc.id
}

resource "aws_route_table" "medusa_route_table" {
  vpc_id = aws_vpc.medusa_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.medusa_igw.id
  }
}

resource "aws_route_table_association" "medusa_route_table_association" {
  count          = 2
  subnet_id      = element(aws_subnet.medusa_subnet.*.id, count.index)
  route_table_id = aws_route_table.medusa_route_table.id
}

