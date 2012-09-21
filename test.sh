#/usr/bin/bash

if [ "$(id -u)" != "0" ]; then
	echo "Sorry, you are not root."
	echo "Try: wget -qO - https://raw.github.com/bookvoed/team/master/new-workspace.sh | bash"
	exit 1
fi

# mount nfs
mkdir /mnt/web
mount 10.0.5.221:/srv/homes/web /mnt/web

# configure apt cache
echo 'Acquire::http::Proxy "http://10.0.5.221:3142/apt-cacher/";' > /etc/apt/apt.conf.d/00apt-cacher

add-apt-repository -y ppa:ondrej/php5
apt-get -y update
apt-get -y upgrade