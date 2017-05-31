#!/bin/bash
if [ $# != 1 ] ; then
   echo "USAGE: $0 passwod"
exit 1;
fi 
path="$(cd "`dirname "$0"`"/..; pwd)"
iplist=$path"/../conf/iplist"
password=$1
rm -rf ${path}/host/hosts

cat $path/host/hostsbase >> ${path}/host/hosts

cat $iplist|while read myline
do
 host=host$(echo $myline|awk -F. '{print $4}')".ehl.com"
 currIp=$myline
 echo "$currIp  $host" >> ${path}/host/hosts
 #domain="host"`echo $currIp| awk -F"." '{print $4}'`".ehl.com"
 #echo $domain
done

currentip=$path"/../conf/currentip"
cat $currentip|while read myline
do
 host="center.ehl.com"
 currIp=$myline
 echo "$currIp  $host" >> ${path}/host/hosts
done


cat $iplist|while read myline
do
  domain="host"`echo $myline| awk -F"." '{print $4}'`".ehl.com"
  echo "ip="$myline"  \t domain "$domain
  expect ${path}/host/host-centos7-base.sh $myline $password $domain
  expect ${path}/push-pwd.sh $password $myline ${path}/host/hosts /etc/
done
