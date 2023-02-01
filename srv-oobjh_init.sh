#!/bin/sh

hostnamectl set-hostname oob-jh

apt update -y
apt-get install -y python3
curl -O https://bootstrap.pypa.io/get-pip.py
python3 get-pip.py --user
apt-get install -y haproxy
pip3 install requests

sed -i -e '/PasswordAuthentication/ s/no/yes/' /etc/ssh/sshd_config
systemctl restart sshd

useradd -m -p $(perl -e 'print crypt($ARGV[0], "password")' 'C1sco12345') -s "/bin/bash" cl_admin
