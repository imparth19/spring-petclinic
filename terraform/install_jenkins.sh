#!/bin/bash
sudo yum update

echo "Install git"
sudo yum install -y git

echo "Install wget"
sudo yum install wget -y

echo "Install Java"
sudo dnf install java-1.8.0-openjdk-devel -y

echo "Install Maven"
sudo dnf install maven -y

echo "Install Docker engine"
sudo dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo
sudo dnf install docker-ce --nobest -y
sudo systemctl start docker
sudo systemctl enable docker
sudo chkconfig docker on

echo "Install Jenkins"
sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo
sudo rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key
sudo yum install -y jenkins 
sudo usermod -a -G docker jenkins
sudo chkconfig jenkins on
sudo systemctl start jenkins

sudo dnf update
sudo dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm -y
sudo dnf install ansible -y

sudo wget https://github.com/prometheus/node_exporter/releases/download/v1.0.0-rc.0/node_exporter-1.0.0-rc.0.linux-amd64.tar.gz
tar xvfz node_exporter-1.0.0-rc.0.linux-amd64.tar.gz
#cd node_exporter-1.0.0-rc.0.linux-amd64
#./node_exporter


sudo wget https://github.com/prometheus/prometheus/releases/download/v2.17.1/prometheus-2.17.1.linux-amd64.tar.gz
tar xvf prometheus-2.17.1.linux-amd64.tar.gz
#cd prometheus-2.17.1.linux-amd64
#./prometheus --config.file=./prometheus.yml

sudo wget https://dl.grafana.com/oss/release/grafana-6.7.2-1.x86_64.rpm
sudo yum install grafana-6.7.2-1.x86_64.rpm -y
sudo service grafana-server start
#sudo service grafana-server status
sudo /sbin/chkconfig --add grafana-server

sudo firewall-cmd --permanent --zone=public --add-port=3000/tcp
sudo firewall-cmd --permanent --zone=public --add-port=8080/tcp
sudo firewall-cmd --permanent --zone=public --add-port=8123/tcp
sudo firewall-cmd --permanent --zone=public --add-port=80/tcp
sudo firewall-cmd --reload

echo "=============================================================================="
x="$(cat /var/lib/jenkins/secrets/initialAdminPassword)"
echo Initial Jenkins Password : $x
echo "=============================================================================="

# docker pull imparth/petclinic:latest
# docker run -p -d 80:8080 imparth/petclinic
