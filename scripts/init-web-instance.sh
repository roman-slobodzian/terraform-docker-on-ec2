# Docker
sudo yum update -y
sudo amazon-linux-extras install docker -y
sudo amazon-linux-extras enable docker
sudo yum install amazon-ecr-credential-helper -y
sudo service docker start
sudo usermod -a -G docker ec2-user
sudo curl -L https://github.com/docker/compose/releases/download/1.26.0/docker-compose-`uname -s`-`uname -m` -o /usr/bin/docker-compose
sudo chmod +x /usr/bin/docker-compose

mkdir -p /home/ec2-user/app /home/ec2-user/.docker

echo '{"credsStore": "ecr-login"}' > /home/ec2-user/.docker/config.json
