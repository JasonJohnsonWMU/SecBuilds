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

#Update Permission 
cd /opt/tomcat
#Give tomcat group ownership over the entire installation
sudo chown -R tomcat: /opt/tomcat
cd ../../tmp/apache-tomcat-8.5.5
sudo chmod -R g+r conf
#give the tomcat-users access to the conf directory.
sudo chmod -R g+x conf

#Make the Tomcat user the owner of the web apps, temp, logs
sudo chown -R tomcat webapps/ work/ temp/ logs/
#Create tomcat service file in the /etc/ systemd/ system/ directory

cd ../../etc/systemd


