#!/bin/bash

branch=dev
chrome="https://raw.githubusercontent.com/drpdishant/shell-scripts/$branch/install-chrome.sh"
rocketchat="https://raw.githubusercontent.com/drpdishant/shell-scripts/$branch/install-rocketchat.sh"
sublime="https://raw.githubusercontent.com/drpdishant/shell-scripts/$branch/install-sublime.sh"
docker="https://raw.githubusercontent.com/drpdishant/shell-scripts/$branch/install-docker.sh"

bash -c "$(curl -sL $chrome)"

bash -c "$(curl -sL $rocketchat"

bash -c "$(curl -sL $sublime)"

bash -c "$(curl -sL $docker)"

