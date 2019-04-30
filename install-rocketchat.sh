#!/bin/bash
latest=$(curl --silent "https://api.github.com/repos/RocketChat/Rocket.Chat.Electron/releases/latest" | grep -Po '"tag_name": "\K.*?(?=")')

if ls $HOME/Downloads/rocketchat* 1> /dev/null 2>&1; then
    echo -e "Rocket Chat Package exists\n"
else
    echo -e "Rocket.Chat doesn't Exist  >>>>> Downloading \n"
    wget https://github.com/RocketChat/Rocket.Chat.Electron/releases/download/$latest/rocketchat_${latest}_amd64.deb -P ~/Downloads
fi

if [ $(dpkg-query -W -f='${Status}' rocketchat 2>/dev/null | grep -c "install ok installed") -eq 0 ];
then
sudo dpkg -i ~/Downloads/rocketchat*
sudo apt-get -f install -y 
else
echo -e "RocketChat $(dpkg -s rocketchat | grep '^Version:') Already Installed\n"
    current=$(dpkg -s rocketchat | grep '^Version:' | awk '{print $2}' | cut -f1 -d "-")
echo -e "Checking if it can be updated\n"
    if [ $current != $latest ]
    then
    rm -rf $HOME/Downloads/rocketchat*
    wget wget https://github.com/RocketChat/Rocket.Chat.Electron/releases/download/$latest/rocketchat_$latest_amd64.deb -P ~/Downloads
    sudo dpkg -i ~/Downloads/rocketchat*
    sudo apt-get -f install -y -qq
    echo -e "Updated Rocketchat to $(dpkg -s rocketchat | grep '^Version:')\n"
    else
    echo -e "No Update Found!\n"
    fi
fi
