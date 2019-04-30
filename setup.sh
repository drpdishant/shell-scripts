#!/bin/bash

read -e -p "Enter Branch [master]/dev: " -i "master" branch
#Check if Dialogs is Installed
echo -e "Preparing Dialog"

sudo apt-get update -qq
sudo apt-get -f install dialog -y -qq

clear
#Selection Dialog
cmd=(dialog --separate-output --checklist "Select Packages to Install:" 22 76 16)
options=(1 "Google Chrome" on    # any option can be set to default to "on"
         2 "Rocketchat" on
         3 "SublimeText" on
         4 "Docker-CE" on
         5 "Docker Repo" off)
choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
clear

chrome="https://raw.githubusercontent.com/drpdishant/shell-scripts/$branch/install-chrome.sh"
rocketchat="https://raw.githubusercontent.com/drpdishant/shell-scripts/$branch/install-rocketchat.sh"
sublime="https://raw.githubusercontent.com/drpdishant/shell-scripts/$branch/install-sublime.sh"
docker="https://raw.githubusercontent.com/drpdishant/shell-scripts/$branch/install-docker.sh"
gitclone="https://raw.githubusercontent.com/drpdishant/shell-scripts/$branch/clone-docker_dev.sh"

for choice in $choices
do
    case $choice in
        1)
            bash -c "$(curl -sL $chrome)"
            echo -e "---------------------------------------------------- \n"
            ;;
        2)
            bash -c "$(curl -sL $rocketchat)"
            echo -e "---------------------------------------------------- \n"
            ;;
        3)
            bash -c "$(curl -sL $sublime)"
            echo -e "---------------------------------------------------- \n"
            ;;
        4)
            bash -c "$(curl -sL $docker)"
            echo -e "---------------------------------------------------- \n"
            ;;
        5)  
            bash -c "$(curl -sL $gitclone)"
            echo -e "---------------------------------------------------- \n"
    esac
done
