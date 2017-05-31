#!/usr/bin/expect -f
set password [lindex $argv 0]
set targetHost [lindex $argv 1]
set fromPath [lindex $argv 2]
set toPath [lindex $argv 3]

spawn scp -r $fromPath root@$targetHost:$toPath
set timeout 3
expect "root@$targetHost's password:"
set timeout 3
send "$password\r"
set timeout 3
send "exit\r"
expect eof
