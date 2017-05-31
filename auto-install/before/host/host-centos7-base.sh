#!/usr/bin/expect -f
set ipaddress [lindex $argv 0]
set passwd [lindex $argv 1]
set domain [lindex $argv 2]
set timeout 3

#endSuffix=`echo $ipaddress| awk -F"." '{print $4}'`.ehl.com
#echo $endSuffix

spawn ssh root@$ipaddress
expect {
	"Connection refused" exit
	"Name or service not known" exit
	"No route to host" exit
	"yes/no" { send "yes\r";exp_continue }
	"password:" { send "$passwd\r";exp_continue }
	#登陆成功
	"Last login" 
	{
		#修改机器名
		#send "lastip=host`echo $ipaddress| awk -F"." '{print $4}'`.ehl.com\r"
                send "hostnamectl set-hostname $domain\r"

		#关闭防火墙
		send "systemctl stop firewalld.service\r"
		send "systemctl disable firewalld.service\r"
		send "setenforce 0\r"
		send "sed -i s/SELINUX=enforcing/SELINUX=disabled/g /etc/selinux/config\r"

		#修改系统最大打开文件数
		send "cat >>/etc/security/limits.conf<<EOF\r"
		send "* soft nofile 65535\r"
		send "* hard nofile 65535\r"
		send "EOF\r"
	}
}
expect eof
exit
