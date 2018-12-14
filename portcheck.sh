#!/bin/bash
while :
do
ss -nutlp | grep 8066 &> /dev/null
if [ $? -ne 0 ];then
	systemctl status keepalived &> /dev/null && systemctl stop keepalived
	continue
else
	systemctl status keepalived &> /dev/null || systemctl start keepalived
	continue
fi
sleep 1
done 
