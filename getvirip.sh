#!/bin/bash
mountpoint="/media/virtimage"
[ ! -d $mountpoint ] && mkdir $mountpoint
#如果有设备挂载到该挂载点,则先 umount 卸载
if mount | grep -q "$mountpoint" ;then
umount $mountpoint &> /dev/null
fi
#只读的方式,将虚拟机的磁盘文件挂载到特定的目录下,这里是/media/virtimage 目录
guestmount -r -d $1 -i $mountpoint
dev=$(ls /media/virtimage/etc/sysconfig/network-scripts/ifcfg-* |awk -F"[/-]" '{print $9}')
for i in $dev
do
[[ $i =~ lo ]] || awk -F= '/IPADDR/{print $2}' /media/virtimage/etc/sysconfig/network-scripts/ifcfg-$i
done
