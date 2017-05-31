#!/bin/sh
targetIp=`cat /auto-install/conf/currentip`
systemctl disable firewalld.service
systemctl stop firewalld.service
sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
setenforce 0
rpm -ivh /auto-install/install-dependence/rpmSource/centos7/Packages/apr-1.4.8-3.el7.x86_64.rpm
rpm -ivh /auto-install/install-dependence/rpmSource/centos7/Packages/apr-util-1.5.2-6.el7.x86_64.rpm
rpm -ivh /auto-install/install-dependence/rpmSource/centos7/Packages/httpd-tools-2.4.6-31.el7.centos.x86_64.rpm
rpm -ivh /auto-install/install-dependence/rpmSource/centos7/Packages/mailcap-2.1.41-2.el7.noarch.rpm
rpm -ivh /auto-install/install-dependence/rpmSource/centos7/Packages/httpd-2.4.6-31.el7.centos.x86_64.rpm
systemctl start httpd.service
systemctl enable httpd.service
#echo "Http Server Started"
cp -r /auto-install/install-dependence/rpmSource/centos7 /var/www/html/
rm -rf /etc/yum.repos.d/*.repo
touch /etc/yum.repos.d/development.repo
echo "[development]" >> /etc/yum.repos.d/development.repo
echo "name=development" >> /etc/yum.repos.d/development.repo
echo "baseurl=file:///var/www/html/centos7" >> /etc/yum.repos.d/development.repo
echo "enabled=1" >> /etc/yum.repos.d/development.repo
echo "gpgcheck=1" >> /etc/yum.repos.d/development.repo
echo "gpgkey=file:///var/www/html/centos7/RPM-GPG-KEY-CentOS-7" >> /etc/yum.repos.d/development.repo
yum clean all
yum makecache
yum install tftp-server -y
rm /etc/xinetd.d/tftp
cp tftp /etc/xinetd.d/tftp
systemctl start xinetd.service
systemctl enable xinetd.service
yum -y install syslinux
cp /usr/share/syslinux/pxelinux.0 /var/lib/tftpboot/
cp /var/www/html/centos7/images/pxeboot/initrd.img /var/lib/tftpboot/
cp /var/www/html/centos7/images/pxeboot/vmlinuz /var/lib/tftpboot/
cp /var/www/html/centos7/isolinux/*.msg /var/lib/tftpboot/
mkdir /var/lib/tftpboot/pxelinux.cfg
cp /var/www/html/centos7/isolinux/isolinux.cfg /var/lib/tftpboot/pxelinux.cfg/default
sed -i 's/vesamenu.c32/ks/g' /var/lib/tftpboot/pxelinux.cfg/default
sed -i '/^default/a\prompt 0' /var/lib/tftpboot/pxelinux.cfg/default
sed -i '/^timeout/c\timeout 6' /var/lib/tftpboot/pxelinux.cfg/default
echo "label ks" >> /var/lib/tftpboot/pxelinux.cfg/default
echo "  kernel vmlinuz" >> /var/lib/tftpboot/pxelinux.cfg/default
echo "  append ks=http://"$targetIp"/ks.cfg initrd=initrd.img quiet" >> /var/lib/tftpboot/pxelinux.cfg/default
rpm -ivh /var/www/html/centos7/Packages/dhcp-4.2.5-36.el7.centos.x86_64.rpm
cp dhcpd.conf /etc/dhcp/dhcpd.conf
systemctl start dhcpd.service
systemctl enable dhcpd.service
yum install system-config-kickstart -y
sed -i "s/centerip/$targetIp/g" ks.cfg
cp ks.cfg /var/www/html/
