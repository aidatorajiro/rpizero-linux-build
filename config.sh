. ./names.sh
ssh $MYUSERNAME@$MYHOSTNAME.local 'sudo modprobe configs'
ssh $MYUSERNAME@$MYHOSTNAME.local 'zcat /proc/config.gz > config-pyzero'
scp $MYUSERNAME@$MYHOSTNAME.local:config ./config-pyzero

