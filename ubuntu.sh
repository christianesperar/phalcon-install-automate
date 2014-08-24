#!/bin/bash
# REQUIREMENTS

echo "Checking requirements....."
sudo apt-get install php5-dev libpcre3-dev gcc make php5-mysql

# COMPILATION

echo "Cloning....."
git clone --depth=1 git://github.com/phalcon/cphalcon.git

echo "Building....."
cd cphalcon/build

echo "Installing....."
sudo ./install

echo "Add extension....."
echo -e "\nextension=phalcon.so" >> /etc/php5/apache2/php.ini

echo "Restarting Apache....."
sudo service apache2 restart

echo "extension=phalcon.so" > /etc/php5/apache2/conf.d/30-phalcon.ini
echo "Phalcon installation successful"