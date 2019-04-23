#!/bin/bash
shopt -s expand_aliases

alias urldecode='python -c "import sys, urllib as ul; print ul.unquote_plus(sys.argv[1])"'
alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1])"'

echo ">>>>> Clone Drupal8-vagrant Repo"

gituser=saurabhd


read -p "Enter Git Password for ($gituser):" -s gitpass

giturlpass=`urlencode $gitpass`

dockerdev="https://$gituser:$giturlpass@github.com/saurabhd/Drupal8-vagrant.git"

#git pull $dockerdev ~/Drupal8-vagrant/
git clone $dockerdev