#!/bin/bash

function print-banner () {
    local message="$1"
    echo "##################################"
    echo "$1"
    echo "##################################"
}

function main () {
    print-banner "Updating apt sources list"
    sudo apt-get update
    print-banner "Install packages for apt by https"
    sudo apt-get install \
                    apt-transport-https \
                    ca-certificates \
                    software-properties-common
    print-banner "Installing Vim"
    sudo apt-get install vim
    print-banner "Installing curl"
    sudo apt-get install curl
    print-banner "Installing htop"
    sudo apt-get install htop
    print-banner "Installing pip"
    sudo apt-get install python-pip
    print-banner "Installing docker"
    #docker's official GPG key
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo apt-key fingerprint 0EBFCD88
    #get the stable version of docker
    sudo add-apt-repository \
        "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
        $(lsb_release -cs) \
        stable"
    #finally installing docker
    sudo apt-get update && sudo apt-get install docker-ce
    print-banner "Activating Docker as non-root user"
    sudo usermod -aG docker $(whoami)
}

if  [ "$UID" -ne 0 ] then ;
    echo "Please run as root"
else
    main "$@"
fi