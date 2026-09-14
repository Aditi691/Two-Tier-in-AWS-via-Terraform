resource "aws_db_instance" "db" {
  allocated_storage    = 20
  db_name              = "mydb"
  engine               = "mysql"
  engine_version       = "8.4"
  instance_class       = "db.t3.micro"
  username             = var.username
  password             = var.password
  parameter_group_name = "default.mysql8.4"
  skip_final_snapshot  = true
  vpc_security_group_ids = [ aws_security_group.db-sg.id ]
  db_subnet_group_name = aws_db_subnet_group.db-subnets.name
}