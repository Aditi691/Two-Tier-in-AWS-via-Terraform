#create the security group
resource "aws_security_group" "alb-sg" {
    name = "alb-sg"
    vpc_id = aws_vpc.myvpc.id

    ingress {
        description = "HTTP traffic"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        description = "traffic to the internet"
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }
  
}

resource "aws_security_group" "ec2-sg" {
    name = "ec2-sg"
    vpc_id = aws_vpc.myvpc.id

    ingress{
        description = "Traffic from the alb"
        from_port = 8000
        to_port = 8000
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }
    ingress {
        description = "SSH"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        description = "Traffic to the internet"
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
  
}

resource "aws_security_group" "db-sg" {
    name = "db-sg"
    vpc_id = aws_vpc.myvpc.id

    ingress {
        description = "allow mysql from ec2"
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        security_groups = [ aws_security_group.ec2-sg.id ]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
  
}



