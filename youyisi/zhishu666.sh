#!/bin/bash
read -p '输入一个大于等于2数:  ' ne
n=`echo "$ne/1" |bc`
while :
do
[ $n -ge 2 ] && break || read -p '请输入大于等于2的数:  ' ne
n=`echo "$ne/1" |bc`
done 
for i in `seq 2 $n`
do
k=0
	for j in `seq $i`
	do
	if [ $[i%j] -eq 0 ];then
	let k++
	fi
	done
if [ $k -eq 2 ];then
echo -n "$i  "
fi
done
echo
