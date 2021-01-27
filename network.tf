data "aws_availability_zones" "all" {
}

# Network VPC, gateway, and routes

resource "aws_vpc" "main" {
  cidr_block                       = var.host_cidr
  assign_generated_ipv6_cidr_block = true
  enable_dns_support               = true
  enable_dns_hostnames             = true

  tags = {
    "Name" = var.name
  }
}

resource "aws_internet_gateway" "gateway" {
  vpc_id = aws_vpc.main.id

  tags = {
    "Name" = var.name
  }
}

resource "aws_route_table" "default" {
  vpc_id = aws_vpc.main.id

  tags = {
    "Name" = var.name
  }
}

resource "aws_route" "egress-ipv4" {
  route_table_id         = aws_route_table.default.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gateway.id
}

resource "aws_route" "egress-ipv6" {
  route_table_id              = aws_route_table.default.id
  destination_ipv6_cidr_block = "::/0"
  gateway_id                  = aws_internet_gateway.gateway.id
}

# Subnets (one per availability zone)

resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.main.id
  availability_zone = data.aws_availability_zones.all.names[0]

  cidr_block                      = cidrsubnet(var.host_cidr, 8, 0)
  ipv6_cidr_block                 = cidrsubnet(aws_vpc.main.ipv6_cidr_block, 8, 0)
  map_public_ip_on_launch         = true
  assign_ipv6_address_on_creation = true

  tags = {
    "Name" = "${var.name}-public"
  }
}

resource "aws_route_table_association" "public" {
  route_table_id = aws_route_table.default.id
  subnet_id      = aws_subnet.public.id
}
