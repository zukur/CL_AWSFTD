#!/bin/sh

hostnamectl set-hostname srv-a

apt update -y
apt-get install -y apache2
echo "This is my app" > /var/www/html/index.html
systemctl enable apache2
systemctl start apache2