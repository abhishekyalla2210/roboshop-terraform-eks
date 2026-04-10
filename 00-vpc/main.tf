resource "aws_vpc" "main" {
  cidr_block       = var.cidr_block
  instance_tenancy = "default"

  tags = {
    Name = "main"
  }
}

resource "aws_internet_gateway" "main" {
    vpc_id = aws_vpc.main.id
    tags = {
       
        Name = "${local.common_name}-igw"
    }
  
}

    resource "aws_subnet" "public_subnet" {
      count = length(var.public_subnet_cidr)
      vpc_id            = aws_vpc.main.id
      cidr_block        = var.public_subnet_cidr[count.index]
      availability_zone = local.az_zones[count.index] # Replace with your desired AZ
      map_public_ip_on_launch = true
      tags = {
        Name = "${local.common_name}-public-subnet"
      }
        
    }

  resource "aws_subnet" "private_subnet" {
      count = length(var.private_subnet_cidr)
      vpc_id            = aws_vpc.main.id
      cidr_block        = var.private_subnet_cidr[count.index]
      availability_zone = local.az_zones[count.index] # Replace with your desired AZ
      map_public_ip_on_launch = false
      tags = {
         Name = "${local.common_name}-private-subnet"
      }
        
    }

resource "aws_eip" "nat" {
  domain = "vpc"  
}

resource "aws_nat_gateway" "ngw" {
    allocation_id = aws_eip.nat.id
    subnet_id     = aws_subnet.public_subnet[0].id

    tags = {
        Name = "${local.common_name}-nat-gateway"
    }
  
}

resource "aws_route_table" "public" {
    vpc_id = aws_vpc.main.id

    tags = {
        Name = "${local.common_name}-public-rt"
    }
  
}


resource "aws_route_table" "private" {
    vpc_id = aws_vpc.main.id

    tags = {
        Name = "${local.common_name}-private-rt"
    }
  
}

    resource "aws_route" "public" {
      route_table_id            = aws_route_table.public.id
      destination_cidr_block    = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.main.id
}

resource "aws_route_table_association" "public_subnet_association" {
    count = length(aws_subnet.public_subnet)
    subnet_id      = aws_subnet.public_subnet[count.index].id
    route_table_id = aws_route_table.public.id

  
}

resource "aws_route_table_association" "private_subnet_association" {
    count = length(aws_subnet.private_subnet)
    subnet_id      = aws_subnet.private_subnet[count.index].id
    route_table_id = aws_route_table.private.id

  
}

   
resource "aws_route" "private" {
  route_table_id            = aws_route_table.private.id
  destination_cidr_block    = "0.0.0.0/0"
  nat_gateway_id =  aws_nat_gateway.ngw.id
}

