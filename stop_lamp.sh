#!/bin/bash
SERVICES="http https ftp"
for i in $SERVICES ; do echo "Disabling $i"; firewall-cmd --remove-service=$i --zone=public --perm ;done
firewall-cmd --reload
systemctl stop httpd.service mariadb.service vsftpd.service
systemctl status httpd.service mariadb.service vsftpd.service
