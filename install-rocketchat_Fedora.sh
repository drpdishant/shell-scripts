#!/bin/bash
latest=$(curl --silent "https://api.github.com/repos/RocketChat/Rocket.Chat.Electron/releases/latest" | grep -Po '"tag_name": "\K.*?(?=")')

if ls $HOME/Downloads/rocketchat* 1> /dev/null 2>&1; then
    echo -e "Rocket Chat Package exists\n"
else
    echo -e "Rocket.Chat doesn't Exist  >>>>> Downloading \n"
    wget https://github.com/RocketChat/Rocket.Chat.Electron/releases/download/$latest/rocketchat-$latest.x86_64.rpm -P ~/Downloads
fi

if [ $(dnf -q list installed rocketchat &>/dev/null && echo "1" || echo "0") -eq 0 ];
then
echo -e ">> Rocket chat is not installed - Installing...."
sudo dnf install -y ~/Downloads/rocketchat-$latest.x86_64.rpm
else
echo -e "RocketChat $(dpkg -s rocketchat | grep '^Version:') Already Installed\n"
    current=$(dpkg -s rocketchat | grep '^Version:' | awk '{print $2}' | cut -f1 -d "-")
echo -e "Checking if it can be updated\n"
    if [ $current != $latest ]
    then
    echo -e "A newer version is available : $latest \n\n - Downloading & Installing "
    rm -rf $HOME/Downloads/rocketchat*
    wget -q https://github.com/RocketChat/Rocket.Chat.Electron/releases/download/$latest/rocketchat-$latest.x86_64.rpm -P ~/Downloads
    sudo dnf install -y -qq ~/Downloads/rocketchat-$latest.x86_64.rpm
    echo -e "Updated Rocketchat to $(dpkg -s rocketchat | grep '^Version:')\n"
    else
    echo -e "No Update Found!\n"
    fi
fi
