#!/bin/sh

# macOS関係のファイルを削除
rm -r /boot/.fseventsd /boot/.Spotlight-V100

# IPアドレスの固定
mv /etc/dhcpcd.conf /etc/dhcpcd.conf.bak
cp ./files/dhcpcd.conf /etc/dhcpcd.conf

# syslogの外部受け入れを許可
mv /etc/rsyslog.conf /etc/rsyslog.conf.bak
cp ./files/rsyslog.conf /etc/rsyslog.conf

# logrotateの無効化
mv /etc/logrotate.conf /etc/logrotate.conf.bak
cp ./files/logrotate.conf /etc/logrotate.conf

# swapの無効化
apt -y purge dphys-swapfile

# aptのワンライナー（更新自動化、LAMPの下準備）
apt update && apt -y --no-install-recommends install unattended-upgrades nginx mariadb-server php-fpm php-curl php-mbstring php-mysql php-imagick php-xml php-zip ghostscript

# シャットダウン
shutdown -r now
