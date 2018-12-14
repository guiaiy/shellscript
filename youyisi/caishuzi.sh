#!/bin/bash
p1=$[RANDOM%9]
p2=$[RANDOM%9]
p3=$[RANDOM%9]
p4=$[RANDOM%9]
while [ $p1 == $p2 ]
do
p2=$[RANDOM%9]
done
while [ $p1 == $p3 ] || [ $p2 == $p3 ]
do
p3=$[RANDOM%9]
done
while [ $p4 == $p1 ] || [ $p4 == $p2 ] || [ $p4 == $p3 ]
do
p4=$[RANDOM%9]
done
a=0
c=0
while [ $a != 4 ]
do
echo '请输入0-9的四个数字'
read a1 a2 a3 a4
a=0
b=0
case $a1 in
$p1) let a++;;
$p2|$p3|$p4) let b++;;
esac
case $a2 in
$p2) let a++;;
$p1|$p3|$p4) let b++;;
esac
case $a3 in
$p3) let a++;;
$p2|$p1|$p4) let b++;;
esac
case $a4 in
$p4) let a++;;
$p2|$p3|$p1) let b++;;
esac
echo "$a1 $a2 $a3 $a4 ${a}A${b}B(A表示数字和位置都对，B表示有这个数字但是位置不对)"
let c++
done
echo "恭喜你，猜对了,你猜了$c次"
