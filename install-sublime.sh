#!/bin/bash

echo ">>        Check and Install Sublime Text"
if [ $(dpkg-query -W -f='${Status}' sublime-text 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
echo ">>     Download and Install Sublime"

echo ">> ------ Install the GPG key: "

wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo ">> ------ Ensure apt is set up to work with https sources:"

sudo apt-get -y install apt-transport-https
echo ">> ------ Select the channel to use: Stable"

echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
echo ">>     Upadte Cache & Install Sublime Text"
sudo apt-get update
sudo apt-get install sublime-text -y
fi