#!/bin/bash

read -e -p "Enter Branch [master]/develop: " -i "master" branch

#check for ID

echo -e "\n>> Checking ID\n"
. /etc/os-release
echo -e "Distrubution Name = $NAME \n"

#Preparing Dialog

if [ $ID = "fedora" ]
    then
        if [ $(dnf -q list installed dialog &>/dev/null && echo "1" || echo "0") -eq 0 ] 
        then
        sudo dnf -y -qq install dialog
        fi
        if [ $(dnf -q list installed openssh-server &>/dev/null && echo "1" || echo "0") -eq 0 ] 
        then
        sudo dnf -y -qq install openssh-server
        fi

elif [ $ID = "ubuntu" ]
then
    if [ $(dpkg-query -W -f='${Status}' dialog 2>/dev/null | grep -c "ok installed") -eq 0 ] 
    then
        sudo apt-get -y install -qq dialog
    fi
    if [ $(dpkg-query -W -f='${Status}' openssh-sever 2>/dev/null | grep -c "ok installed") -eq 0 ] 
    then
        sudo apt-get -y install openssh-server
    fi
fi

# Define Dialog Listing Here

cmd=(dialog --separate-output --checklist "Select Packages to Install:" 22 76 16)
    options=(1 "Google Chrome" on    # any option can be set to default to "on"
         2 "Rocketchat" on
         3 "SublimeText" on
         4 "Code Insiders" off
         5 "Docker-CE" on
         6 "Docker Repo" off
<<<<<<< HEAD
         7 "MongoDB " off
         8 "lando " off )
    choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
clear

curl https://raw.githubusercontent.com/drpdishant/shell-scripts/$branch/create-alias.sh >> ~/.bashrc
=======
         7 "MongoDB " off )
    choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
clear

>>>>>>> 72a9bb022f020e62d0cdddd9c7a6bfeb14232c6b

# Define Installation Script URL Here
chrome="https://raw.githubusercontent.com/drpdishant/shell-scripts/$branch/install-chrome_$ID.sh"
rocketchat="https://raw.githubusercontent.com/drpdishant/shell-scripts/$branch/install-rocketchat_$ID.sh"
sublime="https://raw.githubusercontent.com/drpdishant/shell-scripts/$branch/install-sublime_$ID.sh"
code_insiders="https://raw.githubusercontent.com/drpdishant/shell-scripts/$branch/install-codeinsider_$ID.sh"
docker="https://raw.githubusercontent.com/drpdishant/shell-scripts/$branch/install-docker_$ID.sh"
gitclone="https://raw.githubusercontent.com/drpdishant/shell-scripts/$branch/git_clone.sh"
mongodb="https://raw.githubusercontent.com/drpdishant/shell-scripts/$branch/install-mongo_$ID.sh"
lando="https://raw.githubusercontent.com/drpdishant/shell-scripts/$branch/install-lando_$ID.sh"


#Define Script Execution Here



#Define Script Execution Here

for choice in $choices
do
    case $choice in
        1)
            /bin/bash -c "$(curl -sL $chrome)"
            echo -e "---------------------------------------------------- \n"
            ;;
        2)
            /bin/bash -c "$(curl -sL $rocketchat)"
            echo -e "---------------------------------------------------- \n"
            ;;
        3)
            /bin/bash -c "$(curl -sL $sublime)"
            echo -e "---------------------------------------------------- \n"
            ;;
        4)
            /bin/bash -c "$(curl -sL $code_insiders)"
            echo -e "---------------------------------------------------- \n"
            ;;
        5)
            /bin/bash -c "$(curl -sL $docker)"
            echo -e "---------------------------------------------------- \n"
            ;;
        6)  
            /bin/bash -c "$(curl -sL $gitclone)"
            echo -e "---------------------------------------------------- \n"
            ;;
        7)  
            /bin/bash -c "$(curl -sL $mongodb)"
            echo -e "---------------------------------------------------- \n"\
            ;;
        8)  
            /bin/bash -c "$(curl -sL $lando)"
            echo -e "---------------------------------------------------- \n"
    esac
done
