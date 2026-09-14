resource "aws_alb" "test-alb" {
    name = "test-alb"
    internal = false
    load_balancer_type = "application"
    security_groups = [aws_security_group.alb-sg.id]
    subnets = [ aws_subnet.public1.id,aws_subnet.public2.id ]

  
}

resource "aws_alb_target_group" "tg" {
    name = "sample-tg"
    port = 8000
    protocol = "HTTP"
    vpc_id = aws_vpc.myvpc.id

    health_check {
      path = "/"
      port = "traffic-port"
    }
  
}

# resource "aws_alb_target_group_attachment" "tg1" {
#     target_group_arn = aws_alb_target_group.tg.id
#     target_id = aws_instance.ec1.id
#     port = 8000
  
# }

# resource "aws_alb_target_group_attachment" "tg2" {
#     target_group_arn = aws_alb_target_group.tg.id
#     target_id = aws_instance.ec2.id
#     port = 8000
  
# }
resource "aws_alb_listener" "albl" {
    load_balancer_arn = aws_alb.test-alb.id
    port = 80
    protocol = "HTTP"


    default_action {
      type = "forward"
      target_group_arn = aws_alb_target_group.tg.arn
    }
  
}

