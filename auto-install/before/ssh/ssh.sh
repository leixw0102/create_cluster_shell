#!/usr/bin/expect -f
set ipaddress [lindex $argv 0]
set passwd [lindex $argv 1]

set timeout 3
spawn ssh root@$ipaddress
expect {
	"(yes/no)?" { send "yes\r";exp_continue }
	"password:" { send "$passwd\r";exp_continue }
	"Last login" 
	{
		send "ssh-keygen -t rsa\r"
		expect {
			"which to save the key" {send "\r";exp_continue }
			"Overwrite (y/n)?" {send "y\n";exp_continue }
			"Enter passphrase" {send "\r";exp_continue }
			"Enter same passphrase" {send "\r";exp_continue }
		         }
                 #send "exit\r"
                send "cat ~/.ssh/id_rsa.pub >>~/.ssh/authorized_keys\r"
	        send "chmod 644 ~/.ssh/authorized_keys\r"
                send "exit\r"
         }
}
expect eof
exit

