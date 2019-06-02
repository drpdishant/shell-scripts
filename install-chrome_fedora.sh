#!/bin/bash

if ls $HOME/Downloads/google-chrome* 1> /dev/null 2>&1; then
    echo -e "Chrome Package exists"
else
    echo -e "Chrome doesn't exist   >>>>> Downloading\n"
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.rpm -P ~/Downloads
fi

if [ $(dnf -q list installed google-chrome-stable &>/dev/null && echo "1" || echo "0") -eq 0 ];
then
    sudo dnf -qq -y install ~/Downloads/google-chrome-stable_current_amd64.rpm 
else
echo -e "$(google-chrome-stable --version) already installed \n"
current=`google-chrome-stable --version |  awk '{print $3}'`
echo -e "Checking if it can be updated\n"
sudo dnf -y -qq install google-chrome-stable  
updated=`google-chrome-stable --version |  awk '{print $3}'`
    if [ $current != $updated ];
    then
    echo -e "Updated to $(google-chrome-stable --version)\n"
    else
    echo -e "No Update Found!\n"
    fi
fi