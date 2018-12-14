#!/bin/bash
echo '请输入精度'
read p
n=1
s=1
echo "进度"
for i in `seq $p`
do
	n=$[n+1]
	j=$[n**2]
	d=`echo "scale=$p;1/$j" | bc`
	s=`echo "scale=$p;$s+$d" | bc`
	f=`echo "scale=$p;$s*6" | bc`
	w=`echo "scale=2;$i/$p*100" | bc`
	echo -ne "$w \r"

done
awk "BEGIN {printf(\"%.50f\n\",sqrt($f))}"
