KUBECTX_PATH='/opt/kubectx'
if [ ! -d $KUBECTX_PATH ]
then
  sudo git clone https://github.com/ahmetb/kubectx /opt/kubectx
else 
  if [ ! -f $KUBECTX/kubectx && ! -f $KUBECTX/kubens ]
  then
     sudo git clone https://github.com/ahmetb/kubectx /opt/kubectx
  else
    echo ">>> kubectx and kubens already cloned"
  fi
fi

  
