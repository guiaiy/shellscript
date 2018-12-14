#!/bin/bash
url="https://github.com/guiaiy/linux"
prefix=/usr/local/tomcat
####################判断ip##########################
eth=`nmcli connection show |  head -2 |awk '$1~/eth/{print $1}'`
sip=`ifconfig $eth | head -2 | grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' | sed -n '1p'`
sip=${sip%.*}.254

####################下载并安装所需资源##########################
mkdir /root/tomcat/
cd /root/tomcat/
wget $url/tree/master/rpms/apache-tomcat-8.0.30.tar.gz
tar -xf apache-tomcat-8.0.30.tar.gz
mv /root/tomcat/apache-tomcat-8.0.30 $prefix

#####################设置快捷方式#########################
ln -s $prefix/bin/startup.sh /sbin/tomcatstart
ln -s $prefix/bin/shutdown.sh /sbin/tomcatstop
ln -s $prefix /tomcat

######################设置开启自启###################
grep '/bin/startup.sh' /etc/rc.d/rc.local
if [ $? -ne 0 ];then
	echo "$prefix/bin/startup.sh" >> /etc/rc.d/rc.local
fi
chmod +x /etc/rc.d/rc.local
$prefix/bin/startup.sh


