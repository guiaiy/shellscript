#!/bin/bash
echo "请确保yum源与免密登陆都已经配置
本脚本不适用于交互式脚本的执行"

rm -rf /var/ftp/.scpcommandip /var/ftp/.scpcommandsh
echo '基本安装执行中。。。'
ls ./
echo '请输入需要安装的脚本,输入end退出'
while :
do
read sh
if [ "$sh" == "" ];then
continue
elif [ "$sh" == "end" ];then
break
elif [ ! -f ./$sh ];then
echo '脚本不存在'
else
echo $sh >> /var/ftp/.scpcommandsh
fi
done
echo '请输入服务器ip,输入end退出'
while :
do
read ip
if [ "$ip" == "" ];then
continue
elif [ "$ip" == "end" ];then
break
else
ping -c 2 -w 0.5 -i 0.1 $ip &> /dev/null
case $? in
0) echo $ip >> /var/ftp/.scpcommandip;;
*) echo '此ip无法连接';;
esac
fi
done
start_time=`date +%s`
for i in `cat /var/ftp/.scpcommandip`
do
for j in `cat /var/ftp/.scpcommandsh`
do
echo "$i
$j" > /var/ftp/.scpcommand
./.scpcommand.sh < /var/ftp/.scpcommand
done
done
wait
stop_time=`date +%s`
echo "TIME:`expr $stop_time - $start_time`"
