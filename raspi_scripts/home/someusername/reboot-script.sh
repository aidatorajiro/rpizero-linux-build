#!/bin/bash
cd $HOME
sudo apt update
sudo apt upgrade -y
echo "w " | sudo ./keyboard2.py
sudo reboot
