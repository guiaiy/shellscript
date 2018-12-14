#!/bin/bash
rpm -q gcc || yum -y install gcc
eth=`nmcli connection show |  head -2 |awk '$1~/eth/{print $1}'`
csip=`ifconfig $eth | head -2 | grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' | sed -n '1p'`
sip=${csip%.*}.254
pip=${csip##*.}
wget  ftp://$sip/database/redis-4.0.8.tar.gz
tar -xf redis-4.0.8.tar.gz &> /dev/null
cd redis-4.0.8/
make && make install
rpm -q expect || yum -y install expect
cd /root/redis-4.0.8/utils/
expect <<EOF
spawn ./install_server.sh
expect "]" {send "63${pip}\n"}
expect "]" {send "\n"}
expect "]" {send "\n"}
expect "]" {send "\n"}
expect "]" {send "\n"}
expect "." {send "\n"}
expect "]" {send "\n"}
EOF
sed -i "/^bind/c bind $csip 127.0.0.1" /etc/redis/63${pip}.conf
#sed -i "/^#[ ]requirepass/c requirepass 123456" /etc/redis/63${pip}.conf
ln -s /etc/init.d/redis_63${pip}  /sbin/
