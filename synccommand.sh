#!/bin/bash
bingfa=$2
start_time=`date +%s`
n=0
dir="/var/ftp/linux/myshellscript"
superread (){
read -t 20 addr script
scr=${script:-$scr}
[ "$addr" == "" ] && break
[ $addr == "end" ] && break
sc[$1]=$scr
ad[$1]=$addr
}
echo "环境准备中请稍后。。。"
sleep 2
rpm -q pssh  || yum -y install pssh
echo "请输入需要执行脚本的主机ip，脚本路径，以空格隔开"
echo "若多台机器执行一个脚本，脚本路径只需输入第一次"
echo "再次回车，或者输入end结束输入"
i=0
case $# in
0)
	while :
	do
		superread $i
		let i++
	done;;
*)	
        echo "$1 的内容为"
        cat $1
        read -t 10 -p '你确定吗？(y/n)' confirm
        [ "$confirm" != "y" ] && echo "已退出" && exit
	while :
	do
		superread $i
		let i++
	done < $1
esac
rm -rf $dir/host.txt
echo `awk '{print $1}' $1` >> $dir/host.txt
sed -i "/[ ]/s/[ ]/\n/g" $dir/host.txt
num=${#sc[@]}
for i in `seq 0 $[num-1]`
do
	ii=${sc[i]}
	if [ $i -eq 0 ];then
		pscp.pssh -h $dir/host.txt -O "StrictHostKeyChecking=no" $ii /tmp/
		pssh -h $dir/host.txt -t 1000 -p $bingfa -P /tmp/${ii##*/}
		continue
	fi
	for j in `seq 0 $[i-1]`
	do
		[ ${sc[i]} == ${sc[j]} ] && let n++
	done
	if [ $n -eq 0 ];then
		pscp.pssh -h $dir/host.txt -O "StrictHostKeyChecking=no" $ii /tmp/
		pssh -h $dir/host.txt -t 1000 -p $bingfa -P /tmp/${ii##*/}
	fi
done
wait
stop_time=`date +%s`
echo "TIME:`expr $stop_time - $start_time`"
