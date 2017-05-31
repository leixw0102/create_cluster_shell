#!/bin/sh
path="$(cd "`dirname "$0"`"/..; pwd)"

ntpServer=`cat $path/conf/ntpServer`
iplist=$path/conf/ntpClient

echo $ntpServer


cat $iplist|while read myline
do
 echo $myline "clinet"
 $path/ntp/ssh-noPwd-ntp.sh $myline $ntpServer
done
