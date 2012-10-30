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
    nginx\
    sphinxsearch\
    php5 \
    php5-dev\
    php5-dbg\
    php5-xdebug\
    php5-pgsql\
    php-apc\
    php5-fpm\
    php5-xsl\
    php5-curl\
    php-pear\
    dia\
    graphviz\
    pidgin\
    thunderbird\
    chromium-browser\
    stardict\
    lyx\
    git\
    vim\
    gedit\
    gimp\
    gcc\
    make\
    automake\
    nfs-common\
    postgresql-9.1\
    rubygems\
    python-setuptools\
    bar

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

 # add to fstab
 echo "10.0.5.221:/srv/homes/web /mnt/web nfs timeo=10" >> /etc/fstab
