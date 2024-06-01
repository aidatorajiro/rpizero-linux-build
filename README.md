# Raspberry pi zero kernel build tool & other scripts

This is a script to build a custom raspberry pi kernel, including a kernel patch to fix dwc2 wakeup issue.

Also, the directory `raspi_scripts` contains utilities to setup HID keyboard, RNDIS or ECM. Using a python library by @Danny-Dasilva (<https://github.com/Danny-Dasilva/Py_Keyboard>)

Patch reference: <https://github.com/pikvm/packages/blob/master/packages/linux-rpi-pikvm/1003-remote-wakeup.patch> <https://github.com/raspberrypi/linux/issues/3977> <http://www.dt8.jp/cgi-bin/adiary/adiary.cgi/0583>

1. (if you are using selinux, run this script to allow write access from docker) `sh selinux.sh`
1. `sh download.sh`
1. `sh docker.sh`
1. (inside docker) `cd /rpizero-linux-build`
1. (inside docker) `sh clean.sh`
1. (inside docker) `sh build.sh`
1. (inside docker) `exit`
1. `sh pack.sh`
1. `sh packsend.sh`

Adjust `names.sh` to configure hostname and username for ssh connection, or customize kernel name.

## known issues

although without the dwc2 patch `/root/remove.sh` works, with dwc2 patch it does not work. anyway its safer to restart the system when you change usb config.

