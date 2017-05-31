#!/bin/sh
fromPath=$1
targetHost=$2
toPath=$3

scp -r $fromPath root@$targetHost:$toPath
