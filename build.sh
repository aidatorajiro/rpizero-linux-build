. ./names.sh

apt update && apt upgrade -y

export ARCH=arm
export CROSS_COMPILE=arm-linux-gnueabihf-
DEFCONFIG=bcmrpi_defconfig
DTS_SUBDIR=broadcom
IMAGE=zImage

mkdir build
cd linux
NUMJOBS=$(dc -e "$(nproc) 2/p")

make O=../build $DEFCONFIG
# cp ../config-pyzero ../build/.config
# scripts/config --file ../build/.config --set-val CONFIG_WERROR y
echo "
CONFIG_LOCALVERSION=\"-$MY_KERNEL_SUFFIX\"" >> ../build/.config
make O=../build -j$NUMJOBS $IMAGE modules dtbs
mkdir -p ../install/boot/firmware/overlays
make O=../build INSTALL_MOD_PATH=../install modules_install
cp ../build/arch/${ARCH}/boot/dts/${DTS_SUBDIR}/*.dtb ../install/boot/firmware/
cp ../build/arch/${ARCH}/boot/dts/overlays/*.dtb* ../install/boot/firmware/overlays
cp arch/${ARCH}/boot/dts/overlays/README ../install/boot/firmware/overlays/
cp ../build/arch/${ARCH}/boot/$IMAGE ../install/boot/firmware/$MY_KERNEL_NAME.img
