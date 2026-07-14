#creating Security Group ----------------------------------->
resource "aws_security_group" "sg" {
  name        = "allow_SSH_HTTP"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "allow_SSH_HTTP"
  }
}

#Attaching inbound SSH(22) ----------------------------->
resource "aws_vpc_security_group_ingress_rule" "allow_SSH" {
  security_group_id = aws_security_group.sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

#Attaching inbound HTTP(80) ----------------------------->
resource "aws_vpc_security_group_ingress_rule" "allow_HTTP" {
  security_group_id = aws_security_group.sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

#Attaching Outbound rule
resource "aws_vpc_security_group_egress_rule" "Outbound" {
  security_group_id = aws_security_group.sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}