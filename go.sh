#!/bin/bash

if [ "$(id -u)" != "0" ]; then
	echo "Sorry, you are not root."
	echo "Try: wget -qO - https://raw.github.com/bookvoed/team/master/go.sh | bash"
	exit 1
fi

#exit on first error
set -e

echo -n "Enter username: "
read username
id -u "$username" >/dev/null 2>&1

if [ "$?" -ne 0 ] || [ ! -d "/home/$username" ]; then
  echo "User '$username' does not exists or has no '/home/$username' folder."
  exit 1
fi

apt-get -y purge openjdk*
apt-get -y install software-properties-common

#git
add-apt-repository -y ppa:git-core/ppa
#nodejs
apt-add-repository -y ppa:chris-lea/node.js
#java
apt-add-repository -y ppa:webupd8team/java
#gimp
apt-add-repository -y ppa:otto-kesselgulasch/gimp
#postgres
add-apt-repository "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -sc)-pgdg main 9.5"
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -

apt-get -y update
apt-get -y dist-upgrade

apt-get -y install \
    automake\
    bar\
    chromium-browser\
    cifs-utils\
    dia\
    dmtx-utils\
    gcc\
    gedit\
    gimp\
    git\
    gitk\
    google-perftools\
    graphviz\
    kcachegrind\
    lyx\
    make\
    mc\
    memcached\
    msttcorefonts\
    nfs-common\
    nginx\
    nodejs\
    oracle-java8-installer\
    password-gorilla\
    pgadmin3\
    php-apc\
    php-pear\
    php5\
    php5-curl\
    php5-dbg\
    php5-dev\
    php5-fpm\
    php5-gd\
    php5-intl\
    php5-json\
    php5-memcached\
    php5-msgpack\
    php5-pgsql\
    php5-redis\
    php5-xdebug\
    php5-xsl\
    pidgin\
    postgresql-9.5\
    postgresql-contrib\
    python-setuptools\
    redis-server\
    ruby\
    sphinxsearch\
    ssh\
    stardict\
    thunderbird\
    vim

fc-cache -fv

pecl install --nocompress xdebug
pecl install --nocompress dbase
pecl install memprof
echo "extension=dbase.so" > /etc/php5/mods-available/dbase.ini 
echo "extension=dbase.so" > /etc/php5/cli/conf.d/20-dbase.ini   
pear config-set auto_discover 1
pear install --nocompress --alldeps \
   pear.phpunit.de/PHPUnit \
   phpunit/DbUnit \
   phpunit/PHPUnit_Selenium \
   phpunit/PHPUnit_Story \
   phpunit/PHPUnit_SkeletonGenerator \
   phpunit/PHPUnit_TestListener_DBUS \
   phpunit/PHPUnit_TestListener_XHProf \
   phpunit/PHPUnit_TicketListener_Trac \
   phpunit/PHP_Invoker \
   phpunit/PHPUnit_MockObject\
   VersionControl_Git \
   Archive_Tar \
   pear.pdepend.org/PHP_Depend-beta \
   pear.phpmd.org/PHP_PMD \
   phpunit/phpcpd \
   phpunit/phpdcd \
   pear.phpdoc.org/phpDocumentor-alpha \
   pear.phing.info/phing \
   Image_GraphViz \
   pear.bovigo.org/vfsStream-beta

easy_install \
 http://closure-linter.googlecode.com/files/closure_linter-latest.tar.gz

# less js 
npm install -g less
# csscomb 
npm install -g csscomb

# mount nfs
mkdir /mnt/web
mount 10.0.5.221:/srv/homes/web /mnt/web
echo "10.0.5.221:/srv/homes/web /mnt/web nfs timeo=10" >> /etc/fstab

#kill fucking avachi
service avahi-daemon stop
sed -i 's/^#\?domain-name=\(.*\)$/domain-name=.alocal/' /etc/avahi/avahi-daemon.conf

echo "========================================================="
echo ""
echo ""
echo "              INSTALLING WORKSPACE FOR USER"
echo ""
echo "                        $username"
echo ""
echo ""
echo "========================================================="

# make workspace

mkdir /home/$username/firebird
mkdir /home/$username/firebird/dev
mkdir /home/$username/firebird/rc

mkdir /var/firebird
mkdir /var/firebird/lock
mkdir /var/firebird/files
mkdir /var/firebird/mailer
mkdir /var/firebird/indexes
mkdir /var/firebird/testcase
mkdir /var/firebird/testcase/files
mkdir /var/firebird/testcase/indexes

chown -R $username:www-data /var/firebird
chown -R $username:www-data /home/$username/firebird
usermod -a -G www-data $username
usermod -a -G $username www-data

# install phpstorm

/mnt/web/stations/workstation2/soft/phpstorm/install.sh $username

echo ""
echo ""
echo "NEXT STEPS:"
echo "  1. register ssh key in github.com (use ssh-keygen)"
echo "  2. cd ~/firebird/dev"
echo "  3. git clone git@github.com:bookvoed/bookvoed.git ."
echo "  4. ./recratedb.sh"
echo "  5. sudo ./.etc/dev/install.sh $username"
echo "  6. phing rc"
echo "  7. ???"
echo "  6. PROFIT!"
