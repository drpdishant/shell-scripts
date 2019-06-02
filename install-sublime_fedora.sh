#!/bin/bash

if [ -f /opt/sublime_text/sublime_text ];

then
    echo -e -e "$(subl -v) already exists.\n"
    echo "Checking if it can be updated."
    current=$(subl -v | awk '{print $4}')
    sudo dnf -y -qq install sublime-text  
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

sudo rpm -v --import https://download.sublimetext.com/sublimehq-rpm-pub.gpg

echo -e ">> ------ Add Repo to DNF "
sudo dnf -y config-manager --add-repo https://download.sublimetext.com/rpm/stable/x86_64/sublime-text.repo

echo -e ">> ------ Update dnf and install Sublime Text"
sudo dnf -y install sublime-text

fi