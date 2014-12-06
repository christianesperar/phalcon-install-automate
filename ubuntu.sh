#!/bin/bash
# REQUIREMENTS

PHALCON_TEMP_DIR=`mktemp --tmpdir -d cphalcon.XXXXXX`

echo "Checking requirements ..."
apt-get install php5-dev libpcre3-dev gcc make php5-mysql

# COMPILATION
# Clone the repo
echo "Cloning Phalcon ..."
git clone --depth=1 https://github.com/phalcon/cphalcon.git ${PHALCON_TEMP_DIR}
cd ${PHALCON_TEMP_DIR}

echo "Building ..."
cd build

echo "Installing....."
./install
wait

echo "Adding Phalcon as extension....."
#sleep 5
#echo "extension=phalcon.so" > /etc/php5/apache2/conf.d/30-phalcon.ini

if !(php --ri phalcon &> /dev/null); then
	if [ -d "/etc/php5/mods-available" ]; then
		echo 'extension=phalcon.so' > /etc/php5/mods-available/phalcon.ini
		[ -d '/etc/php5/cli' ] && ln -s /etc/php5/mods-available/phalcon.ini /etc/php5/cli/conf.d/phalcon.ini
		[ -d '/etc/php5/apache2' ] && ln -s /etc/php5/mods-available/phalcon.ini /etc/php5/apache2/conf.d/phalcon.ini
		[ -d '/etc/php5/fpm' ] && ln -s /etc/php5/mods-available/phalcon.ini /etc/php5/fpm/conf.d/phalcon.ini
	fi
fi

echo "Restarting Apache....."
#sudo service apache2 restart
service apache2 status &>/dev/null && service apache2 restart

rm -rf ${PHALCON_TEMP_DIR}

echo "Phalcon installation successful!"
