#!/bin/bash

function checkfor () {

curl 1.1.1.1 1>/dev/null 2>&1

if [ $? -ne 0 ]; then
    sudo nmcli d set wlan0 autoconnect yes managed yes
    sudo nmcli d connect wlan0
    sudo nmcli c up $1
fi

sleep 10

}

checkfor preconfigured
#  checkfor preconfigured2
#  checkfor preconfigured3
#  checkfor preconfigured4
#  checkfor preconfigured5
#  ...
