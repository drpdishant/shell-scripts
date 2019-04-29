#!/bin/bash

echo ">>     CHeck for Rocket chat package and Download if not exists"

if ls $HOME/Downloads/rocketchat* 1> /dev/null 2>&1; then
    echo "Rocket Chat Package exists"
else
    echo "Rocket.Chat doesn't Exist  >>>>> Downloading "
    wget wget https://github.com/RocketChat/Rocket.Chat.Electron/releases/download/2.15.2/rocketchat_2.15.2_amd64.deb -P ~/Downloads
fi
if [ $(dpkg-query -W -f='${Status}' rocketchat 2>/dev/null | grep -c "install ok installed") -eq 0 ];
then
sudo dpkg -i ~/Downloads/rocketchat*
sudo apt-get -f install -y 
else
echo "RocketChat Already Installed"
fi
