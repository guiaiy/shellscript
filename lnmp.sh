#!/bin/bash
url="https://github.com/guiaiy/linux"
prefix=/usr/local/nginx
####################判断ip##########################
eth=`nmcli connection show |  head -2 |awk '$1~/eth/{print $1}'`
csip=`ifconfig $eth | head -2 | grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' | sed -n '1p'`
sip=${csip%.*}.254

####################下载并安装所需资源##########################
mkdir /root/lnmp/
cd /root/lnmp/
wget ftp://$sip/lnmp_soft/nginx-1.12.2.tar.gz 
wget ftp://$sip/lnmp_soft/php-fpm-5.4.16-42.el7.x86_64.rpm 
wget ftp://$sip/lnmp_soft/php_scripts/mysql.php 
yum -y install mariadb-server mariadb-devel openssl-devel php php-mysql php-fpm-5.4.16-42.el7.x86_64.rpm gcc make
systemctl enable php-fpm
systemctl restart php-fpm
systemctl enable mariadb
systemctl restart mariadb
tar -xf nginx-1.12.2.tar.gz
cd nginx-1.12.2
./configure --prefix=$prefix --user=nginx --group=nginx --with-http_ssl_module --with-stream --with-http_stub_status_module
make && make install

#####################设置快捷方式#########################
ln -s $prefix/sbin/nginx /sbin/
ln -s $prefix /nginx

#####################创建用户，复制php脚本#########################
useradd -s /sbin/nologin nginx &> /dev/null
cp /root/lnmp/mysql.php $prefix/html/

##############################设置开启自启###################
echo "$prefix/sbin/nginx" >> /etc/rc.d/rc.local
chmod +x /etc/rc.d/rc.local

########################优化nginx#######################
#查看cpu核心数
cpus=`lscpu | sed -n '/^CPU(/p' | awk '{print $2}'`
#设置进程数
sed -i "/worker_processes/s/[0-9]\{1,\}/$cpus/" $prefix/conf/nginx.conf
#设置并发数
sed -i '/worker_connections/s/[0-9]\{1,\}/50000/' $prefix/conf/nginx.conf
#设置nofile
ulimit -Hn 100000
ulimit -Sn 100000
echo '*  soft  nofile  100000' >> /etc/security/limits.conf
echo '*  hard  nofile  100000' >> /etc/security/limits.conf
#设置status
sed -i '/^[ ]*server_name/a \ \tlocation \/info {\n\t\tstub_status on;\n\t}\n' $prefix/conf/nginx.conf
#设置包头大小
sed -i '/^[ ]*include[ ]*mime/a \ \tclient_header_buffer_size\t1k;\n\tlarge_client_header_buffers\t4 1k;\n' $prefix/conf/nginx.conf
#设置浏览器缓存文件
sed -i '/^[ ]*server_name/a \ \tlocation ~* \.(jpg|jpeg|gif|png|css|js|ico|xml)$ {\n\t\texpires 30d;\n\t}\n' $prefix/conf/nginx.conf
#设置页面压缩
sed -i '/^[ ]*include[ ]*mime/a \ \tgzip on;\n\tgzip_min_length 1000;\n\tgzip_comp_level 4;\n\tgzip_types text/plain text/css application/json application/x-javascript text/xml application/xml application/xml+rss text/javascript;\n' /$prefix/conf/nginx.conf
#设置服务器内存缓存
sed -i '/^[ ]*include[ ]*mime/a \ \topen_file_cache\t\t\tmax=2000 inactive=20s;\n\topen_file_cache_valid\t\t60s;\n\topen_file_cache_min_uses\t5;\n\topen_file_cache_errors\t\toff;\n' /$prefix/conf/nginx.conf

#启动nginx
$prefix/sbin/nginx
