#!/bin/bash

#shopt -s direxpand
#shopt -s expand_aliases

#alias urldecode='python -c "import sys, urllib as ul; print ul.unquote_plus(sys.argv[1])"'
#alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1])"'

echo ">>>>> Clone Drupal8-vagrant Repo"

gituser=saurabhd


read -p "Enter Git Password for ($gituser):" -s gitpas

giturlpass=`urlencode $gitpass`

dockerdev="https://github.com/saurabhd/Drupal8-vagrant.git"


if [ -d ~/Drupal8-vagrant ]
then
    echo "Repo Already Exists >> Executing Git Pull"
    git pull origin master
else
    git clone $dockerdev ~/Drupal8-vagrant
fi