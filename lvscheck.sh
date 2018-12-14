#!/bin/bash
vip=192.168.4.15
web1=192.168.4.100
web2=192.168.4.200
while :
do
for i in $web1 $web2
do
curl -s http://$i 
if [ $? -ne 0 ];then
ipvsadm -Ln | grep -q $i && ipvsadm -d -t $vip:80 -r $i
else
ipvsadm -Ln | grep -q $i || ipvsadm  -a -t $vip:80  -g
fi
done
sleep 5
done
