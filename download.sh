git clone --depth=1 https://github.com/raspberrypi/linux
cd linux
patch -p1 < ../wakeup.patch
