#!/bin/sh

# swap領域の削除
rm /var/swap

# WordPressのダウンロード
wget --no-use-server-timestamps https://ja.wordpress.org/latest-ja.tar.gz
tar xvzf latest-ja.tar.gz -C /var/www

# 所有権の変更
chown -cR apache:apache /var/www/wordpress
find /var/www/wordpress -type f -print | xargs chmod 604
find /var/www/wordpress -type d -print | xargs chmod 705
chmod 400 /var/www/wordpress/wp-config.php
