#!/bin/bash
a1=0
while [ "$a1" != "" ]
do
read -p  '你输入的四个数字是' a1 a2 a3 a4
m1=0
while [ "$m1" != "" ]
do
echo '电脑猜的数字是'
read m1 m2 m3 m4
aa=0
bb=0
case $m1 in
$a1) let aa++;;
$a2|$a3|$a4) let bb++
esac
case $m2 in
$a2) let aa++;;
$a1|$a3|$a4) let bb++
esac
case $m3 in
$a3) let aa++;;
$a2|$a1|$a4) let bb++
esac
case $m4 in
$a4) let aa++;;
$a2|$a3|$a1) let bb++
esac
echo
echo "${aa}A${bb}B"
done
done
