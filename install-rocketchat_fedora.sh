#!/bin/bash
latest=$(curl --silent "https://api.github.com/repos/RocketChat/Rocket.Chat.Electron/releases/latest" | grep -Po '"tag_name": "\K.*?(?=")')

if ls $HOME/Downloads/rocketchat* 1> /dev/null 2>&1; then
    echo -e "Rocket Chat Package exists\n"
else
    echo -e "Rocket.Chat doesn't Exist  >>>>> Downloading \n"
    cd ~/Downloads && { curl -O https://github.com/RocketChat/Rocket.Chat.Electron/releases/download/$latest/rocketchat-$latest.x86_64.rpm; cd -; }
fi

if [ $(dnf -q list installed rocketchat &>/dev/null && echo "1" || echo "0") -eq 0 ];
then
echo -e ">> Rocket chat is not installed - Installing...."
 sudo dnf install -y ~/Downloads/rocketchat-$latest.x86_64.rpm
else
current=$(dnf -q list installed rocketchat | awk 'FNR == 2 {print $2}' | sed 's/-.*//')
echo -e "RocketChat $current Already Installed\n"
echo -e "Checking if it can be updated\n"

    if [ $current != $latest ]
    then
    echo -e "A newer version is available : $latest \n\n - Downloading & Installing "
    rm -rf ~/Downloads/rocketchat*
    cd ~/Downloads && { curl -O https://github.com/RocketChat/Rocket.Chat.Electron/releases/download/$latest/rocketchat-$latest.x86_64.rpm; cd -;}
    sudo dnf install -y -qq ~/Downloads/rocketchat-$latest.x86_64.rpm
    echo -e "Updated Rocketchat to $(dpkg -s rocketchat | grep '^Version:')\n"
    else
    echo -e "No Update Found!\n"
    fi
fi
