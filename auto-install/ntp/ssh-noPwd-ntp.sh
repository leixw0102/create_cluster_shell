#!/bin/sh
targetHost=$1

ntpServerHost=$2

ssh -T root@$targetHost <<remoteSsh

sed -i "/^server/d" /etc/ntp.conf
echo "server "$ntpServerHost >> /etc/ntp.conf
service ntpd stop
ntpdate $ntpServerHost
service ntpd start
exit
remoteSsh
