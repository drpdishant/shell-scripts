#!/bin/bash
sudo apt-get update

echo ">>     CHeck for Chrome package and Download if not exists"
if ls $HOME/Downloads/google-chrome* 1> /dev/null 2>&1; then
    echo "Chrome Package exists"
else
    echo "Chrome doesn't exist   >>>>> Downloading "
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -P ~/Downloads
fi

echo ">>     CHeck for Rocket chat package and Download if not exists"

if ls $HOME/Downloads/rocketchat* 1> /dev/null 2>&1; then
    echo "Rocket Chat Package exists"
else
    echo "Rocket.Chat doesn't Exist  >>>>> Downloading "
    wget wget https://github.com/RocketChat/Rocket.Chat.Electron/releases/download/2.15.1/rocketchat_2.15.1_amd64.deb -P ~/Downloads
fi

cd ~/Downloads
sudo dpkg -i ~/Downloads/google-chrome*
sudo dpkg -i ~/Downloads/rocketchat*
sudo apt-get -f install

echo ">>     Download and Install Sublime"

echo ">> ------ Install the GPG key: "

wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo ">> ------ Ensure apt is set up to work with https sources:"

sudo apt-get install apt-transport-https
echo ">> ------ Select the channel to use: Stable"

echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
echo ">>     Upadte Cache & Install Sublime Text"
sudo apt-get update
sudo apt-get install sublime-text

if [ $(dpkg-query -W -f='${Status}' docker 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
echo ">>     Install Docker CE"
sudo apt-get update
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io
sudo usermod -aG docker $USER
fi
