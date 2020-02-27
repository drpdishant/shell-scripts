#!/bin/bash
latest=$(curl -I -L -s -S -o /dev/null -w %{url_effective} https://go.microsoft.com/fwlink/?LinkID=760866 | awk -F 'code-insiders-' '{print $2}' | awk -F '.el7' '{print $1}')
package_name="code-insiders.rpm"
if [ $(dnf list installed code-insiders &>/dev/null && echo "1" || echo "0") -eq 0 ];
then
    if ls $HOME/Downloads/code-insiders* 1> /dev/null 2>&1; then
        echo -e "Code Insiders Package Already exists"
    else
        echo -e "Code Insiders Package doesn't exist   >>>>> Downloading\n"
        cd ~/Downloads && { curl -Lo "$package_name" https://go.microsoft.com/fwlink/?LinkID=760866; cd -; }
    fi
    
    if sudo dnf -y install ~/Downloads/$package_name 2>/dev/null
    then echo -e "Installed $(code-insiders --version)"
    else
        echo -e ">> Package is Corrupt - Redownloading..."
        rm -rf ~/Downloads/$(package_name)
        cd ~/Downloads && { curl -Lo "$package_name" https://go.microsoft.com/fwlink/?LinkID=760866; cd -; }
        echo -e ">> Installing ... "
        sudo dnf -y install ~/Downloads/$package_name
    fi
else

current="$(yum info -q code-insiders | awk 'NR==7 {print}' | awk -F ': code-insiders-' '{print $2}' | awk -F '.el7' '{print $1}')"
echo -e "Code Insiders $current already installed \n"
echo -e "Checking if it can be updated\n"  

    if [ $current != $latest ];
    then
    echo -e "An Update is Available, Updating Code Insiders to $latest"
    rm -rf ~/Downloads/$package_name
        cd ~/Downloads && { curl -Lo "$package_name" https://go.microsoft.com/fwlink/?LinkID=760866; cd -; }
        echo -e ">> Installing ... "
        sudo dnf -y install ~/Downloads/$package_name
        echo -e "Code Insiders Updated to version $(yum info -q code-insiders | awk 'NR==7 {print}' | awk -F ': code-insiders-' '{print $2}' | awk -F '.el7' '{print $1}')\n"
    else
    echo -e "Code Insiders is already latest version"
    fi
fi