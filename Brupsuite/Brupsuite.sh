
#Installing PIP 3 

sudo apt install python3-pip
#Install gdown
sudo pip install gdown
gdown https://drive.google.com/uc?id=1kn1xQVVgnU_354kpRSHKRyDw_O6a-6NM
sudo chmod +x  burpsuite_community_linux_v2023_2_3.sh
sudo ./burpsuite_community_linux_v2023_2_3.sh 

#Installing Java to run burp
sudo apt install default-jre
#Launch Burp from terminal, Preferd to run from the main screen
#cd ../../usr/local/BurpSuiteCommunity
#sudo java -jar -Xmx4g burpsuite_community.jar
