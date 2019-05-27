#!/bin/bash

codename=$(lsb_release -cs)
if [ $(dpkg-query -W -f='${Status}' mongodb-org 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
    echo ">>>>   MongoDB is not installed >>> Installing ....."
    if [ $codename = "disco"  ];

    then
        echo ">>>>  Add MongoDB bionic repo instead of "$codename" into source"
        sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 9DA31620334BD75D9DCB49F368818C72E52529D4
        echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb.list
        sudo apt-get -qq update
        sudo apt-get -y -qq install mongodb-org
    else
        echo ">>>>  Add MongoDB $codename repo into source"
        sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 9DA31620334BD75D9DCB49F368818C72E52529D4
        echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu $codename/mongodb-org/4.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb.list
        sudo apt-get -qq update
        sudo apt-get -y -qqq install mongodb-org
    fi
else
    echo -e ">>>> MongoDB $(mongod --version | awk 'NR==1{print $3}') .. Already Installed\n"
    echo -e ">>>> Mongo Shell $(mongo --version | awk 'NR==1{print $4}') .. Already Installed\n"
    echo -e ">>>> Checking if it can be updated\n"
    CURR_V=$(mongod --version | awk 'NR==1{print $3}')
    sudo apt-get -qqq update
    sudo apt-get -y -qqq install mongodb-org
    NEW_V=$(mongod --version | awk 'NR==1{print $3}')
    if [ $CURR_V = $NEW_V ]
        then
        echo -e "No Update Found\n"
        else
        echo -e ">>>> MONGO DB UPDATED TO LATEST VERSION\n"
        echo -e $(mongod --version | awk 'NR==1{print $3}')
    fi
fi