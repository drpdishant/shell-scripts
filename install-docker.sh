#!/bin/bash

un_codename="disco"
codename=$(lsb_release -cs)
if [ $(dpkg-query -W -f='${Status}' docker-ce 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
sudo apt-get update
sudo apt-get -y install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
   if [ $codename = "disco"] ;
   then
   sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   bionic \
   stable"
   else
   sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
   fi
sudo apt-get update
sudo apt-get -y install docker-ce docker-ce-cli containerd.io
sudo usermod -aG docker $USER
else
current=`docker -v | awk '{print $3}' | tr -d '(,|.)'`;
echo -e "$(docker -v) already Installed\n"
echo -e "Checking if it can be Updated\n"
sudo apt-get -y install docker-ce docker-ce-cli containerd.io -qq
updated=`docker -v | awk '{print $3}' | tr -d '(,|.)'`;
   if [ $current != $updated ];
   then
      echo -e "Updatecurrentd to $(docker -v)\n"
   else
      echo -e "No Update Found!\n"
   fi
fi
