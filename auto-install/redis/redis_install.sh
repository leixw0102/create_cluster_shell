#!/bin/sh
mkdir -p /app
cp redis-3.0.1.tar.gz /app/
yum install mpfr-3.1* -y
yum install libmpc-1.0* -y
yum install cpp-4.8.3* -y
yum install kernel-headers-3.10* -y
yum install glibc-headers-2.17* -y
yum install glibc-devel-2.17* -y
yum install gcc-4.8.3* -y
tar xvf redis-3.0.1.tar.gz
mv redis-3.0.1 redis
cd /app/redis
sed -i '/^daemonize/d' /app/redisredis.conf
echo 'daemonize yes' >> /app/redisredis.conf
cd /app/redis/src
./redis-server &