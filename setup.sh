#!/bin/bash

read -e -p "Enter Branch [master]/dev: " -i "master" branch
#check for distro

echo -e "Checking Distro\n"
if [ -f /bin/lsb_release ]
then
    distro=$(lsb_release -si | tr '[:upper:]' '[:lower:]')
    lsb_release -i
else
    if [ -f /etc/fedora-release ]
    then
        distro=$(cat /etc/fedora-release | awk '{print $1}' | tr '[:upper:]' '[:lower:]')
    elif [ -f /etc/os_release ]
        distro=$(cat /os_release | )
    then
        

echo -e "\nPreparing Dialog"

if [ distro = "fedora" ]
then
sudo dnf -y install dialog openssh-server
fi

if [ distro = "ubuntu" ]
then
sudo apt-get -y install dialog openssh-server
fi


#Selection Dialog
# cmd=(dialog --separate-output --checklist "Select Packages to Install:" 22 76 16)
# options=(1 "Google Chrome" on    # any option can be set to default to "on"
#          2 "Rocketchat" on
#          3 "SublimeText" on
#          4 "Docker-CE" on
#          5 "Docker Repo" off
#          6 "MongoDB " off )d
# choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
# clear

# chrome="https://raw.githubusercontent.com/drpdishant/shell-scripts/$branch/install-chrome_$distro.sh"
# rocketchat="https://raw.githubusercontent.com/drpdishant/shell-scripts/$branch/install-rocketchat_$distro.sh"
# sublime="https://raw.githubusercontent.com/drpdishant/shell-scripts/$branch/install-sublime_$distro.sh"
# docker="https://raw.githubusercontent.com/drpdishant/shell-scripts/$branch/install-docker_$distro.sh"
# gitclone="https://raw.githubusercontent.com/drpdishant/shell-scripts/$branch/git_clone.sh"
# mongodb="https://raw.githubusercontent.com/drpdishant/shell-scripts/$branch/install-mongo_$distro.sh"

# for choice in $choices
# do
#     case $choice in
#         1)
#             /bin/bash -c "$(curl -sL $chrome)"
#             echo -e "---------------------------------------------------- \n"
#             ;;
#         2)
#             /bin/bash -c "$(curl -sL $rocketchat)"
#             echo -e "---------------------------------------------------- \n"
#             ;;
#         3)
#             /bin/bash -c "$(curl -sL $sublime)"
#             echo -e "---------------------------------------------------- \n"
#             ;;
#         4)
#             /bin/bash -c "$(curl -sL $docker)"
#             echo -e "---------------------------------------------------- \n"
#             ;;
#         5)  
#             /bin/bash -c "$(curl -sL $gitclone)"
#             echo -e "---------------------------------------------------- \n"
#             ;;
#         6)  
#             /bin/bash -c "$(curl -sL $mongodb)"
#             echo -e "---------------------------------------------------- \n"
#     esac
# done