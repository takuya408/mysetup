#!/bin/sh

# swap領域の削除
rm /var/swap

# nginxの設定
cp ./files/kawagoe /etc/nginx/sites-available
ln -s /etc/nginx/sites-available/kawagoe /etc/nginx/sites-enabled/default

# WordPressのダウンロード
wget -P ~ --no-use-server-timestamps https://ja.wordpress.org/latest-ja.tar.gz
tar xvzf ~/latest-ja.tar.gz -C /var/www

# 所有権の変更
chown -cR www-data:www-data /var/www/wordpress
find /var/www/wordpress -type f -print | xargs chmod 604
find /var/www/wordpress -type d -print | xargs chmod 705
#chmod 400 /var/www/wordpress/wp-config.php
