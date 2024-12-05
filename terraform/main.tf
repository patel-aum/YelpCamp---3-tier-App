provider "aws" {
  region = "ap-south-1"
}

# Reference existing security group using data source
data "aws_security_group" "allow_all" {
  id = "sg-052d828db4c5576cc"
}

# EC2 Instance 1: Local Deployment (t2.micro)
module "local_deployment" {
  source            = "./modules/ec2-instance"
  ami_id            = "ami-0614680123427b75e"
  instance_type     = "t2.micro"
  security_group_id = data.aws_security_group.allow_all.id
  key_name          = "terraform-access"
  tags = {
    Name = "LocalDeployment"
  }
}

# EC2 Instance 2: Jenkins-SonarQube (t2.medium)
module "jenkins_sonarqube" {
  source            = "./modules/ec2-instance"
  ami_id            = "ami-0614680123427b75e"
  instance_type     = "t2.medium"
  security_group_id = data.aws_security_group.allow_all.id
  key_name          = "terraform-access"
  tags = {
    Name = "JenkinsSonarQube"
  }
}

# Output public IP addresses for both EC2 instances
output "local_deployment_public_ip" {
  value = module.local_deployment.public_ip
}

output "jenkins_sonarqube_public_ip" {
  value = module.jenkins_sonarqube.public_ip
}
