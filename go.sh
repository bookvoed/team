#!/bin/bash

if [ "$(id -u)" != "0" ]; then
	echo "Sorry, you are not root."
	echo "Try: wget -qO - https://raw.github.com/bookvoed/team/master/go.sh | bash"
	exit 1
fi

#exit on first error
set -e

sudo apt-get -y purge openjdk*
sudo apt-get -y install software-properties-common

#nodejs
apt-add-repository -y ppa:chris-lea/node.js
#java
apt-add-repository -y ppa:webupd8team/java
#gimp
apt-add-repository -y ppa:otto-kesselgulasch/gimp

apt-get -y update
apt-get -y dist-upgrade

apt-get -y install \
    mc\
    ssh\
    nginx\
    sphinxsearch\
    php5 \
    php5-dev\
    php5-dbg\
    php5-json\
    php5-xdebug\
    php5-pgsql\
    php-apc\
    php5-fpm\
    php5-xsl\
    php5-intl\
    php5-curl\
    php5-gd\
    php5-memcached\
    php-pear\
    dia\
    dmtx-utils\
    graphviz\
    pidgin\
    thunderbird\
    password-gorilla\
    chromium-browser\
    stardict\
    lyx\
    git\
    gitk\
    vim\
    gedit\
    gimp\
    gcc\
    make\
    memcached\
    automake\
    nfs-common\
    cifs-utils\
    postgresql-9.1\
    postgresql-contrib\
    rubygems\
    python-setuptools\
    bar\
    pgadmin3\
    kcachegrind\
    oracle-java8-installer\
    nodejs

pecl install xdebug
pecl install dbase
echo "extension=dbase.so" > /etc/php5/mods-available/dbase.ini 
echo "extension=dbase.so" > /etc/php5/cli/conf.d/20-dbase.ini   
pear config-set auto_discover 1
pear install --alldeps \
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

pwd=`pwd`
username=${pwd#/home/}

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
mkdir /var/firebird/files
mkdir /var/firebird/indexes
mkdir /var/firebird/testcase
mkdir /var/firebird/testcase/files
mkdir /var/firebird/testcase/indexes

chown -R $username:$username /var/firebird
chown -R $username:$username /home/$username/firebird

# install phpstorm

/mnt/web/stations/workstation2/soft/phpstorm/install.sh $username

echo ""
echo ""
echo "NEXT STEPS:"
echo "  1. register ssh key in github.com (use ssh-keygen)"
echo "  2. git checkout https://github.com/bookvoed/bookvoed.git"
echo "  3. cd ~/firebird/dev"
echo "  3. ./recratedb.sh"
echo "  3. ./.etc/dev/isntall.sh $username"
echo "  3. phing rc"
