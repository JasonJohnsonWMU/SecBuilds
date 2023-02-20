
# We'll install Greenbone in our home directory, so make sure we're in our home directory and update and upgrade
cd ~
sudo apt update
sudo apt upgrade -y
# We'll install Graylog v 5.0 and requires the following to maintain compatibility with its software dependencies: 
# OpenJDK 17 (This is embedded in Graylog 5.0 and does not need to be separately installed.)
# OpenSearch 1.x, 2.x or Elasticsearch 7.10.2 
# MongoDB 5.x or 6.x

#Installing MongDB 
# 1- Import the public key used by the package management system.
wget -qO - https://www.mongodb.org/static/pgp/server-6.0.asc | sudo apt-key add -
# 2- Install gnupg and its required libraries using the following command:
sudo apt-get install gnupg
# 3- Once installed, retry importing the key:
wget -qO - https://www.mongodb.org/static/pgp/server-6.0.asc | sudo apt-key add -

#Create the /etc/apt/sources.list.d/mongodb-org-6.0.list file for Ubuntu 22.04 (Jammy):
echo 'deb https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/6.0 multiverse' | sudo tee /etc/apt/sources.list.d/mongodb-org-6.0.list

#Reload local package database
sudo apt-get update
# Install MongoDB Packages 
sudo apt-get install -y mongodb-org

# run mongoDB
sudo systemctl start mongod

#check status 
sudo systemctl status mongod
# The last step for MongoDB is to enable MongoDB during the operating system’s start up and verify it is running.
sudo systemctl daemon-reload
sudo systemctl enable mongod.service
sudo systemctl restart mongod.service
sudo systemctl --type=service --state=active | grep mongod

#download Elasticsearch

wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.10.2-linux-x86_64.tar.gz
wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.10.2-linux-x86_64.tar.gz.sha512
shasum -a 512 -c elasticsearch-7.10.2-linux-x86_64.tar.gz.sha512 
tar -xzf elasticsearch-7.10.2-linux-x86_64.tar.gz
cd elasticsearch-7.10.2
# run 


./bin/elasticsearch

