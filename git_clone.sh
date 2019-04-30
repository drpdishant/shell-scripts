#!/bin/bash


echo ">>>>> Clone Drupal8-vagrant Repo"

dockerdev="https://github.com/saurabhd/Drupal8-vagrant.git"


if [ -d ~/Drupal8-vagrant ]
then
    echo "Repo Already Exists >> Executing Git Pull"
    git pull origin master
else
    git clone $dockerdev ~/Drupal8-vagrant
fi