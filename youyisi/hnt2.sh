#!/bin/bash
a=A
b=B
c=C
d=D
gogogo (){
if [ $5 -eq 2 ];then
echo "$1 --> $3"
echo "$1 --> $4"
echo "$3 --> $4"
elif [ $5 -eq 1 ];then
echo "$1 --> $4"
else
gogogo $1 $3 $4 $2 $(($5-2)) 
echo "$1 --> $3"
echo "$1 --> $4"
echo "$3 --> $4"
gogogo $2 $1 $3 $4 $(($5-2))
fi
}
echo "请输入四柱汉诺塔层数"
read n
gogogo  $a $b $c $d $n
