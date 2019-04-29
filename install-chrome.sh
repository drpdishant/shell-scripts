#!/bin/bash

if ls $HOME/Downloads/google-chrome* 1> /dev/null 2>&1; then
    echo -e "Chrome Package exists"
else
    echo -e "Chrome doesn't exist   >>>>> Downloading\n"
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -P ~/Downloads
fi

if [ $(dpkg-query -W -f='${Status}' google-chrome-stable 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
    sudo dpkg -i ~/Downloads/google-chrome* 
else
echo -e "$(google-chrome-stable --version) already installed \n"
current=`google-chrome-stable --version |  awk '{print $3}'`
echo -e "Checking if it can be updated\n"
sudo apt-get install google-chrome-stable -y -qq
updated=`google-chrome-stable --version |  awk '{print $3}'`
    if [ $current != $updated ];
    then
    echo -e "Updated to $(google-chrome-stable --version)\n"
    else
    echo -e "No Update Found!\n"
    fi
fi