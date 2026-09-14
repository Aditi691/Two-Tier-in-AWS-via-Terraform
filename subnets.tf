#create public subnets
resource "aws_subnet" "public1" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = true
}

resource "aws_subnet" "public2" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "us-east-1b"
    map_public_ip_on_launch = true
}

# #create private subnets
resource "aws_subnet" "private1" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = "10.0.11.0/24"
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = false
  
}

resource "aws_subnet" "private2" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = "10.0.12.0/24"
    availability_zone = "us-east-1b"
    map_public_ip_on_launch = false
  
}

#subnet group for the db
resource "aws_db_subnet_group" "db-subnets" {
  name       = "db-subnets"
  subnet_ids = [aws_subnet.private1.id,aws_subnet.private2.id]
}


