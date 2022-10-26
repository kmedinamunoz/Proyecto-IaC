variable "ec2-image" {
    type            = string
    description     = "Application and OS Images (Amazon Machine Image)"
    default         = "ami-08c40ec9ead489470"

    validation {
      condition     = length(var.ec2-image) > 4 && substr(var.ec2-image, 0,4) == "ami-"
      error_message = "The image value must be a valid AMI id, starting with \"ami-\"."
    }
}
variable "instance-type" {
    type        = string
    description = "Instance Type"
    default     = "t2.micro"
}

variable "key-name" {
    type        = string
    description = "Key-Pair name for EC2 instance "
    default     = "us-east-1"
  
}