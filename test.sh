#/usr/bin/bash

if [ "$(id -u)" != "0" ]; then
	echo "Sorry, you are not root."
	echo "Try: curl -s https://raw.github.com/bookvoed/team/master/README.md | bash"
	exit 1
fi

WEBDEV_SERVER=10.0.5.221

# configure apt cache
echo 'Acquire::http::Proxy "http://10.0.5.221:3142/apt-cacher/"' > /etc/apt/apt.conf.d/00apt-cacher;
