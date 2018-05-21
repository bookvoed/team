#/usr/bin/bash

if [ "$#" -ne 1 ]
then
    echo "Usage: sudo ./install.sh [username]"
    exit 1
fi