#!/bin/bash
echo '请输入需要计算的精度，数字越大，精度越高'
read n
m=1
j=-1
s2=1
h=$[n/100]
for i in `seq $n`
do
m=$[m+1]
k=$[m*2-1]
p=$[j**i]
s=`echo "scale=$n;$p/$k" | bc`
s2=`echo "scale=$n;$s+$s2" | bc`
s3=`echo "scale=$h;$s2*4" | bc`
echo -ne "$s3 \r"
done
echo ""
