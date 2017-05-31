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
		send "mkdir ~/.ssh\r"
		send "touch ~/.ssh/authorized_keys\r"
		send "cat /root/id_rsa.pub >> ~/.ssh/authorized_keys\r"
		send "cat /root/id_rsa.pub >> ~/.ssh/authorized_keys\r"
                send "exit\r"
	
}
}
expect eof
exit

