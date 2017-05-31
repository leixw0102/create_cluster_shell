#!/bin/sh

jdkPrefix=/app

if [ ! -d  "${jdkPrefix}" ]; then
  mkdir $jdkPrefix
fi

path=$(cd "`dirname "$0"`"/..; pwd)
jdkPath=$path"/jdk-1.7/jdk"
echo $jdkPath

cp -r $jdkPath $jdkPrefix

iplist=$path"/../conf/iplist"

cat $iplist|while read myline
do

  $path"/push-noPwd.sh" $jdkPrefix $myline "/"
  $path"/jdk-1.7/jdk.sh" $myline 
done
