#!/bin/bash

modprobe dwc2
modprobe g_ether

ifconfig usb0 169.254.10.11 netmask 255.255.0.0 up
route add -net default gw 169.254.10.10


