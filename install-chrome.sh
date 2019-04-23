#!/bin/bash

echo ">>     CHeck for Chrome package and Download if not exists"
if ls $HOME/Downloads/google-chrome* 1> /dev/null 2>&1; then
    echo "Chrome Package exists"
else
    echo "Chrome doesn't exist   >>>>> Downloading "
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -P ~/Downloads
fi

if [ $(dpkg-query -W -f='${Status}' google-chrome-stable 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
sudo dpkg -i ~/Downloads/google-chrome*
fi