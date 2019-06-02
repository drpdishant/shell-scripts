#!/bin/bash
cmd=(dialog --separate-output --checklist "Select Packages to Install:" 22 76 16)
options=(1 "Google Chrome" on    # any option can be set to default to "on"
         2 "Rocketchat" on
         3 "SublimeText" on
         4 "Docker-CE" on
         5 "Docker Repo" off)
choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
clear
for choice in $choices
do
    case $choice in
        1)
            echo "First Option"
            ;;
        2)
            echo "Second Option"
            ;;
        3)
            echo "Third Option"
            ;;
        4)
            echo "Fourth Option"
            ;;
        5)  
            echo "Fifth Option"
    esac
done

cmd=(dialog --separate-output --title "Mongo Install" --option "Select Packages to Install:" 22 76 16)
options=(1 "4.0" on    # any option can be set to default to "on"
         2 "4.1" off)
choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
clear