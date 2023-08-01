resource "aws_instance" "my-instance" {
  ami             = "ami-0261755bbcb8c4a84"
  instance_type   = "t2.micro"
  key_name        = "eks"
  depends_on      = [aws_db_instance.default, aws_security_group.allow_rds_port]
  subnet_id       = aws_subnet.public-subnet-1.id
  security_groups = [aws_security_group.allow_ec2_instance.id]
  tags = {
    "Name" = "my-instance"
  }

  # Connection Block For Provisioners
  connection {
    type        = "ssh"
    host        = self.public_ip # Understand what is "self"
    user        = "ubuntu"
    password    = ""
    private_key = file("private-key-file/eks.pem")
  }

  # Copies the file to Apache Webserver /var/www/html directory
  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt upgrade -y",
      "sudo apt install mysql-client -y",
      "sudo mysql -h ${aws_db_instance.myinstance.address} -ujyoti -pJyotisharma -e 'CREATE DATABASE wordpress'"
    ]
  }

}