# Update the system
#sudo -i 
sudo yum update -y

# Install npm (latest version)
curl -sL https://rpm.nodesource.com/setup_21.x | bash -
sudo yum install -y nodejs

# Output npm version for verification
node --version

# Check if this is the Jenkins-SonarQube instance
    # Install Docker
sudo yum install -y docker
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker ec2-user
sudo chmod 666 /var/run/docker.sock
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

    # Install Java and Jenkins
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
sudo yum upgrade -y
sudo yum install -y java-17-amazon-corretto
sudo yum install -y fontconfig
sudo yum install -y jenkins

    # Start Jenkins
sudo systemctl daemon-reload
sudo systemctl start jenkins
sudo systemctl enable jenkins
sudo systemctl start jenkins.service
    # Install Trivy
sudo rpm -ivh https://github.com/aquasecurity/trivy/releases/download/v0.17.2/trivy_0.17.2_Linux-64bit.rpm

    # Install git
sudo yum install git

sleep 10;
    # Run SonarQube container
docker run -d --name sonar -p 9000:9000 sonarqube:lts-community
