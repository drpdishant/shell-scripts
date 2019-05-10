#!/bin/bash

codename=$(lsb_release -cs)
if [ $(dpkg-query -W -f='${Status}' mongo 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
    if [ $codename = "disco"  ]

    then
        echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb.list
    else
        echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu $codename/mongodb-org/4.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb.list
    fi

    
fi