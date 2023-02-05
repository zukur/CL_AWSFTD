#!/bin/sh

hostnamectl set-hostname srv-a

apt update -y
apt-get install -y apache2
rm -rf /var/www/html/*
git clone https://github.com/zukur/CL_site /var/www/html
systemctl enable apache2
systemctl start apache2