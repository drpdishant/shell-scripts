#!/bin/bash

if [ -f /opt/sublime_text/sublime_text ];

then
echo -e -e "$(subl -v) already exists.\n"
echo "Checking if it can be updated."
current=$(subl -v | awk '{print $4}')
sudo apt-get -y -qq install sublime-text  
updated=$(subl -v | awk '{print $4}')
    if [ $current != $updated ];
    then
        echo -e "Updated to $(subl -v)\n"
    else
        echo -e "No Update Found!\n"
    fi

else
echo -e ">>     Download and Install Sublime\n"

echo -e ">> ------ Install the GPG key: \n"

curl -L https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo -e ">> ------ Ensure apt is set up to work with https sources:\n"

sudo apt-get -y -qq  install apt-transport-https
echo -e ">> ------ Select the channel to use: Stable"

echo -e "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
echo -e ">>     Upadte Cache & Install Sublime Text\n"
sudo apt-get -qq update
sudo apt-get -y -qq install sublime-text 
fi
