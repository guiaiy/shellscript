#!/bin/bash
scp ./rhceserver.sh root@172.25.0.11:/root &>/dev/null
scp ./rhcedesktop.sh root@172.25.0.10:/root &>/dev/null
ssh root@172.25.0.11 "/root/rhceserver.sh ; exit"
ssh root@172.25.0.10 "/root/rhcedesktop.sh ; exit"
