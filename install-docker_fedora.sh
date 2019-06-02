#!/bin/bash
#docker-compose
latest=$(curl --silent "https://api.github.com/repos/docker/compose/releases/latest" | grep -Po '"tag_name": "\K.*?(?=")')
if [ -f /usr/local/bin/docker-compose ] 
then
   echo -e ">> $(docker-compose -v) already installed.\n\n>> Checking if any update is available\n"
   current=$(docker-compose -v | awk '{print $3}' | tr -d '(,)')
   if [ $latest != $current ]
   then 
      echo -e "A newer version $latest is availble .. Installing\n"
      sudo curl -L "https://github.com/docker/compose/releases/download/$latest/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
      sudo chmod +x /usr/local/bin/docker-compose
      #sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
      echo -e ">> Docker Compose Updated to version $latest"
   else
      echo -e ">> Docker Compose is up-to-date."
   fi
else
   echo -e "Docker Compose not found. >>>> Installing \n "
   sudo curl -L "https://github.com/docker/compose/releases/download/$latest/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
   sudo chmod +x /usr/local/bin/docker-compose
   sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
fi

if [ $(dnf -q list installed docker-ce &>/dev/null && echo "1" || echo "0") -eq 0 ];
then
echo -e ">> DOCKER NOT FOUND -- INSTALLING ...."

echo -e ">> REMOVING OLDER VERSIONS IF EXIST"

sudo dnf remove -y -qq docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-selinux \
                  docker-engine-selinux \
                  docker-engine
echo -e ">> Installing dnf-plugins-core"
sudo dnf -y -qq install dnf-plugins-core

echo -e ">> Setting Up Stable Repo"
sudo dnf config-manager \
    --add-repo \
    https://download.docker.com/linux/fedora/docker-ce.repo

echo -e ">> Installing docker-ce docker-ce-cli containerd.io \n"
sudo dnf -y install docker-ce docker-ce-cli containerd.io

echo -e ">> Adding $USER to docker group \n"
sudo usermod -aG docker $USER
else
current=`docker -v | awk '{print $3}' | tr -d '(,|.)'`;
echo -e "\n$(docker -v) already Installed\n"
echo -e "Checking if it can be Updated\n"
sudo dnf -y -qq install docker-ce docker-ce-cli containerd.io
updated=`docker -v | awk '{print $3}' | tr -d '(,|.)'`;
   if [ $current != $updated ];
   then
      echo -e "Updatecurrentd to $(docker -v)\n"
   else
      echo -e "No Update Found!\n"
   fi
fi