#! /bin/bash

#Variables

message="Thanks to Itai, and beiop on discord for helping me fix install errors!"

#Functions
function error {
  echo -e "\e[91m$1\e[39m"
  exit 1
}

#Main
echo "${message}"
sudo apt install git || error "Unable to install git!"
if [ -d "/usr/local/bin/Pi-AppsTerm" ];then
  echo "Pi-AppsTerm is already installed! skipping..."
else
  git clone https://github.com/oxmc/Pi-Apps.info.git || error "Unable to download Pi-AppsTerm!"
fi
cd ~
if [ -d "pi-apps" ];then
  echo "Pi-Apps is already installed! skipping..."
else
  git clone https://github.com/Botspot/pi-apps.git || error "Unable to download pi-apps!"
fi
sudo mv Pi-Apps.info /usr/local/bin/Pi-AppsTerm || error "Unable to move folder to /usr/local/bin!"
cd /usr/local/bin/Pi-AppsTerm || error "Unable to change directiry to Pi-AppsTerm!"
sudo chmod +x *.* || error "Unable to change executable permissons!"
sudo cp /usr/local/bin/Pi-AppsTerm/files/Pi-AppsTerm /usr/local/bin/pi-apps || error "Unable to add pi-apps to terminal!"
sudo chmod +x /usr/local/bin/pi-apps || error "Unable to change executable permissons! pi-apps will not work in terminal!"
pi-apps version || error "Unable to run version command, pi-appsterm might be installed incorrectly!"
