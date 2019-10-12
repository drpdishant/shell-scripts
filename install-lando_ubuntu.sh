#!/bin/bash
function get_version {
  IFS='/'
  read -ra LINK <<< "$1"
  for i in "${LINK[@]}"; do
    TAG_NAME=$i
  done
  echo $TAG_NAME
}


#if [ "$EUID" -ne 0 ]
#  then echo "Please run lando install script as root"
#  exit
#fi

LAST_LINK=$(curl -I https://github.com/lando/lando/releases/latest | grep "Location" | tr -d '\r')
LAST_LINK=${LAST_LINK:10}
LAST_LINK="${LAST_LINK/tag/download}"
VERSION=$(get_version $LAST_LINK)

DOWNLOAD_LINK="${LAST_LINK}/lando-${VERSION}.deb"
sudo curl -sL -o/var/cache/apt/archives/lando-$VERSION.deb $DOWNLOAD_LINK
sudo dpkg -i /var/cache/apt/archives/lando-$VERSION.deb
exit
