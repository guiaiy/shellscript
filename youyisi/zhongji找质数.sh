#!/bin/bash
rm -rf 2.txt
echo "查找小于等于n的所有质数,请输入大于2的正数(默认为10):"
read ze
[ "$ze" != "" ] && z=`echo "$ze/1" |bc` || z=10
while :
do
[ $z -ge 2 ] && break || read -p '请输入大于等于2的数(默认为10):  ' ze
[ "$ze" != "" ] && z=`echo "$ze/1" |bc` || z=10
done
date

#判断质数表是否存在，不存在则创建并存入第一个质数2
if [ ! -f /mnt/质数表.txt ];then
echo -n "2  " >> /mnt/质数表.txt
fi

p=`awk '{print $NF}' /mnt/质数表.txt` #读取质数表最后一个字符
start_time=`date +%s`
#如果输入的数字小于质数表，则直接从表中提取
if [ $p -ge $z ];then
	for h in `cat /mnt/质数表.txt`
	do
	if [ $h -gt $z ];then
	break
	else
	echo -n "$h  "
	fi
	done
	echo
else

#如果输入的数字大于质数表，则线提取质数表所有数字，然后接着计算，并更新之质数表
cat /mnt/质数表.txt
#将比质数表大的数字i全部存入2.txt
for i in `seq $[p+1] $z`
do
num[i]=$i
done

#2.txt里面的每一个数字除以每一个小于他的质数，如果都不能被除尽，则为新的质数，存入质数表
for j in ${num[@]}
do
m=1
	for k in `cat /mnt/质数表.txt`
	do
	if [ $[j%k] -eq 0 ];then
	m=0
	break
	fi
	done
if [ $m -eq 1 ];then
echo -n "$j  "
echo -n "$j  " >> /mnt/质数表.txt
fi
done
fi
echo
date
rm -rf 2.txt
stop_time=`date +%s`
echo "TIME:`expr $stop_time - $start_time`"
