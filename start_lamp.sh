#!/bin/bash
SERVICES="http https ftp"
for i in $SERVICES ; do echo "Enabling $i"; firewall-cmd --add-service=$i --zone=public --perm ;done
firewall-cmd --reload
systemctl start httpd.service mariadb.service vsftpd.service
systemctl status httpd.service mariadb.service vsftpd.service
