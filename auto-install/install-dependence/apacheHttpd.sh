#!/bin/sh


service httpd start

rm -rf /etc/yum.repos.d/*

path="$(cd "`dirname "$0"`"/; pwd)"

echo "cp repo to /etc/yum.repo.d/"

rm -rf ${path}/auto-generated

mkdir ${path}/auto-generated/


cp -r ${path}/repo/* ${path}/auto-generated/

hostname=`hostname`
echo "hostname ==>"$hostname "   replace ipaddress to hostname"
echo "ServerName $hostname" >> /etc/httpd/conf/httpd.conf

service httpd restart
systemctl enable httpd.service



grep . ${path}/auto-generated/ -R | awk -F: '{print $1}' | sort | uniq |xargs  sed -i "s/ipaddress/$hostname/g" 

cp -r ${path}/auto-generated/* /etc/yum.repos.d/


echo "repo yum source to /var/www/html"

cp -r $path/rpmSource/* /var/www/html/

echo "install ..create local repo"

yum -y install createrepo


echo "create local yum repo"
createrepo /var/www/html/centos7
createrepo /var/www/html/HDP-RPM/2.3/HDP/centos7
createrepo /var/www/html/HDP-RPM/2.3/HDP-UTILS-1.1.0.20
createrepo /var/www/html/HDP-RPM/2.4/HDP/centos7
createrepo /var/www/html/HDP-RPM/2.4/HDP-UTILS-1.1.0.20
createrepo /var/www/html/Updates-ambari-2.2.2.0
createrepo /var/www/html/MySQL
createrepo /var/www/html/myself

