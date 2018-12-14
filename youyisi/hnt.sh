#!/bin/bash
a=A
b=B
c=C
gogogo (){
if [ $4 -eq 1 ];then
echo "$1 --> $3"
else
gogogo $1 $3 $2 $(($4-1)) 
echo "$1 --> $3"
gogogo $2 $1 $3 $(($4-1))
fi
}
echo "请输入汉诺塔层数"
read n
gogogo  $a $b $c $n
