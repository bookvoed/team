team
====

Полезные скрипты, информация и прочее.


Установщик
----------

test: http://goo.gl/q6CD3

wget -qO - http://goo.gl/q6CD3 | bash

wget -qO - https://raw.github.com/bookvoed/team/master/new-workspace.sh | bash

apt-cache
---------

    sudo aptitude install apt-cacher
    sudo vim /etc/default/apt-cacher
        AUTOSTART=1
    sudo service apt-cacher restart
    
    #import apt-cache
    sudo /usr/share/apt-cacher/apt-cacher-import.pl /var/cache/apt/archives
