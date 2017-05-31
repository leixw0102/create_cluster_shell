#!/bin/sh
rpm -ivh --nodeps --force erlang-17.4-1.el6.x86_64.rpm
rpm -ivh --nodeps --force rabbitmq-server-3.5.0-1.noarch.rpm
service rabbitmq-server start
rabbitmq-plugins enable rabbitmq_management
rabbitmqctl add_user admin admin
rabbitmqctl set_user_tags admin administrator
rabbitmqctl set_permissions -p / admin ".*" ".*" ".*"