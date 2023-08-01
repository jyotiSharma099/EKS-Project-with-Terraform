##############  RDS Instance  ###################
resource "aws_db_instance" "default" {
  allocated_storage      = 20
  db_name                = "mydbinstance"
  identifier             = "mydbinstance"
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = "db.t3.micro"
  username               = jsondecode(data.aws_secretsmanager_secret_version.current_secrets.secret_string)["username"]
  password               = jsondecode(data.aws_secretsmanager_secret_version.current_secrets.secret_string)["password"]
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.tech-subnet-group.name
  skip_final_snapshot    = true
  publicly_accessible = true

}

# DB Subnet Group
resource "aws_db_subnet_group" "tech-subnet-group" {
  name       = "main"
  subnet_ids = [aws_subnet.private-subnet-1.id, aws_subnet.private-subnet-2.id]
    tags = {
    Name = "tech-subnet-group"
  }
}