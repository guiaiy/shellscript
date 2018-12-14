#!/bin/bash
####脚本放在/usr/local/bin/下,方便调用
####首先判断缓存是否可以登陆，不能则删除相应的条目
[ ! -f /tmp/.godatabase ] && touch /tmp/.godatabase
for i in `cat /tmp/.godatabase`
do
hostname=`grep -m 1 $i /tmp/.godatabase | awk '{print $1}'`
	if [ "$1" == $hostname  ];then
	target=`grep -m 1 $hostname /tmp/.godatabase | awk '{print $2}'`
	fi
	if [ ! -z $target ];then
	result=`ssh -o StrictHostKeyChecking=no $target "hostname"`
	re=${result%%.*}
		case $re in
		$1) ssh -X -o StrictHostKeyChecking=no root@$target && exit;;
		#### 如果主机名和参数$1不一致，则删除条目
		*) sed -i "/$target/d" /tmp/.godatabase && target="" && break;;
		esac
	fi
done
#### 如果target为空值，则缓存没有，需要挂载虚拟机获取ip
if [ -z $target ];then
mountpoint="/media/virtimage"
[ ! -d $mountpoint ] && mkdir $mountpoint
	#如果有设备挂载到该挂载点,则先 umount 卸载
	if mount | grep -q "$mountpoint" ;then
	umount $mountpoint &> /dev/null
	fi
	#只读的方式,将虚拟机的磁盘文件挂载到特定的目录下,这里是/media/virtimage 目录
	guestmount -r -d $1 -i $mountpoint
	##获取虚拟机的网卡信息
	dev=$(ls /media/virtimage/etc/sysconfig/network-scripts/ifcfg-* |awk -F"[/-]" '{print $9}')
	for i in $dev
	do
	###排除回环网卡
	[[ $i =~ lo ]] && continue
	ip=`awk -F= '/IPADDR/{print $2}' /media/virtimage/etc/sysconfig/network-scripts/ifcfg-$i`
	ssh -o StrictHostKeyChecking=no $ip "pwd" &> /dev/null && break
	done
	#### 一次很难卸载干净，因此采用while监控，直到卸载为止
	while :
	do
		if mount | grep -q "$mountpoint" ;then
		umount $mountpoint &> /dev/null
		else
		break
		fi
	done
	#### 将主机名，ip信息加入缓存，删除缓存可能存在的空行
	[ "$ip" != ""  ] && echo "$1 $ip" >> /tmp/.godatabase
	sed -i "/^$/d" /tmp/.godatabase
	ssh -X -o StrictHostKeyChecking=no root@$ip

fi
