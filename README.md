# shell-scripts
## Install all regular program
It will fetch and run scripts directly from the web using curl
So first of all we need to install curl
``` sudo apt-get update && sudo apt-get install curl ```

## Beginning the Installation
After installing curl you can now run the following command to begin the setup.
You'll be prompted to enter branch to be used: (Default is "master")
######dev is for development purposes only, you might end up with a buggy codes

```/bin/bash -c "$(curl -sL https://raw.githubusercontent.com/drpdishant/shell-scripts/master/setup.sh)"```
