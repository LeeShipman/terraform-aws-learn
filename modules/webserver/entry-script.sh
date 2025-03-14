
#!/bin/bash
sudo yum update -y && sudo yum install docker -y
sudo systemctl start docker
sleep 10
sudo docker pull nginx >> /var/log/user-data.log 2>&1
sudo docker run -d -p 8080:80 nginx >> /var/log/user-data.log 2>&1
