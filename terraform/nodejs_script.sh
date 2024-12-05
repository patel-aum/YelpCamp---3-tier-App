#Update the System
sudo yum update -y

# Install npm (latest version)
curl -sL https://rpm.nodesource.com/setup_21.x | bash -
sudo yum install -y nodejs

# Output npm version for verification
node --version
# Install git
sudo yum install git

