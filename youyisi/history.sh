#!/bin/bash
history -c
rm -rf ~/.bash_history
echo '30 * * * * /usr/bin/sh /mnt/myscript/history.sh' > /var/spool/cron/root
