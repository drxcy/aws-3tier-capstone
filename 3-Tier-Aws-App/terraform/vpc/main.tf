    resource "aws_vpc" "main" {
        cidr_block = var.vpc_cidr
        tags = {
            Name ="Project_VPC"
        }
    }

    resource "aws_subnet" "public" {
        vpc_id = aws_vpc.main.id
        cidr_block = var.public_subnet_cidr
        map_public_ip_on_launch = true
        availability_zone = "ap-south-1a"
        tags = {
            Name = "Public_subnet"
        }
    }
    resource "aws_subnet" "private" {
        vpc_id = aws_vpc.main.id
        cidr_block = var.private_subnet_cidr
        availability_zone = "ap-south-1b"
        tags = {
            Name = "Private_subnet"
        }
    }

    resource "aws_internet_gateway" "igw" {
        vpc_id = aws_vpc.main.id
        tags = {
            Name = "Aws_igw"
        }
    }
    resource "aws_route_table" "public" {
        vpc_id = aws_vpc.main.id
        route {
            cidr_block  = "0.0.0.0/0"
            gateway_id = aws_internet_gateway.igw.id
        }
        tags = {
            Name = "Public_route_table"
        }
    }
    resource "aws_route_table_association" "public"{
        subnet_id = aws_subnet.public.id
        route_table_id = aws_route_table.public.id
    }
