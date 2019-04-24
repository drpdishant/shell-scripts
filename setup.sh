#!/bin/bash

read -p "Enter Branch (dev or master): " branch

chrome="https://raw.githubusercontent.com/drpdishant/shell-scripts/$branch/install-chrome.sh"
rocketchat="https://raw.githubusercontent.com/drpdishant/shell-scripts/$branch/install-rocketchat.sh"
sublime="https://raw.githubusercontent.com/drpdishant/shell-scripts/$branch/install-sublime.sh"
docker="https://raw.githubusercontent.com/drpdishant/shell-scripts/$branch/install-docker.sh"
gitclone="https://raw.githubusercontent.com/drpdishant/shell-scripts/$branch/clone-docker_dev.sh"

bash -c "$(curl -sL $chrome)"

bash -c "$(curl -sL $rocketchat)"

bash -c "$(curl -sL $sublime)"

bash -c "$(curl -sL $docker)"

bash -c "$(curl -sL $gitclone)"

