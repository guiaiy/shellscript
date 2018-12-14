#!/bin/bash
##判断ip
eth=`nmcli connection show |  head -2 |awk '$1~/eth/{print $1}'`
csip=`ifconfig $eth | head -2 | grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' | sed -n '1p'`
sip=${csip%.*}.254
##判断yum
yum clean all &> /dev/null
for	syum in MON OSD Tools
do
echo "[$syum]
name=$syum
baseurl=ftp://$sip/ceph/rhceph-2.0-rhel-7-x86_64/$syum
enabled=1
gpgcheck=0" >> /etc/yum.repos.d/$syum.repo
done
yum clean all &> /dev/null
yum repolist 2> /dev/null | tail -1
wget -O /root/.scpcommandip ftp://$sip/.scpcommandip
##hosts和时间服务
sed -i "2a server $sip iburst" /etc/chrony.conf
systemctl restart chronyd
systemctl enable chronyd
##装包
ip=`tail -1 /root/.scpcommandip`
##分区
useradd ceph
echo "n


10G

n




w
y

" >> .part.conf
gdisk /dev/vdb < .part.conf
sleep 5
chown ceph:ceph  /dev/vdb1
chown ceph:ceph  /dev/vdb2
if [ "$ip" == $csip ];then
rpm -q expect || yum -y install expect.x86_64
yum -y install ceph-deploy.noarch
mkdir /root/ceph-cluster/
cd /root/ceph-cluster/
##免密
[ ! -f /root/.ssh/id_rsa ] && ssh-keygen -f /root/.ssh/id_rsa -N ""
for i in `cat /root/.scpcommandip`
do
ssh $i "pwd" &>/dev/null
if [ $? -ne 0 ];then
expect <<EOF
spawn ssh-copy-id -o StrictHostKeyChecking=no $i
expect "password" {send "123456\n"}
expect "#" {send "exit\n"}
EOF
fi
done
for i in `cat /root/.scpcommandip`
do
sleep 5
ssh $i "/usr/bin/cat /etc/hostname" > /root/.scphn
p=`awk -F. '{print $1}' /root/.scphn`
rm -rf .scphn
echo "$i $p" >> /etc/hosts
echo -n "$p " >> /root/.scpcommandhn 
done

expect <<EOF
spawn ceph-deploy new `cat /root/.scpcommandhn`
expect "continue connecting" {send "yes\r"}
expect "continue connecting" {send "yes\r"}
expect "#" {send "\r"}
EOF
ceph-deploy install `cat /root/.scpcommandhn`
for i in `cat /root/.scpcommandip`
do
scp  /etc/hosts $i:/etc/hosts
done
pssh -h .scpcommandip "systemctl restart chronyd"
ceph-deploy mon create-initial
for j in `cat /root/.scpcommandhn`
do
ceph-deploy disk  zap  $j:vdc   $j:vdd 
done
for i in `cat /root/.scpcommandhn`
do
ceph-deploy osd create $i:vdc:/dev/vdb1 $i:vdd:/dev/vdb2 
done
echo ""
echo ""
echo ""
ceph -s
fi
