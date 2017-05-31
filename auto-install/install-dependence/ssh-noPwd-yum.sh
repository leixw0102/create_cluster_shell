#!/bin/sh
targetHost=$1
ssh -T root@$targetHost <<remoteSsh
yum remove -y snappy-1.1.0-3.el7.x86_64
yum install -y snappy-1.0.5
yum install -y redhat-lsb
yum install -y deltarpm
yum install -y python-devel
yum -y install ntp
systemctl disable chronyd.service 
systemctl enable ntpd.service
exit
remoteSsh
