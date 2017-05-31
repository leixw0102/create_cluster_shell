#!/bin/sh

yum install ntp -y
sed -i "/^server/d" /etc/ntp.conf
sed -i "/^OPTIONS/d" /etc/sysconfig/ntpd
sed -i "/^restrict/d" /etc/ntp.conf
echo "restrict default kod nomodify nopeer noquery" >> /etc/ntp.conf
echo "restrict -6 default kod nomodify nopeer noquery" >> /etc/ntp.conf
echo "server	127.127.1.0" >> /etc/ntp.conf
echo "fudge	127.127.1.0 stratum 10" >> /etc/ntp.conf
echo "OPTIONS=\"-x -u ntp:ntp -p /var/run/ntpd.pid -g\"" >> /etc/sysconfig/ntpd
systemctl disable chronyd.service 
systemctl enable ntpd.service 
systemctl start  ntpd.service
exit
