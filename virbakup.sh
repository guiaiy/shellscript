#!/bin/bash
imgdir="/var/lib/libvirt/images"
while :
do
	virsh list | grep $1 &>/dev/null
	if [ $? -eq 0 ];then
		virsh destroy $1
	else
		break;
	fi
done
echo "是否清理旧快照y/n"
read y
case $y in
y)
	for i in $@
	do	
		N=`qemu-img snapshot -l $imgdir/${i}.qcow2 | awk 'NR>2{print $1}'`
		for i in $N
		do
			qemu-img snapshot -d $i $imgdir/${i}.qcow2
		done
		qemu-img snapshot -c booting $imgdir/${i}.qcow2
		echo "down"
	done;;
*)
	for i in $@
	do
		qemu-img snapshot -c booting $imgdir/${i}.qcow2
		echo "down"
	done
esac
