
#Download JDK 11
wget https://download.java.net/java/ga/jdk11/openjdk-11_linux-x64_bin.tar.gz
#acting as root
#create JVM Direcotry 
sudo mkdir /usr/lib/jvm

#extract JVM
sudo tar xzvf openjdk-11_linux-x64_bin.tar.gz --directory /usr/lib/jvm

#Link Java
sudo ln -s /usr/lib/jvm/jdk-11/bin/java /usr/bin/java


#Cleaning up
sudo rm openjdk-11_linux-x64_bin.tar.gz 
#Intall Webgoat V2023.4
sudo wget https://github.com/WebGoat/WebGoat/releases/download/v2023.4/webgoat-2023.4.jar
#Update JDK 
sudo apt install openjdk-18-jre-headless
