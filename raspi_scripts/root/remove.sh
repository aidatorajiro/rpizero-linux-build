#!/bin/bash
cd /sys/kernel/config/usb_gadget/g1/
rm configs/c.1/hid.usb0
rm configs/c.1/ecm.usb0
rmdir configs/c.1/strings/0x409
rmdir configs/c.1
echo "" > UDC
rmdir functions/*
rmdir strings/0x409/
cd /sys/kernel/config/usb_gadget
rmdir *
rmmod dwc2
rmmod usb_f_hid
rmmod usb_f_ecm
rmmod usb_f_rndis
rmmod libcomposite
