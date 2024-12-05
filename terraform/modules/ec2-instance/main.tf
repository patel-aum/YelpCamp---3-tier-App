resource "aws_instance" "this" {
  ami             = var.ami_id
  instance_type   = var.instance_type
  key_name        = var.key_name
  vpc_security_group_ids = [var.security_group_id]
  tags            = var.tags
  user_data = var.instance_type == "t2.micro" ? file("nodejs_script.sh") : file("jenkins_sonar_script.sh")
}

# Output public IP for EC2 instance
output "public_ip" {
  value = aws_instance.this.public_ip
}

# EC2 Instance Variables
variable "ami_id" {
  description = "The AMI ID to use for the EC2 instance"
}

variable "instance_type" {
  description = "The EC2 instance type"
}

variable "security_group_id" {
  description = "Security group ID"
}

variable "key_name" {
  description = "Key pair to use for the EC2 instance"
}

variable "tags" {
  description = "Tags for the EC2 instance"
  type        = map(string)
}

