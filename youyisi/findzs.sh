#!/bin/bash
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
index=0
for i in `seq $[p+1] $z`
do
shuzu[$index]=$i
let index++
done

#2.txt里面的每一个数字除以每一个小于他的质数，如果都不能被除尽，则为新的质数，存入质数表
indexx=0
for j in `seq 0 $[index-1]`
do
m=1
	for k in `cat /mnt/质数表.txt`
	do
	shizi=${shuzu["$indexx"]}
	echo $shuzi
	sleep 1
	if [ $[shuzi%k] -eq 0 ];then
	m=0
	break
	fi
	done
if [ $m -eq 1 ];then
echo -n "${shuzu[$indexx]}  "
echo -n "${shuzu[$indexx]}  " >> /mnt/质数表.txt
fi
let index++
done
fi
echo
date
