#! /bin/bash

#Variables
message="Thanks to Itai, beiop, and Botspot on discord for helping me fix install errors!"
message2="Thanks to Botspot for making pi-apps!"

#Functions
function error {
  echo -e "\e[91m$1\e[39m"
  exit 1
}

#Main
echo "${message}"
echo "${message2}"
bash ~/Pi-AppsTerm/files/checkpackages "git"
if [ -d "/usr/local/bin/Pi-AppsTerm" ];then
  echo "Pi-AppsTerm is already installed, but i will remove it to ensure it is the latest version."
  rm -rf ~/Pi-AppsTerm
  echo "Re-installing Pi-AppsTerm..."
  wget -O - https://oxmc.github.io/Pi-Apps.info/files/Pi-AppsTerm_install.sh | bash || error "Unable to download Pi-AppsTerm!"
else
  echo "Pi-AppsTerm is not installed! installing..."
  git clone https://github.com/oxmc/Pi-AppsTerm.git || error "Unable to download Pi-AppsTerm!"
fi
if [ -d "~/pi-apps" ];then
  echo "Pi-Apps is already installed! skipping..."
else
  echo "Pi-Apps is not installed! Pi-AppsTerm requires this to be installed! installing..."
  git clone https://github.com/Botspot/pi-apps.git || error "Unable to download Pi-Apps!"
fi
sudo mv Pi-AppsTerm /usr/local/bin/Pi-AppsTerm || error "Unable to move folder to /usr/local/bin!"
cd /usr/local/bin/Pi-AppsTerm || error "Unable to change directiry to Pi-AppsTerm!"
sudo chmod +x *.* || error "Unable to change executable permissons!"
sudo cp /usr/local/bin/Pi-AppsTerm/files/Pi-AppsTerm /usr/local/bin/pi-apps || error "Unable to add pi-apps to terminal!"
sudo chmod +x /usr/local/bin/pi-apps || error "Unable to change executable permissons! pi-apps will not work in terminal!"
pi-apps version || error "Unable to run version command, pi-appsterm might be installed incorrectly!"
