#creating public instance ------------------->
resource "aws_instance" "pub-ins" {
  ami           = "ami-05d2d839d4f73aafb"
  instance_type = "t3.micro"

  subnet_id = aws_subnet.pub-subnet.id #Attaching subnet to an instance

  associate_public_ip_address = true #Attaching public IP

  vpc_security_group_ids = [aws_security_group.sg.id] #attaching security group 

  tags = {
    Name = "instance"
  }
}