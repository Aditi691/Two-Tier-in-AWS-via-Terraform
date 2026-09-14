#create a route table for public subnets
resource "aws_route_table" "rt1" {
    vpc_id = aws_vpc.myvpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.myigw.id
    }
    
}

#create a route table for private subnets
resource "aws_route_table" "rta2" {
    vpc_id = aws_vpc.myvpc.id
}

#associate the route table with a subnet
resource "aws_route_table_association" "rta1" {
    subnet_id = aws_subnet.public1.id
    route_table_id = aws_route_table.rt1.id
}

resource "aws_route_table_association" "rta2" {
    subnet_id = aws_subnet.public2.id
    route_table_id = aws_route_table.rt1.id
}

# resource "aws_route_table_association" "rta3" {
#     subnet_id = aws_subnet.private1.id
#     route_table_id = aws_route_table.rta2.id
  
# }

# resource "aws_route_table_association" "rta4" {
#     subnet_id = aws_subnet.private2.id
#     route_table_id = aws_route_table.rta2.id

  
# }