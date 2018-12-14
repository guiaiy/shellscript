#!/bin/bash
echo '请输入精度'
read p
m=0
s=1
o=1
echo '进度'
for i in `seq $p`
do
	m=$[m+1]
	s=$[s*m]
	k=`echo "scale=$s;1/$s" | bc`
	o=`echo "scale=$s;$o+$k" | bc`
	w=`echo "scale=2;$i/$p" | bc`
	echo -ne "$w \r"
done
l=`echo "scale=100;$o/2*2" | bc`
echo "$l"
