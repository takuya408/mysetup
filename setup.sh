#!/bin/sh

# macOS関係のファイルを削除
rm -r /boot/.fseventsd /boot/.Spotlight-V100

# バックアップ用のディレクトリを作成
mkdir /home/pi/backup

# IPアドレスの固定
mv /etc/dhcpcd.conf /home/pi/backup
cp ./files/dhcpcd.conf /etc/dhcpcd.conf

# localhostの変更
mv /etc/hosts /home/pi/backup
cp ./files/hosts /etc/hosts

# syslogの外部受け入れを許可
mv /etc/rsyslog.conf /home/pi/backup
cp ./files/rsyslog.conf /etc/rsyslog.conf

# logrotateの無効化
mv /etc/logrotate.conf /home/pi/backup
cp ./files/logrotate.conf /etc/logrotate.conf

# swapの無効化
apt -y purge dphys-swapfile

# 必要なパッケージのインストール（LAMP環境、更新自動化）
apt update
apt -y --no-install-recommends install nginx-light libnginx-mod-http-geoip mariadb-server php-fpm php-curl php-mbstring php-mysql php-imagick php-xml php-zip ghostscript unattended-upgrades goaccess

# unattended-upgradesの設定
mv /etc/apt/apt.conf.d/50unattended-upgrades /home/pi/backup
cp ./files/50unattended-upgrades /etc/apt/apt.conf.d/50unattended-upgrades

# nginxの設定
cp ./files/kawagoe /etc/nginx/sites-available
rm /etc/nginx/sites-enabled/default
ln -s /etc/nginx/sites-available/kawagoe /etc/nginx/sites-enabled

# WordPressのダウンロード
wget -P /home/pi --no-use-server-timestamps https://ja.wordpress.org/latest-ja.tar.gz
tar xvzf /home/pi/latest-ja.tar.gz -C /var/www

# 所有権の変更
chown -cR pi:pi /home/pi
chown -cR www-data:www-data /var/www/wordpress
find /var/www/wordpress -type f -print | xargs chmod 604
find /var/www/wordpress -type d -print | xargs chmod 705
#chmod 400 /var/www/wordpress/wp-config.php

# シャットダウン
shutdown -r now
