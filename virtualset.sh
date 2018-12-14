###读取数据
rpm -q libguestfs-tools-c &> /dev/null || yum -y install libguestfs-tools-c
i=0
xmldir="/etc/libvirt/qemu"
imgdir="/var/lib/libvirt/images"
mountpoint="/media/virtimage"
echo "请在一行输入一个虚拟机名称,IP地址,网卡名称,以空格隔开
也可以事先输入文件，以文件作为参数执行
如果网卡名称和上一行一致,可以不输入网卡名
输入end或两次回车结束输入" 

###定义一个函数,将数据存入数组
superread (){
read -t 20 name addr devname
dev=${devname:-$dev}
[ "$name" == "" ] && break
[ $name == "end" ] && break
if virsh domstate $name |grep -q running ;then
echo "修改虚拟机网卡数据,需要关闭虚拟机"
echo "虚拟机已经关闭，请继续输入"
virsh destroy $name
fi
[ ! -d $mountpoint$1 ]&& mkdir $mountpoint$1
if mount | grep -q "$mountpoint$1" ;then
umount $mountpoint$1 &>/dev/null
fi
na[$1]=$name
de[$1]=$dev
ad[$1]=$addr
}

###定义设置函数
virset (){
echo '正在更改"'${na[$1]}'"的配置，请稍后'
guestmount -d ${na[$1]} -i $mountpoint$1
wait
sleep 1
mip=${ad[$1]%.*}
nip=${mip##*.}
sip=${ad[$1]%.*}.254
[ -d $mountpoint$1 ] && rm -rf $mountpoint$1/etc/sysconfig/network-scripts/ifcfg-${de[$1]}
echo "BROWSER_ONLY=no
BOOTPROTO=static
DEFROUTE=yes
IPV4_FAILURE_FATAL=no
IPV6INIT=yes
IPV6_AUTOCONF=yes
IPV6_DEFROUTE=yes
IPV6_FAILURE_FATAL=no
IPV6_ADDR_GEN_MODE=stable-privacy
NAME=${de[$1]}
DEVICE=${de[$1]}
IPADDR=${ad[$1]}
ONBOOT=yes
PREFIX=24" >> $mountpoint$1/etc/sysconfig/network-scripts/ifcfg-${de[$1]}
[ -d $mountpoint$1 ] && rm -rf $mountpoint$1/etc/sysconfig/network-scripts/ifcfg-eth4
echo "BROWSER_ONLY=no
BOOTPROTO=dhcp
DEFROUTE=yes
IPV4_FAILURE_FATAL=no
IPV6INIT=yes
IPV6_AUTOCONF=yes
IPV6_DEFROUTE=yes
IPV6_FAILURE_FATAL=no
IPV6_ADDR_GEN_MODE=stable-privacy
NAME=eth4
DEVICE=eth4
ONBOOT=yes
PREFIX=24" >> $mountpoint$1/etc/sysconfig/network-scripts/ifcfg-eth4
[ -d $mountpoint$1 ] && rm -rf $mountpoint$1/etc/hostname
echo "${na[$1]}" >> $mountpoint$1/etc/hostname 
[ $nip -eq 122 ] || echo "[rhel7]
name=rhel7
baseurl=ftp://$sip/rhel7
enabled=1
gpgcheck=0" > $mountpoint$1/etc/yum.repos.d/rhel7.repo
mkdir $mountpoint$1/root/.ssh/ &> /dev/null
\cp -rf /var/ftp/authorized_keys $mountpoint$1/root/.ssh/authorized_keys
[ -d $mountpoint$1 ] && rm -rf $mountpoint$1/etc/resolv.conf
echo "nameserver 222.246.129.80" >> $mountpoint$1/etc/resolv.conf
echo "${na[$1]} 完成"
while :
do
	if mount | grep -q "$mountpoint$1" ;then
		umount $mountpoint$1 &> /dev/null
	else
		break
	fi
done
wait
}


###将所有数据存入数组
if [ $# -eq 0 ];then
	while :
	do
		superread $i
		let i++
	done
else
	echo "$1 的内容为"
	cat $1
	read -t 10 -p '你确定吗？(y/n)' confirm
	[ "$confirm" != "y" ] && echo "已退出" && exit
	while :
	do
		superread $i
		let i++
	done < $1
fi

###取出数组内的数据完成配置
[ -e /tmp/fd1 ] || mkfifo /tmp/fd1
exec 3<>/tmp/fd1
rm -rf /tmp/fd1
for p in `seq 3`
do
	echo >&3
done
for j in `seq 0 $[i-1]`
do
	read -u3
{	virset $j
	wait
	echo >&3
}&
done
wait
exec 3<&-
exec 3>&- 
echo '所有设置完成'
