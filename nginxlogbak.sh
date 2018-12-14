#!/bin/bash
date=`date +%Y%m%d%H%M`
mv /user/local/nginx/logs/access.log /user/local/nginx/logs/access-${date}.log
kill -USR1 `cat /usr/local/nginx/logs/nginx.pid`
