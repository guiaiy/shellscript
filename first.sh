#!/bin/bash
#####################判断主机名############################
echo "需要更改的主机名： "
read shost
wait
####################设置主机名########################
shost=${shost:-localhost}
hostname $shost.tedu.cn
echo "$shost.tedu.cn" > /etc/hostname

####################判断ip##########################
eth=`nmcli connection show |  head -2 |awk '$1~/eth/{print $1}'`
sip=`ifconfig $eth | head -2 | grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' | sed -n '1p'`
sip=${sip%.*}.254

#####################判断yum######################
yum clean all &> /dev/null
list=`yum repolist 2> /dev/null | tail -1 | awk '{print $2}' | sed 's/,//'`
if [ $list -le 0 ];then
	echo "yum源不可用，正在设置新的yum源"
	redhat=`cat /etc/redhat-release | awk '{print $7}'`
	case $redhat in
		7.*)	syum=rhel7;;
		6.*)	syum=rhel6;;
		*)	syum=centos7;;
	esac
	rm -rf /etc/yum.repos.d/*
	echo "[$syum]" > /etc/yum.repos.d/$syum.repo
	echo "name=$syum" >> /etc/yum.repos.d/$syum.repo
	echo "baseurl=ftp://$sip/$syum" >> /etc/yum.repos.d/$syum.repo
	echo "enabled=1" >> /etc/yum.repos.d/$syum.repo
	echo "gpgcheck=0" >> /etc/yum.repos.d/$syum.repo
fi
yum clean all &> /dev/null
yum repolist 2> /dev/null | tail -1

###################设置无密码登陆#########################
mkdir /root/.ssh/  &> /dev/null
wget -O /root/.ssh/authorized_keys ftp://$sip/authorized_keys &> /dev/null
[ $? -eq 0 ] && echo 下载成功 || echo 下载失败

echo "set nu" >> /etc/vimrc
