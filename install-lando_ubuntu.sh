#!/bin/bash
latest=$(curl --silent "https://api.github.com/repos/lando/lando/releases" | grep -Po '"tag_name": "\K.*?(?=")' | head -n1)
package_name="lando.deb"

if ls $HOME/Downloads/lando* 1> /dev/null 2>&1; then
    echo -e "lando Package exists\n"
else
    echo -e "lando doesn't Exist  >>>>> Downloading \n"
    cd ~/Downloads && { curl -L -o $package_name https://github.com/lando/lando/releases/download/$latest/lando-$latest.deb; cd -; }
fi

if [ $(dpkg-query -W -f='${Status}' lando 2>/dev/null | grep -c "install ok installed") -eq 0 ];
then
sudo dpkg -i ~/Downloads/lando*
sudo apt-get -y -qq -f install  
else
echo -e "lando $(lando version) Already Installed\n"
    current=$(lando version)
echo -e "Checking if it can be updated\n"
    if [ $current != $latest ]
    then
    rm -rf $HOME/Downloads/lando*
    cd ~/Downloads && { curl -L -o $package_name https://github.com/lando/lando/releases/download/$latest/lando-$latest.deb; cd -; }
    sudo dpkg -i ~/Downloads/lando*
    sudo apt-get -y -qq -f install  
    echo -e "Updated lando to $(lando version)\n"
    else
    echo -e "No Update Found!\n"
    fi
fi
