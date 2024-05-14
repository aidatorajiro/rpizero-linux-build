#!/bin/bash -eu
modprobe dwc2
modprobe libcomposite

cd /sys/kernel/config/usb_gadget
mkdir -p ./g1
cd ./g1

echo 0x1d6b > idVendor # Linux Foundation
echo 0x0104 > idProduct # Multifunction Composite Gadget
echo 0x0100 > bcdDevice # v1.0.0
echo 0x0200 > bcdUSB # USB2

echo 0xEF > bDeviceClass
echo 0x02 > bDeviceSubClass
echo 0x01 > bDeviceProtocol


mkdir -p strings/0x409

echo "ONLY00HID1234567" > strings/0x409/serialnumber
echo "USB_GADGET" > strings/0x409/manufacturer
echo "Linux USB Gadget/HID" > strings/0x409/product

USBN="usb0"
CONF=1

mkdir -p configs/c.${CONF}
echo 0xA0 > configs/c.${CONF}/bmAttributes
echo 100 > configs/c.${CONF}/MaxPower
mkdir -p configs/c.${CONF}/strings/0x409
echo "HID" > configs/c.${CONF}/strings/0x409/configuration

### HID

# USBN="usb1"
# CONF=2
# mkdir -p configs/c.${CONF}/strings/0x409

mkdir -p functions/hid.${USBN}
echo 1 > functions/hid.${USBN}/protocol
echo 1 > functions/hid.${USBN}/subclass
echo 8 > functions/hid.${USBN}/report_length
echo -ne \\x05\\x01\\x09\\x06\\xa1\\x01\\x05\\x07\\x19\\xe0\\x29\\xe7\\x15\\x00\\x25\\x01\\x75\\x01\\x95\\x08\\x81\\x02\\x95\\x01\\x75\\x08\\x81\\x01\\x95\\x05\\x75\\x01\\x05\\x08\\x19\\x01\\x29\\x05\\x91\\x02\\x95\\x01\\x75\\x03\\x91\\x01\\x95\\x06\\x75\\x08\\x15\\x00\\x25\\xff\\x05\\x07\\x19\\x00\\x29\\xff\\x81\\x00\\xc0 > functions/hid.${USBN}/report_desc
echo 1 > functions/hid.${USBN}/wakeup_on_write
ln -s functions/hid.${USBN} configs/c.${CONF}/

ls /sys/class/udc > UDC



