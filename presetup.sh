#!/bin/sh

# タイムゾーンの設定
raspi-config

# macOS関係のファイルを削除
rm -r /boot/.Spotlight-V100

# IPアドレスの固定
mv /etc/dhcpcd.conf /etc/dhcpcd.conf.bak
cp /（指定）/dhcpcd.conf /etc/dhcpcd.conf

# syslogの外部受け入れを許可
mv /etc/rsyslog.conf /etc/rsyslog.conf.bak
cp /（指定）/rsyslog.conf /etc/rsyslog.conf

# logrotateの無効化
mv /etc/logrotate.conf /etc/logrotate.conf.bak
cp /（指定）/logrotate.conf /etc/logrotate.conf

# swapの無効化
apt -y purge dphys-swapfile

# sury.orgの登録
wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list

# aptのワンライナー（更新自動化、LAMPの下準備）
#apt update && apt -y --no-install-recommends install unattended-upgrades nginx mariadb-server php7.4-fpm php7.4-curl php7.4-json php7.4-mbstring php7.4-mysql php-libsodium php-imagick php7.4-xml php7.4-zip ghostscript
apt update && apt -y --no-install-recommends install unattended-upgrades nginx mariadb-server php-fpm php-curl php-json php-mbstring php-mysql php-libsodium php-imagick php-xml php-zip ghostscript

# シャットダウン
shutdown -r now
