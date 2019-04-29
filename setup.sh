#!/bin/bash

#Selection Dialog

cmd=(dialog --separate-output --checklist "Select Packages to Install:" 22 76 16)
options=(1 "Google Chrome" on    # any option can be set to default to "on"
         2 "Rocketchat" on
         3 "SublimeText" on
         4 "Docker-CE" on
         5 "Docker Repo" off)
choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
clear



read -p "Enter Branch (dev or master): " branch

chrome="https://raw.githubusercontent.com/drpdishant/shell-scripts/$branch/install-chrome.sh"
rocketchat="https://raw.githubusercontent.com/drpdishant/shell-scripts/$branch/install-rocketchat.sh"
sublime="https://raw.githubusercontent.com/drpdishant/shell-scripts/$branch/install-sublime.sh"
docker="https://raw.githubusercontent.com/drpdishant/shell-scripts/$branch/install-docker.sh"
gitclone="https://raw.githubusercontent.com/drpdishant/shell-scripts/$branch/clone-docker_dev.sh"

for choice in $choices
do
    case $choice in
        1)
            echo "First Option"
            ;;
        2)
            echo "Second Option"
            ;;
        3)
            echo "Third Option"
            ;;
        4)
            echo "Fourth Option"
            ;;
        5)  
            echo "Fifth Option"
    esac
done
bash -c "$(curl -sL $chrome)"

bash -c "$(curl -sL $rocketchat)"

bash -c "$(curl -sL $sublime)"

bash -c "$(curl -sL $docker)"

bash -c "$(curl -sL $gitclone)"

