#!/bin/bash 
php /var/www/html/magento-new-build/bin/magento cache:clean &&
cd /var/www/html/magento-new-build && bin/magento setup:di:compile &&
rm -rf /var/www/html/*
rm -rf /var/www/html/.*
mv /var/www/html/magento-new-build/* /var/www/html/
mv /var/www/html/magento-new-build/.* /var/www/html/
chown -R www-data:www-data /var/www/html
service apache2 restart