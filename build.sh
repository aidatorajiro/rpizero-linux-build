apt update && apt upgrade -y
DEFCONFIG=bcm2835_defconfig
export ARCH=arm
mkdir build
export CROSS_COMPILE=arm-linux-gnueabihf-
export DTS_SUBDIR=broadcom
export IMAGE=zImage
MATRIX_KERNEL=kernel
cd linux
# make O=../build $DEFCONFIG
cp ../config-pyzero ../build/.config
scripts/config --file ../build/.config --set-val CONFIG_WERROR y
make O=../build -j10 $IMAGE modules dtbs
mkdir -p ../install/boot/firmware/overlays
make O=../build INSTALL_MOD_PATH=../install modules_install
cp ../build/arch/${ARCH}/boot/dts/${DTS_SUBDIR}/*.dtb ../install/boot/firmware/
cp ../build/arch/${ARCH}/boot/dts/overlays/*.dtb* ../install/boot/firmware/overlays
cp arch/${ARCH}/boot/dts/overlays/README ../install/boot/firmware/overlays/
cp ../build/arch/${ARCH}/boot/$IMAGE ../install/boot/firmware/$MATRIX_KERNEL.img
