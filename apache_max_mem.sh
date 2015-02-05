#!/bin/bash
# Script to check php setting against apache max clients and calculate total possible usage
resize;clear;echo -en "Apache processes:\t"; AP=`pgrep httpd| wc -l`;\
echo $AP; echo -en "MaxClients Setting:\t";MC=`grep -E '^\s*MaxCl' /etc/httpd/conf/httpd.conf|\
head -n1|awk '{print $2}'`; echo $MC; echo -en "Average child size:\t";ACP=`ps -Ao \
user,size,cmd| grep -E "\/httpd$" | grep -vE "^root"|awk '{c+=$2; c2+=1} \
END{print ceiling((c/c2)/1024)} function ceiling(x){return (x == int(x)) ? x : \
int(x)+1}'`; echo "$ACP Mb"; echo -en "Current Mem Usage:\t"`expr $AP \* $ACP`" \
Mb\n"; PM=`free -m|grep "Mem:"|awk '{print $2}'`;echo -en "Total Phys \
Memory:\t$PM Mb\n"; echo -en "Total Poss Usage:\t"`expr $MC \* $ACP`" Mb\n"; \
PHPMEM=`grep ^memory_limit /etc/php.ini | sed -r \
's/^\w*\s*=\s*(\w*)\s*.*/\1/' | sed 's/[Mm]//'`;  echo -en "PHP Memory_Limit:\t$PHPMEM Mb\n"; \
echo -en "PHP Max Poss Usage:\t"`expr $MC \* $PHPMEM`" Mb\n"; \
echo -en "Can Serve Clients:\t"`expr "$PM" / "$ACP"`"\n";
