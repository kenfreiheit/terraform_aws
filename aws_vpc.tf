#####################################
# VPC Settings
#####################################
resource "aws_vpc" "vpc_main" {
  cidr_block           = "${var.root_segment}"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"

  tags {
    Name = "${var.app_name}"
  }
}

#####################################
# DHCP Optionset Settings
#####################################
resource "aws_vpc_dhcp_options" "dns_resolver" {
  domain_name_servers = ["AmazonProvidedDNS", "8.8.4.4"]

  tags {
    Name = "${var.app_name} DHCP Optionset"
  }
}

resource "aws_vpc_dhcp_options_association" "dns_resolver" {
  vpc_id          = "${aws_vpc.vpc_main.id}"
  dhcp_options_id = "${aws_vpc_dhcp_options.dns_resolver.id}"
}

#####################################
# Internet Gateway Settings
#####################################
resource "aws_internet_gateway" "vpc_main-igw" {
  vpc_id = "${aws_vpc.vpc_main.id}"

  tags {
    Name = "${var.app_name} igw"
  }
}

#####################################
# Public Subnets Settings
#####################################
resource "aws_subnet" "vpc_main-public-subnet1" {
  vpc_id            = "${aws_vpc.vpc_main.id}"
  cidr_block        = "${var.public_segment1}"
  availability_zone = "${var.public_segment1_az}"
  map_public_ip_on_launch = "true"

  tags {
    Name = "${var.app_name} public-subnet1"
  }
}

#####################################
# Routes Table Settings
#####################################
resource "aws_route_table" "vpc_main-public-rt" {
  vpc_id = "${aws_vpc.vpc_main.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.vpc_main-igw.id}"
  }

  tags {
    Name = "${var.app_name} public-rt"
  }
}

resource "aws_route_table_association" "vpc_main-rta1" {
  subnet_id      = "${aws_subnet.vpc_main-public-subnet1.id}"
  route_table_id = "${aws_route_table.vpc_main-public-rt.id}"
}
