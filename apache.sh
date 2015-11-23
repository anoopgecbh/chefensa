#!/bin/bash
echo " please check os is ubuntu and "
sudo apt-get update   # update repo package
sudo apt-get install apache2 # apache2 install
sudo apt-get install mysql-server php5-mysql # mysql-server and php module for mysql
sudo mysql_install_db   # mysql-client install
sudo mysql_secure_installation #
sudo apt-get install php5 libapache2-mod-php5 php5-mcrypt vim # some tool will require 
sudo service apache2 restart # apache service restart
sudo service mysql restart  # mysql restart

#-----------------------------install wordpress-------------------------------------------#
echo -n "welcome for configure your site  [Please Enter the name of site]: ";
read site;
sudo mkdir -p /var/www/html/$site;
cd /var/www/html/$site;
wget http://wordpress.org/latest.tar.gz;
tar -xvf latest.tar.gz ; cd wordpress ;
cp wp-config-sample.php wp-config.php
mv * /var/www/html/$site ; rmdir ../wordpress;

echo -n "Enter Name Of Database : " ;
read new_db;
echo -n "enter the db username :" ;
read new_db_user;
echo -n "enter the password for db: ";
read new_db_user_pass;
#-----------------------------database creation with user------------------------------------------------#
mysql -uroot <<MYSQL_SCRIPT
CREATE DATABASE $new_db;
CREATE USER '$new_db_user'@'localhost' IDENTIFIED BY '$new_db_user_pass';
GRANT ALL PRIVILEGES ON $new_db_user.* TO '$new_db_user'@'localhost';
FLUSH PRIVILEGES;
MYSQL_SCRIPT

#------------------------------editing in wp-config---------------------------------------------#
cd /var/www/html/$site;
vim -c "%s/database_name_here/$new_db" wp-config.php;
vim -c "%s/username_here/$new_db_user" wp-config.php
vim -c "%s/password_here/$new_db_user_pass" wp-config.php
sudo service apache2 restart
echo "play with wordpress http://YOUR IP/$site";
