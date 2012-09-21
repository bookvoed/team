#/usr/bin/bash

if [ "$(id -u)" != "0" ]; then
	echo "Sorry, you are not root."
	echo "Try: curl -s https://raw.github.com/bookvoed/team/master/README.md | bash"
	exit 1
fi