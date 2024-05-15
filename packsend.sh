. ./names.sh

MY_KERNEL_VERSION=$(cat build/include/config/kernel.release)

echo "Unpacking kernel..."
scp install.tar.xz $MYUSERNAME@$MYHOSTNAME.local:/home/$MYUSERNAME
ssh $MYUSERNAME@$MYHOSTNAME.local "cd /; sudo tar -xvf /home/$MYUSERNAME/install.tar.xz"

echo "Copying kernel config..."
scp './build/.config' $MYUSERNAME@$MYHOSTNAME.local:kernel-config
ssh $MYUSERNAME@$MYHOSTNAME.local "sudo cp /home/$MYUSERNAME/kernel-config /boot/config-$MY_KERNEL_VERSION"

echo "Creating initramfs..."
ssh $MYUSERNAME@$MYHOSTNAME.local "/usr/sbin/mkinitramfs -o initramfs $MY_KERNEL_VERSION"
ssh $MYUSERNAME@$MYHOSTNAME.local "sudo cp initramfs /boot/firmware/initramfs-$MY_KERNEL_SUFFIX"

echo "Cleaning up..."
ssh $MYUSERNAME@$MYHOSTNAME.local "rm initramfs install.tar.xz kernel-config"