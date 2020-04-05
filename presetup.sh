#!/bin/sh

# macOS関係のファイルを削除
rm -r /boot/.fseventsd /boot/.Spotlight-V100

# バックアップ用のディレクトリを作成
mkdir ~/backup

# IPアドレスの固定
mv /etc/dhcpcd.conf ~/backup
cp ./files/dhcpcd.conf /etc/dhcpcd.conf

# syslogの外部受け入れを許可
mv /etc/rsyslog.conf ~/backup
cp ./files/rsyslog.conf /etc/rsyslog.conf

# logrotateの無効化
mv /etc/logrotate.conf ~/backup
cp ./files/logrotate.conf /etc/logrotate.conf

# swapの無効化
apt -y purge dphys-swapfile

# 必要なパッケージのインストール（LAMP環境、更新自動化）
apt update
apt -y --no-install-recommends install libnginx-mod-http-image-filter- nginx mariadb-server php-fpm php-curl php-mbstring php-mysql php-imagick php-xml php-zip ghostscript unattended-upgrades

# シャットダウン
shutdown -r now
