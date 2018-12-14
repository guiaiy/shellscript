#!/bin/bash
rm -rf 1.txt 2.txt 3.txt 4.txt
echo "查找小于等于n的所有质数,请输入n:"
read z
date
for b in `seq 2 $z`
do
echo "$b" >> 1.txt
done
\cp -f 1.txt 3.txt
m=`tail -1 3.txt`
n=`sed -n "1p" 3.txt`
w=$[m/2]
e=$[w+1]
while [ $n -le $e ]
do
n=`sed -n "1p" 3.txt`
echo -n "$n  "
echo -n "$n  " >> 2.txt
sed -i "1d" 3.txt
for i in `cat 3.txt`
do
p=$[i%n]
if [ $p -eq 0 ];then
sed -i "0,/$i/s///" 3.txt
fi
done
sed -i "/^$/d" 3.txt
done
k=`cat 3.txt | wc -l`
for o in `seq $k`
do
  q=`sed -n "${o}p" 3.txt`
  echo -n "$q  " >> 4.txt
done
cat 4.txt
echo ""
date
rm -rf 1.txt 2.txt 3.txt 4.txt
