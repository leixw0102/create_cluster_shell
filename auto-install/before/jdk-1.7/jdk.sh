#!/usr/bin/expect -f
set ipaddress [lindex $argv 0]
set timeout 5
spawn ssh root@$ipaddress
expect {
	"Connection refused" exit
	"Name or service not known" exit
	"No route to host" exit
	"Last login" 
	{
		send "cat >>/etc/profile<<EOF\r"
		send "export JAVA_HOME=/app/jdk\r"
		send "export JRE_HOME=/app/jdk/jre\r"
		send "export PATH=\\\$JAVA_HOME/bin:\\\$PATH\r"
		send "export CLASSPATH=.:\\\$JAVA_HOME/lib/dt.jar:\\\$JAVA_HOME/lib/tools.jar\r"
		send "EOF\r"
		send "source  /etc/profile\r"
                send "exit\r"
	}
}
expect eof
exit
