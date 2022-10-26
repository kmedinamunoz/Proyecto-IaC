# Creates a EC2 Instance
resource "aws_instance" "ubuntu" {
    ami                         = var.ec2-image
    instance_type               = var.instance-type
    iam_instance_profile        = "EC2-SSM-Role"
    associate_public_ip_address = true
    subnet_id                   = aws_subnet.SUBNET-1A.id
    key_name                    = var.key-name
    user_data                   = file("scripts/setup-ec2.sh")
    vpc_security_group_ids      = aws_vpc.VPC.id

    network_interface {
      network_interface_id = aws_network_interface.network_interface.id
      device_index         = 0
    } 

    depends_on = [
      aws_internet_gateway.kme-igt
    ]

    tags = {
      Name = "UBUNTU"
    }
}