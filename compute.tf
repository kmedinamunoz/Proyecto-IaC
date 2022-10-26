# Creates a EC2 Instance
resource "aws_instance" "ubuntu" {
    ami                         = var.ec2-image
    instance_type               = var.instance-type
    iam_instance_profile        = "EC2-SSM-Role"
    associate_public_ip_address = true
    key_name                    = var.key-name
    user_data                   = file("scripts/setup-ec2.sh")

    tags = {
      Name = "UBUNTU"
    }
}