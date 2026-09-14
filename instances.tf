# resource "aws_instance" "ec1" {
#     ami = "ami-0b6d9d3d33ba97d99"
#     instance_type = "t2.micro"
#     subnet_id = aws_subnet.public1.id
#     vpc_security_group_ids = [aws_security_group.ec2-sg.id]
  
# }

# resource "aws_instance" "ec2" {
#     ami = "ami-0b6d9d3d33ba97d99"
#     instance_type = "t2.micro"
#     subnet_id = aws_subnet.public2.id
#     vpc_security_group_ids = [aws_security_group.ec2-sg.id]
  
# }

#define the template for the ec2 instances to be created
resource "aws_launch_template" "template" {
    name = "template"
    image_id = "ami-0b6d9d3d33ba97d99"
    instance_type = "t2.micro"
    vpc_security_group_ids = [ aws_security_group.ec2-sg.id ]
    key_name = "aws-login-us1"
  
}

#define the auto scaling group
resource "aws_autoscaling_group" "asg" {
    name = "asg"
    desired_capacity = 2
    min_size = 2
    max_size = 4
    vpc_zone_identifier = [ aws_subnet.public1.id,aws_subnet.public2.id ]
  

    launch_template {
    id      = aws_launch_template.template.id
    version = "$Latest"
  }
  target_group_arns = [ aws_alb_target_group.tg.arn ]


  
}

