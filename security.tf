resource "aws_security_group" "sg" {
  name        = "Security Groups"
  description = "Allow SSH / HTTP inbound traffic"

  ingress {
    description  = "Allow SSH access from anywhere" 
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTP access from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTPS access from anywhere"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description  = "Allow HTTP access from home" 
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["181.194.224.177/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "km-sg"
  }
}
