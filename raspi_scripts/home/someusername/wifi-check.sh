#!/bin/bash
curl 1.1.1.1 1>/dev/null 2>&1

if [ $? -ne 0 ]; then
    sudo nmcli d set wlan0 autoconnect yes managed yes
    sudo nmcli d connect wlan0
    sudo nmcli c up preconfigured
fi
