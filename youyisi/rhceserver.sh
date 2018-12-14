#!/bin/bash
echo 'denyusers *@*my133t.org *@172.34.0.*' >> /etc/ssh/sshd_config
sleep 1
echo 'ssh success'
echo 'alias qstat="/bin/ps -Ao pid,tt,user,fname,rsz"' >> /etc/bashrc
sleep 1
echo 'alias success'
firewall-cmd --set-default-zone=trusted &>/dev/null
firewall-cmd --permanent --zone=trusted --add-forward-port=port=5423:proto=tcp:toport=80 &>/dev/null
firewall-cmd --permanent --zone=block --add-source=172.34.0.0/24 &>/dev/null
output=`firewall-cmd --reload` &>/dev/null
echo 'firewall success'
nmcli connection add type team ifname team0 con-name team0 autoconnect yes config '{"runner": {"name": "activebackup"}}' &>/dev/null
nmcli connection add type team-slave ifname eth1 con-name team0-1 master team0 &>/dev/null
nmcli connection add type team-slave ifname eth2 con-name team0-2 master team0 &>/dev/null
nmcli connection modify team0 ipv4.method manual ipv4.addresses 172.16.3.20/24 connection.autoconnect yes &>/dev/null
nmcli connection up team0 &>/dev/null
nmcli connection up team0-1 &>/dev/null
nmcli connection up team0-2 &>/dev/null
echo 'team success'
sleep 1
nmcli connection modify 'System eth0' ipv6.method manual ipv6.addresses 2003:ac18::305/64 connection.autoconnect yes
sleep 1
nmcli connection up 'System eth0' &>/dev/null
echo 'ipv6 success'
hostnamectl set-hostname server0.example.com
echo 'postfix installing  please wait'
output= `lab smtp-nullclient setup` &>/dev/null
echo "relayhost= [smtp0.example.com]" >> /etc/postfix/main.cf
echo "myorigin = desktop0.example.com" >> /etc/postfix/main.cf
sed -i '/^inet_interfaces = localhost/d' /etc/postfix/main.cf
sed -i '/^mydestination =/d' /etc/postfix/main.cf
echo "mynetworks = 127.0.0.0/8 [::1]/128" >> /etc/postfix/main.cf
echo 'inet_interfaces = loopback-only' >> /etc/postfix/main.cf
echo 'mydestination =' >> /etc/postfix/main.cf
echo 'local_transport = error:local delivery disabled' >> /etc/postfix/main.cf
systemctl enable postfix &>/dev/null
systemctl restart postfix
sleep 1
echo 'postfix success'
echo 'samba installing please wait'
output=`yum -y install samba` &>/dev/null
systemctl enable smb &>/dev/null
sed -i 's/workgroup = MYGROUP/workgroup = STAFF/g' /etc/samba/smb.conf &>/dev/null
echo '[common]
path = /common
host allow = 172.25.0.0/24' >> /etc/samba/smb.conf
mkdir /common
useradd harry
sleep 1
#echo '正在将harry加入samba，请输入密码'
echo 'migwhisk
migwhisk' >> /root/harry.txt
pdbedit -a harry < /root/harry.txt &>/dev/null
#while [ $? -ne 0 ]
#do
#echo '请重新输入'
#pdbedit -a harry
#done
mkdir /devops
useradd kenji
useradd chihiro
setfacl -m u:chihiro:rwx /devops
output= `setsebool -P samba_export_all_rw on` &>/dev/null
echo '[devops]
path = /devops
host allow = 172.25.0.0/24
write list = chihiro' >> /etc/samba/smb.conf
#echo '正在将chihiro加入samba，请输入密码'
echo 'atenorth
atenorth' >/root/chihiro.txt
pdbedit -a chihiro < /root/chihiro.txt &>/dev/null
#while [ $? -ne 0 ]
#do
#echo '请重新输入'
#pdbedit -a chihiro
#done
#echo '正在将kenji加入samba，请输入密码'
pdbedit -a kenji < /root/chihiro.txt &>/dev/null
systemctl restart smb
#while [ $? -ne 0 ]
#do
#echo '请重新输入'
#pdbedit -a kenji
#done
echo 'samba success'
sleep 2
echo 'nfskrb5 installing please wait'
output= `lab nfskrb5 setup` &>/dev/null
mkdir /public
mkdir -p /protected/project
chown ldapuser0 /protected/project
wget -O /etc/krb5.keytab http://classroom.example.com/pub/keytabs/server0.keytab &>/dev/null
sleep 1
echo '/public 172.25.0.0/24(ro)
/protected 172.25.0.0/24(rw,sec=krb5p)' >> /etc/exports
systemctl restart nfs-secure-server
sleep 1
systemctl restart nfs-server
sleep 1
systemctl enable nfs-secure-server &>/dev/null
systemctl enable nfs-server &>/dev/null
echo 'nfs success'
sleep 2
echo 'http installing please wait'
output=`yum -y install httpd mod_ssl mod_wsgi` &>/dev/null
cd /var/www/html
wget -O index.html http://classroom.example.com/pub/materials/station.html &>/dev/null
cd /etc/pki/tls/certs
wget  http://classroom.example.com/pub/tls/certs/server0.crt &>/dev/null
wget  http://classroom.example.com/pub/example-ca.crt &>/dev/null
cd /etc/pki/tls/private
wget  http://classroom.example.com/pub/tls/private/server0.key &>/dev/null
sed -i 's/SSLCertificateFile \/etc\/pki\/tls\/certs\/localhost.crt/SSLCertificateFile \/etc\/pki\/tls\/certs\/server0.crt/g' /etc/httpd/conf.d/ssl.conf &>/dev/null
sed -i 's/SSLCertificateKeyFile \/etc\/pki\/tls\/private\/localhost.key/SSLCertificateKeyFile \/etc\/pki\/tls\/private\/server0.key/g' /etc/httpd/conf.d/ssl.conf  &>/dev/null
sed -i 's/#SSLCACertificateFile \/etc\/pki\/tls\/certs\/ca-bundle.crt/SSLCACertificateFile \/etc\/pki\/tls\/certs\/example-ca.crt/g' /etc/httpd/conf.d/ssl.conf  &>/dev/null
sed -i 's/#DocumentRoot "\/var\/www\/html"/DocumentRoot "\/var\/www\/html"/g' /etc/httpd/conf.d/ssl.conf  &>/dev/null
mkdir /var/www/virtual
cd /var/www/virtual
wget -O index.html http://classroom.example.com/pub/materials/www.html &> /dev/null
echo '<VirtualHost *:80>
ServerName server0.example.com
DocumentRoot /var/www/html
</VirtualHost>
<VirtualHost *:80>
ServerName www0.example.com
DocumentRoot /var/www/virtual
</VirtualHost>' >> /etc/httpd/conf.d/vir.conf
useradd fleyd
setfacl -m u:fleyd:rwx /var/www/virtual
mkdir /var/www/html/private
cd /var/www/html/private
wget -O index.html http://classroom.example.com/pub/materials/private.html &> /dev/null
echo '<Directory /var/www/html/private>
Require ip 172.25.0.11
</Directory>' >> /etc/httpd/conf.d/Dir.conf
mkdir /var/www/web
cd /var/www/web
wget  http://classroom.example.com/pub/materials/webinfo.wsgi &> /dev/null
echo 'Listen 8909
<VirtualHost *:8909>
ServerName webapp0.example.com
DocumentRoot /var/www/web
WsgiScriptAlias / /var/www/web/webinfo.wsgi
</VirtualHost>' >> /etc/httpd/conf.d/vir.conf
output= `semanage port -a -t http_port_t -p tcp 8909` &>/dev/null
systemctl enable httpd &> /dev/null
systemctl restart httpd
echo 'web success'
sleep 3
echo 'creating script please wait'
echo '#!/bin/bash
if [ "$1" == "redhat" ];then
echo "fedora"
elif [ "$1" == "fedora" ];then
echo "redhat"
else
echo "/root/foo.sh redhat|fedora" >&2
exit 1
fi' >> /root/foo.sh
sleep 1
echo '#!/bin/bash
if [ $# -eq 0 ];then
echo "Usage: /root/batchusers <userfile>"
exit 1
elif [ ! -f $1 ];then
echo "Input file not found"
exit 2
else
for i in `cat $1`
do
useradd -s /bin/false $i
done
fi' >>/root/batchusers
chmod +x /root/foo.sh
chmod +x /root/batchusers
echo 'script success'

echo 'iscsi installing please wait'
echo 'n
p
1

+3G
w' > /root/autopart.txt
fdisk /dev/vdb < /root/autopart.txt &> /dev/null
output= `yum -y install targetcli` &>/dev/null
systemctl enable target &> /dev/null
targetcli backstores/block create iscsi_store /dev/vdb1 &> /dev/null
targetcli iscsi/ create iqn.2016-02.com.example:server0 &> /dev/null
targetcli iscsi/iqn.2016-02.com.example:server0/tpg1/luns create /backstores/block/iscsi_store &> /dev/null
targetcli iscsi/iqn.2016-02.com.example:server0/tpg1/acls create iqn.2016-02.com.example:desktop0 &> /dev/null
targetcli iscsi/iqn.2016-02.com.example:server0/tpg1/portals create 172.25.0.11 &> /dev/null
targetcli saveconfig &> /dev/null
output=`systemctl restart target`
echo 'target success'
sleep 1
echo 'mariadb installing please wait'
output= `yum -y install mariadb-server` &>/dev/null
systemctl enable mariadb &> /dev/null
output= `systemctl restart mariadb` &>/dev/null
mysqladmin -uroot password "atenorth"
echo 'create database Contacts;' > /root/Contacts.sql
mysql -uroot -patenorth < /root/Contacts.sql
cd
wget http://classroom.example.com/pub/materials/users.sql &> /dev/null
sleep 1
mysql -uroot -patenorth Contacts < users.sql
echo 'grant select on Contacts.* to Raikon@localhost identified by "atenorth";' > /root/Raikon.sql
mysql -uroot -patenorth < Raikon.sql
echo 'delete from mysql.user where Password="";' > /root/nopass.sql
mysql -uroot -patenorth < nopass.sql
output=`systemctl restart mariadb`
echo 'mariadb success'
sleep 1
echo 'for i in {1..3}
do
systemctl restart iscsi
sleep 1
systemctl restart target
sleep 1
systemctl restart nfs-secure
sleep 1
systemctl restart nfs-secure-server
sleep 1
systemctl restart smb
done' > /etc/rc.d/sys.sh
chmod +x /etc/rc.d/sys.sh
echo 'sh /etc/rc.d/sys.sh' >> /etc/rc.d/rc.local
echo 'server success'
