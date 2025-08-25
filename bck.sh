#!/bin/bash

#Colours
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"

# ctrl + c
trap ctrl_c INT
function ctrl_c(){
    echo -e "${redColour}Exiting...${endColor}"
    exit 1
}

# Finish
function exit(){
    echo -e "${blueColour}[+]We are finished${endColour}"
}
trap exit EXIT

# Helpanel
function helpanel(){
    echo -e "${yellowColour}You must provide bck name, the source path and the destination path${endColour}"
    echo -e "\t${yellowColour}./bck.sh /path/source /path/destination${endColour}"
    echo -e "${yellowColour}Only full paths${endColour}"
}

# Root
if [ "$UID" -ne 0 ]; then
    echo -e "${redColour}[!]No root${endColour}"
fi

# Install tar
if ! command -v tar &>/dev/null; then
    echo -e "${yellowColour}The tar package is not installed, Do you want to install it? [Y/n]${endColour}"
    read con
    if [[ "$con" =~ ^[Yy] ]];then
        sudo apt install tar -y &>/dev/null
    else
        ctrl_c
    fi
fi

# bck
if [ "$#" -ne 3 ]; then
    helpanel
    ctrl_c
fi

if [[ ! "$2" =~ ^[/] ]] || [[ ! "$3" =~ ^[/] ]]; then
    helpanel
    ctrl_c
fi

if [[ "$2" == *\/ ]]; then
    source=$(echo ${2:0:-1})
else
    source="$2"
fi

if [[ "$3" == *\/ ]]; then
    destination=$(echo ${3:0:-1})
else
    destination="$3"
fi

name=$(echo "$1-$(date +%Y-%m-%d-%T).tar.bz2")

tar -cjf ${destination}/${name} "$source"