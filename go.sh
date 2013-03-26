#/usr/bin/bash

if [ "$(id -u)" != "0" ]; then
	echo "Sorry, you are not root."
	echo "Try: wget -qO - https://raw.github.com/bookvoed/team/master/go.sh | bash"
	exit 1
fi

# configure apt cache
echo 'Acquire::http::Proxy "http://10.0.5.221:3142/apt-cacher/";' > /etc/apt/apt.conf.d/00apt-cacher

add-apt-repository -y ppa:ondrej/php5
apt-get -y update
apt-get -y upgrade

apt-get -y install \
    autossh\
    nginx\
    sphinxsearch\
    curl\
    php5\
    php5-dev\
    php5-dbg\
    php5-xdebug\
    php5-pgsql\
    php-apc\
    php5-fpm\
    php5-xsl\
    php5-curl\
    php-pear\
    lessc\
    unrar\
    dia\
    graphviz\
    pidgin\
    thunderbird\
    chromium-browser\
    stardict\
    lyx\
    git\
    subversion\
    links\
    vim\
    gedit\
    gimp\
    gcc\
    make\
    automake\
    nfs-common\
    ttf-mscorefonts-installer\
    postgresql-9.1\
    rubygems\
    python-setuptools\
    bar

pecl install xdebug
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

gem install \
    taskjuggler

easy_install \
 http://closure-linter.googlecode.com/files/closure_linter-latest.tar.gz

# mount nfs

mkdir /mnt/web
mount 10.0.5.221:/srv/homes/web /mnt/web
echo "10.0.5.221:/srv/homes/web /mnt/web nfs timeo=10" >> /etc/fstab

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
echo "  1. rigister ssh key in github.com (use ssh-keygen)"
echo "  2. git checkout https://github.com/bookvoed/bookvoed.git"
echo "  3. cd ~/firebird/dev"
echo "  3. ./recratedb.sh"
echo "  3. ./.etc/dev/isntall.sh $username"
echo "  3. phing rc"
echo ""
