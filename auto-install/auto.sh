#!/bin/sh

if [ $# != 1 ] ; then
   echo "USAGE: $0 passwod"
exit 1;
fi 

password=$1

path="$(cd "`dirname "$0"`"; pwd)"

$path/before/auto-before.sh $password
$path/install-dependence/dependence.sh 
$path/ntp/ntpClientSetting.sh
