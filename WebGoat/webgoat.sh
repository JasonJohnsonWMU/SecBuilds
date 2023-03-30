sudo apt-get install openjdk-8-jre
#Install TomCat 8
sudo apt-get update
sudo apt-get install default-jdk

sudo groupadd tomcat
#create a tomcat user
sudo useradd -s /bin/false -g tomcat -d /opt/tomcat tomcat

#Download tomcat
sudo wget https://archive.apache.org/dist/tomcat/tomcat-8/v8.5.5/bin/apache-tomcat-8.5.5.tar.gz
#make tomcat directory 
sudo mkdir /opt/tomcat

#Extract tomcat

sudo tar xxvf apache-tomcat-8.5.5.tar.gz

