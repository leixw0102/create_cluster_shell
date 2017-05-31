#!/bin/sh

if [ $# != 1 ] ; then 
   echo "USAGE: $0 passwod" 
exit 1; 
fi 

path="$(cd "`dirname "$0"`"; pwd)"

rpm -ivh  --force --nodeps  $path"/rpm/expect-5.44.1.15-5.el6_4.x86_64.rpm" 
rpm -ivh  --force --nodeps  $path"/rpm/tcl-8.5.7-6.el6.x86_64.rpm"
password=$1
#path="$(cd "`dirname "$0"`"; pwd)"
echo 'beforing host install...'
$path"/host/host-auto.sh" $password

echo "host installed"


echo "beforing ssh install .."
$path"/ssh/ssh-copy.sh" $password

echo "ssh installed"

echo "jdk install ...."
$path"/jdk-1.7/jdk-install.sh"
