#!/bin/sh
ntpServerHost=$1
sed -i "/^server/d" /etc/ntp.conf
echo "server "$ntpServerHost >> /etc/ntp.conf
exit
