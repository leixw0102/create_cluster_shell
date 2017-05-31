#!/bin/sh

path="$(cd "`dirname "$0"`"/..; pwd)"
iplist=$path/conf/iplist

service postgresql start
systemctl enable postgresql.service
cat $iplist|while read myline
do
 echo "ip " $myline
 $path/install-dependence/ssh-noPwd-rm.sh $myline
 $path/before/push-noPwd.sh "$path/install-dependence/auto-generated/*" $myline /etc/yum.repos.d/
 $path/install-dependence/ssh-noPwd-yum.sh $myline 
done


