#/usr/bin/bash

if [ "$(id -u)" != "0" ]; then
	echo "Sorry, you are not root."
	echo "Try: wget -qO - https://raw.github.com/bookvoed/team/master/new-workspace.sh | bash"
	exit 1
fi

# configure apt cache
echo 'Acquire::http::Proxy "http://10.0.5.221:3142/apt-cacher/";' > /etc/apt/apt.conf.d/00apt-cacher

add-apt-repository -y ppa:ondrej/php5
apt-get upgrade
apt-get install \
    php5 \
    php5-dev\
    php5-dbg\
    php5-xdebug\
    php5-pgsql\
    php-apc\
    php5-fpm\
    php5-xsl\
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

# mount nfs

mkdir /mnt/web
mount 10.0.5.221:/srv/homes/web /mnt/web
