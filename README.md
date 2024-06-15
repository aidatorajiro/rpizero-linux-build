# Raspberry pi zero kernel build tool & other scripts

This is a script to build a custom raspberry pi kernel, including a kernel patch to fix dwc2 wakeup issue.

Also, the directory `raspi_scripts` contains utilities to setup HID keyboard, RNDIS or ECM. Using a python library by @Danny-Dasilva (<https://github.com/Danny-Dasilva/Py_Keyboard>)

Patch reference: <https://github.com/pikvm/packages/blob/master/packages/linux-rpi-pikvm/1003-remote-wakeup.patch> <https://github.com/raspberrypi/linux/issues/3977> <http://www.dt8.jp/cgi-bin/adiary/adiary.cgi/0583>

1. (if you are using selinux, run this script to allow write access from docker) `sudo sh selinux.sh`
1. `sh download.sh`
1. `sh docker.sh`
1. (inside docker) `cd /rpizero-linux-build`
1. (inside docker) `sh clean.sh`
1. (inside docker) `sh build.sh`
1. (inside docker) `exit`
1. Create a file named `names.sh` and set the contents as follows.
   ```
   MYHOSTNAME=<hostname of rpi zero without .local>
   MYUSERNAME=<username of rpi zero>
   MY_KERNEL_SUFFIX=wakeup
   MY_KERNEL_NAME=kernel-$MY_KERNEL_SUFFIX
   ```
1. `sh pack.sh`
1. `sh packsend.sh`
1. ssh into the rpizero and edit `/boot/firmware/config.txt`. Add following lines to the boot configuration. Alternatively, you can edit the SD. The file is at `/config.txt` in the EFI partition. If anything wrong happens, please edit SD directly and delete these lines to reverse changes made.
   ```
   [all]
   dtoverlay=dwc2
   kernel=kernel-wakeup.img
   ```
1. ssh into the rpizero and reboot


## scripts and configs for rpi zero

- `raspi_scripts/`: scripts to be run inside raspberry pi
   - `etc/rc.local`: rc file to enable HID mouse and keyboard on startup
   - `home/someusername`: scripts to control USB device
      - `keyboard2.py`: control HID keyboard via command line  
         Example1 : `p CONTROL ALT DEL`  
         Example2 : `p ALT F4`  
         Example3 : `p DOWN_ARROW`  
         Example4 : `w sometext12345`
   - `root/`: scripts to enable HID/Ether feature on startup
      - `geth.sh`: Enable an old driver for ethernet over USB using RNDIS. On windows, you have to install a special driver to connect to the rpi zero. Go to <https://www.catalog.update.microsoft.com/Search.aspx?q=USB%20RNDIS%20Gadget>, and download the driver file named "Acer Incorporated. - Other hardware - USB Ethernet/RNDIS Gadget". On linux, it works without any configration.
      - `hid-and-eth.sh`: enable both HID and Ethernet-over-USB at the same time using a new driver. Unfortunately, there is no signed Windows driver for it.
      - `hid-double.sh`: enable both HID keyboard and Mouse.
      - `hid.sh`: enable only HID keyboard.
      - `remove.sh`: unloads all drivers so that you can use any of these scripts again. very unstable, so it is better to restart the rpi zero instead.

- `host_scripts/`: scripts to be run from the remote computer that will control raspberry pi
  - `qt.py`: Use PyQt5 to synchronize keyboard input and mouse movement
  - `mouse.py`: Use Xlib to synchronize mouse movement