
################# RDS Security Group #######################
resource "aws_security_group" "allow_rds_port" {
  name        = "Allow_rds_port"
  description = "Allow Port 3306"
  vpc_id      = aws_vpc.tech.id

  ingress {
    description = "Allow Port 3306"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_rds_port"
  }
}

##################### EC2 Instance Security Group #############
resource "aws_security_group" "allow_ec2_instance" {
  name        = "Allow_ec2_instance"
  description = "Allow Port 22 and 80"
  vpc_id      = aws_vpc.tech.id

  ingress {
    description = "Allow Port 80"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow Port 22"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ec2_instance"
  }
}