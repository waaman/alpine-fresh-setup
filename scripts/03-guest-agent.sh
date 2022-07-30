#!/bin/sh

echo "--------------------------------------------------------"
echo "scripts/03-guest-agent.sh"
echo "--------------------------------------------------------"


ROOT_DIR=$(dirname $(readlink -f $0))/..

echo "qemu-guest-agent ?"
echo "(o/N)"
read guest

if [ ! ${guest} = n ]
then
    apk add qemu-guest-agent
    rc-update add qemu-guest-agent default
    service qemu-guest-agent start

    # Shutdown - guest agent workaround
    cp $ROOT_DIR/maintenance/shutdown /sbin/
    chmod 0777 /sbin/shutdown
    chmod a+x /sbin/shutdown

fi