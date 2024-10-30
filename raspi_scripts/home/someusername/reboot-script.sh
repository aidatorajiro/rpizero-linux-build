#!/bin/bash
cd $HOME
sudo apt update
sudo apt upgrade -y
sudo python -c "import sys; import os; sys.path.append(os.path.join(os.path.abspath('Py_Keyboard'))); from Py_Keyboard.HID import Keyboard; Keyboard()"
sudo reboot
