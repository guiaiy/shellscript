#!/bin/bash

	#	目录自行修改        #

###########################################################
YD=/usr/local/nginx/conf/
DD=root@192.168.2.200:$YD
###########################################################
inotifywait -rqq $YD &>/dev/null
if [ $? -ne 0 ];then
eth=`nmcli connection show |  head -2 |awk '$1~/eth/{print $1}'`
csip=`ifconfig $eth | head -2 | grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' | sed -n '1p'`
sip=${csip%.*}.254
mkdir /root/inotify/
cd /root/inotify
wget ftp://$sip/inotify-tools-3.13.tar.gz &>/dev/null
tar -xf inotify-tools-3.13.tar.gz
cd inotify-tools-3.13
./configure
make && make  install
fi
while `inotifywait -rqq $YD`
do
rsync -avz --delete $YD  $DD 
done
