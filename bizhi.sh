#!/bin/bash
dir=/root/sd/picture/
num=`ls -1 $dir | wc -l`
file=".picturefile"
ls $dir > $file
getpic(){
picnum=$[RANDOM%num+1]
picname=`sed -n "${picnum}p" $file`
echo $picname
}
while :
do
num2=`ls $dir | wc -l`
if [ $num -ne $num2 ];then
/root/.myshellscript/bizhi.sh
exit
else
t=$[RANDOM%10+50]
\cp -f $dir/`getpic` /usr/share/backgrounds/day.jpg
sleep $t
fi
done
