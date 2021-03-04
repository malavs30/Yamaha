apt-get update && apt-get -qq upgrade && apt-get -qq autoremove && apt-get autoclean
apt update && apt upgrade -y && apt autoremove -y && apt autoclean
apt install apache2 -y
a2enmod rewrite
systemctl restart apache2
systemctl enable apache2
sed -i '172d' /etc/apache2/apache2.conf
sed -i "172i \       \ AllowOverride all" /etc/apache2/apache2.conf
apt install mysql-server -y
apt install curl -y
apt install wget -y
apt install composer -y
apt install php7.4 libapache2-mod-php7.4 php7.4-mysql php7.4-soap php7.4-bcmath php7.4-xml php7.4-mbstring php7.4-gd php7.4-common php7.4-cli php7.4-curl php7.4-intl php7.4-zip zip unzip -y
cd /home/ubuntu/ && wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.6.0-amd64.deb
cd /home/ubuntu/ && dpkg -i elasticsearch-7.6.0-amd64.deb
/bin/systemctl daemon-reload
/bin/systemctl enable elasticsearch.service
systemctl start elasticsearch
mysql -u root -e "create database magento;"
mysql -u root -e "CREATE USER 'magento'@'localhost' IDENTIFIED BY 'eternal@123';"
mysql -u root -e "GRANT ALL PRIVILEGES ON *.* TO "magento"@"localhost" WITH GRANT OPTION;"
mysql -u root -e "FLUSH PRIVILEGES;"
rm -rf /var/www/html/index.html
cd /var/www/html && wget https://magentositeeternal.s3.amazonaws.com/magento2-2.4.1.tar.gz
cd /var/www/html && tar -xzvf magento2-2.4.1.tar.gz
mv /var/www/html/magento2-2.4.1/* /var/www/html/
mv /var/www/html/magento2-2.4.1/.editorconfig /var/www/html/
mv /var/www/html/magento2-2.4.1/.github /var/www/html/
mv /var/www/html/magento2-2.4.1/.gitignore /var/www/html/
mv /var/www/html/magento2-2.4.1/.htaccess /var/www/html/
mv /var/www/html/magento2-2.4.1/.htaccess.sample /var/www/html/
mv /var/www/html/magento2-2.4.1/.php_cs.dist /var/www/html/
mv /var/www/html/magento2-2.4.1/.user.ini /var/www/html/
( cd /var/www/html/ && /usr/bin/composer install )
cd /var/www/html/ && find var generated vendor pub/static pub/media app/etc -type f -exec chmod g+w {} + && find var generated vendor pub/static pub/media app/etc -type d -exec chmod g+ws {} + && chown -R :www-data . && chmod u+x bin/magento
php /var/www/html/bin/magento setup:install --base-url=http://$(curl http://checkip.amazonaws.com) --db-host=localhost --db-name=magento --db-user=magento --db-password=eternal@123 --admin-firstname=test --admin-lastname=test --admin-email=test@example.com --admin-user=admin --admin-password=admin123 --language=en_US --currency=USD --timezone=America/Chicago --use-rewrites=1
sed -i '7d' /var/www/html/app/etc/env.php && sed -i "7i \        \ 'frontName' => 'admin'" /var/www/html/app/etc/env.php
php /var/www/html/bin/magento cache:flush
chown -R ubuntu:www-data /var/www/html
systemctl restart apache2
systemctl restart elasticsearch
