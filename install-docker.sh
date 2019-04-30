#!/bin/bash
#docker-compose
if [ -f /usr/local/bin/docker-compose ] 
then
   echo "$(docker-compose -v) already installed.\n"
else
   echo "Docker Compose not found. >>>> Installing "
   sudo curl -sL "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
   sudo chmod +x /usr/local/bin/docker-compose
   sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
fi

un_codename="disco"
codename=$(lsb_release -cs)
if [ $(dpkg-query -W -f='${Status}' docker-ce 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
sudo apt-get -qq update
sudo apt-get -y -qq  install \
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
sudo apt-get -qq update
sudo apt-get -y -qq  install docker-ce docker-ce-cli containerd.io
sudo usermod -aG docker $USER
else
current=`docker -v | awk '{print $3}' | tr -d '(,|.)'`;
echo -e "$(docker -v) already Installed\n"
echo -e "Checking if it can be Updated\n"
sudo apt-get -y -qq  install docker-ce docker-ce-cli containerd.io 
updated=`docker -v | awk '{print $3}' | tr -d '(,|.)'`;
   if [ $current != $updated ];
   then
      echo -e "Updatecurrentd to $(docker -v)\n"
   else
      echo -e "No Update Found!\n"
   fi
fi
