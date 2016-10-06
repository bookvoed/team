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

apt -y purge openjdk*
apt -y install software-properties-common curl

#git
add-apt-repository -y ppa:git-core/ppa
#nodejs
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
#java
add-apt-repository -y ppa:webupd8team/java
#gimp
add-apt-repository -y ppa:otto-kesselgulasch/gimp
#postgres
add-apt-repository "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -sc)-pgdg main 9.5"
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -

apt -y update
apt -y dist-upgrade

apt -y install \
    automake\
    bar\
    chromium-browser\
    cifs-utils\
    dia\
    dmtx-utils\
    gcc\
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
    unrar\
    oracle-java8-installer\
    password-gorilla\
    pgadmin3\
    php \
    php-fpm \
    php-pear\
    php-curl\
    php-dev\
    php-gd\
    php-intl\
    php-json\
    php-mbstring\
    php-memcached\
    php-msgpack\
    php-pgsql\
    php-redis\
    php-xdebug\
    php-xsl\
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

#apt -y install libjudy-dev # не работает с php7. Возможно, когда нибудь... https://github.com/arnaud-lb/php-memory-profiler
#pecl install memprof

pear config-set auto_discover 1
pear install --nocompress --alldeps \
   pear.phing.info/phing \
   VersionControl_Git \
   Archive_Tar \
   Image_GraphViz

easy_install https://github.com/google/closure-linter/zipball/master

# less js 
npm install -g less
# csscomb 
npm install -g csscomb

#composer
curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer

# mount nfs
mkdir /mnt/web
mount 10.0.5.221:/srv/homes/web /mnt/web
echo "10.0.5.221:/srv/homes/web /mnt/web nfs timeo=10" >> /etc/fstab

#kill fucking avachi
systemctl stop avahi-daemon.socket
systemctl disable avahi-daemon.socket
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
chmod -R 775 /var/firebird
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
