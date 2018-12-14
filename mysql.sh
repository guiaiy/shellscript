#!/bin/bash
rpm -q perl-JSON || yum -y install perl-JSON
eth=`nmcli connection show |  head -2 |awk '$1~/eth/{print $1}'`
csip=`ifconfig $eth | head -2 | grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' | sed -n '1p'`
sip=${csip%.*}.254
if systemctl status mysqld;then
sleep 1
else
wget -O /mnt/mysql-5.7.17.tar ftp://$sip/database/mysql-5.7.17.tar &> /dev/null
cd /mnt/
tar -xvf mysql-5.7.17.tar &> /dev/null
rpm -Uvh mysql-community-*.rpm
rm -rf mysql-community-*.rpm
systemctl restart mysqld
systemctl enable mysqld
fi
rpm -q expect || yum -y install expect
N=`grep "A temporary password" /var/log/mysqld.log | awk '{print $NF}'`
expect <<EOF
spawn mysql -hlocalhost -uroot -p
expect "password" {send "$N\r"}
expect ">" {send "set global validate_password_policy=0;\n"}
expect ">" {send "set global validate_password_length=6;\n"}
expect ">" {send "alter user root@localhost identified by '123456';\n"}
expect ">" {send "quit\n"}
EOF
grep "validate_password_policy=0" /etc/my.cnf || sed -i '/^\[mysqld\]/a validate_password_policy=0\nvalidate_password_length=6' /etc/my.cnf
systemctl  restart mysqld 
echo ""
