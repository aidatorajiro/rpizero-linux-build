. ./names.sh

KERNEL_VERSION=6.6.30

scp install.tar.xz $MYUSERNAME@$MYHOSTNAME.local:/home/$MYUSERNAME
ssh $MYUSERNAME@$MYHOSTNAME.local 'cd /; sudo tar -xvf /home/$MYUSERNAME/install.tar.xz'
scp './config-pyzero' $MYUSERNAME@$MYHOSTNAME.local:
ssh $MYUSERNAME@$MYHOSTNAME.local "sudo cp /home/$MYUSERNAME/config-pyzero /boot/config-$KERNEL_VERSION"
ssh $MYUSERNAME@$MYHOSTNAME.local "mkinitramfs -o initramfs-6.6.30 6.6.30"
ssh $MYUSERNAME@$MYHOSTNAME.local "sudo cp initramfs-6.6.30 /boot/firmware/initramfs"