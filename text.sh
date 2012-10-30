#/usr/bin/bash

# !!! ЭТОТ ФАЙЛ ДЛЯ ТЕСТИРОВАНИЯ ЗАПУСКАТЬ go.sh !!!

echo "please enter username:"
read username

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