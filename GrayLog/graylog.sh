
# We'll install GrayLog in our home directory, so make sure we're in our home directory and update and upgrade
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


#OPENSEARCH
wget --inet4-only https://artifacts.opensearch.org/releases/bundle/opensearch/2.5.0/opensearch-2.5.0-linux-x64.deb
#download Elasticsearch

wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.10.2-linux-x86_64.tar.gz
wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.10.2-linux-x86_64.tar.gz.sha512
shasum -a 512 -c elasticsearch-7.10.2-linux-x86_64.tar.gz.sha512 
tar -xzf elasticsearch-7.10.2-linux-x86_64.tar.gz
sudo tee -a elasticsearch-7.10.2/config/elasticsearch.yml > /dev/null <<EOT
cluster.name: graylog
action.auto_create_index: false
EOT
# run 


./bin/elasticsearch

sudo systemctl daemon-reload
sudo systemctl --type=service --state=active | grep elasticsearch
#GrayLog Installation

wget https://packages.graylog2.org/repo/packages/graylog-5.0-repository_latest.deb
sudo dpkg -i graylog-5.0-repository_latest.deb
sudo apt-get update && sudo apt-get install graylog-server 

#CHOOSE PASSWORD OR IT WILL NOT RUN
echo -n "Enter Password: " && head -1 </dev/stdin | tr -d '\n' | sha256sum | cut -d" " -f1


## PERSONAL TEST
#ELASTIC INSTALLATION 
wget -q https://artifacts.elastic.co/GPG-KEY-elasticsearch -O myKey
sudo apt-key add myKey
echo "deb https://artifacts.elastic.co/packages/oss-7.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list
sudo apt-get update && sudo ap-get install elasticsearch-oss

#GRAYLOG INSTALLATION
sudo apt-get install graylog-server

#Graylog does NOT start automatically!

#following commands to start Graylog automatically on system boot:
sudo systemctl enable graylog-server.service
sudo systemctl start graylog-server.service

# change the cluster name using sed
sed i- 's/my-application/graylog/g' elasticsearch-7.10.2/config/elasticsearch.yml
echo "action.auto_create_index: false" elasticsearch-7.10.2/config/elasticsearch.yml

sudo apt-get update
#THIS STEP NEED TO BE REVIEWD <<>>
echo -n "Enter Password: " && head -1 </dev/stdin | tr -d '\n' | sha256sum | cut -d" " -f1

echo "http_bind_address = 10.0.100.20:9000" /etc/graylog/server/server.conf

cd /etc/default 
sudo sed -i 's/Xms1g/Xms2g/g' graylog-server
sudo sed -i 's/Xmx1g/Xmx2g/g' graylog-server
cd

sudo systemctl daemon-reload
sudo systemctl enable mongod.service
sudo systemctl restart mongod.service

#There is a problem with elasticsearch-server file, cant found -- > to be reviwed


# 1- Fix elasticsearch-server file
# 2- Generate SHA256 Key and insert it automatcilly to graylog server file
# 3- change to local host ip 
# 4 - test



#After Making the installation easier

#Install MongoDB 6.0
wget -qO - https://www.mongodb.org/static/pgp/server-6.0.asc | sudo apt-key add -

#Create MongoListFile 
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/6.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-6.0.list

#Reload and Start MongoDb

sudo apt-get update
sudo apt install mongodb-org
sudo systemctl daemon-reload
sudo systemctl enable mongod.service
sudo systemctl start mongod

#Install opensearch 

 wget --inet4-only https://artifacts.opensearch.org/releases/bundle/opensearch/2.5.0/opensearch-2.5.0-linux-x64.deb
sudo dpkg -i opensearch-2.5.0-linux-x64.deb
sudo sed -i 's/#cluster.name: my-application/cluster.name: graylog/g' /etc/opensearch/opensearch.yml
sudo sed -i 's/#network.host: 192.168.0.1/network.host: 0.0.0.0/g' /etc/opensearch/opensearch.yml

sudo sed -i '70i discovery.type: single-node' /etc/opensearch/opensearch.yml

sudo sed -i -e '$action.auto_create_index: false' /etc/opensearch/opensearch.yml

sudo systemctl daemon-reload
sudo systemctl enable opensearch.service
sudo systemctl start opensearch
wget --inet4-only https://packages.graylog2.org/repo/packages/graylog-5.0-repository_latest.deb
sudo dpkg -i graylog-5.0-repository_latest.deb
sudo apt update 
sudo apt install graylog-enterprise
sudo apt install pwgen
sudo sed -i 's/password_secret =/password_secret = 3Smj651bunEPSSaA9FQ67aAeNkQVMClm2VEvZZCugzhC5R8cr5SynPQzaqGgltMDd0jyH5ZGky9wpoGQJ4J8JSCA8eqtw2IG/g' /etc/graylog/server/server.conf
sudo sed -i 's/root_password_sha2 =/root_password_sha2 = 8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918/g' /etc/graylog/server/server.conf

sudo systemctl daemon-reload
sudo systemctl enable graylog-server.service
sudo systemctl start graylog-server.service


#Error with opensearch after the installation 
# sudo systemctl status graylog-server 
# this command to check the status and trace the error


