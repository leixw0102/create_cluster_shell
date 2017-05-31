#/bin/sh
ssh-keygen -q -t rsa -N "" -f /root/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub >>~/.ssh/authorized_keys
chmod 644 ~/.ssh/authorized_keys

