#!/bin/sh

if [ $# != 1 ] ; then
   echo "USAGE: $0 passwod"
exit 1;
fi 

path="$(cd "`dirname "$0"`"/..; pwd)"
iplist=$path"/../conf/iplist"
currentip=`cat $path"/../conf/currentip"`
password=$1


  expect ${path}/ssh/ssh.sh $currentip $password


cat $iplist|while read myline
do
  domain="host"`echo $myline| awk -F"." '{print $4}'`".ehl.com"
  echo "ip="$myline"  \t domain "$domain
  expect ${path}/push-pwd.sh $password $myline /root/.ssh/id_rsa.pub /root/
  expect ${path}/ssh/ssh-append.sh $domain $password
 # expect  
done
