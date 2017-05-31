#!/bin/sh
targetHost=$1
ssh -T root@$targetHost <<remoteSsh
rm -rf /etc/yum.repos.d/*
exit
remoteSsh
