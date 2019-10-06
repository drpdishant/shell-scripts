#!/bin/bash
latest=$(curl -I -L -s -S -o /dev/null -w %{url_effective} https://go.microsoft.com/fwlink/?LinkID=760866 | awk -F 'code-insiders-' '{print $2}' | cut -d "-" -f1)
package_name="code-insiders.rpm"
if [ $(dnf -q list installed code-insiders &>/dev/null && echo "1" || echo "0") -eq 0 ];
then
    if ls $HOME/Downloads/code-insiders* 1> /dev/null 2>&1; then
        echo -e "Code Insiders Package Already exists"
    else
        echo -e "Code Insiders Package doesn't exist   >>>>> Downloading\n"
        cd ~/Downloads && { curl -Lo "$(package_name)" https://go.microsoft.com/fwlink/?LinkID=760866; cd -; }
    fi
    
    if sudo dnf -q -y install ~/Downloads/$(package_name) 2>/dev/null
    then echo -e "Installed $(code-insiders --version)"
    else
        echo -e ">> Package is Corrupt - Redownloading..."
        rm -rf ~/Downloads/$(package_name)
        cd ~/Downloads && { curl -Lo "$(package_name)" https://go.microsoft.com/fwlink/?LinkID=760866; cd -; }
        echo -e ">> Installing ... "
        sudo dnf -q -y install ~/Downloads/$(package_name)
    fi
else
echo -e "$(code-insiders -v | head -n1) already installed \n"
current="$(yum info -q code-insiders | awk 'NR==3 {print}' | cut -d ":" -f2 | cut -d " " -f2)"
echo -e "Checking if it can be updated\n"  

    if [ $current != $latest ];
    then
    echo -e "An Update is Available, Updating Code Insiders to $latest"
    rm -rf ~/Downloads/$(package_name)
        cd ~/Downloads && { curl -Lo "$(package_name)" https://go.microsoft.com/fwlink/?LinkID=760866; cd -; }
        echo -e ">> Installing ... "
        sudo dnf -q -y install ~/Downloads/google-chrome-stable_current_x86_64.rpm
        echo -e "Code Insiders Updated to version $(code-insiders -v | head -n1)\n"
    else
    echo -e "Code Insiders is already latest version"
    fi
fi