#!/bin/bash

# Downloads mail addrtess book from windows server

which ldapsearch >/dev/null 2>&1
installed=$?

if [ "$installed" -ne 0 ]; then
  echo "Run 'sudo apt-get install ldap-utils' and try again."
  exit 1
fi

echo -n "Windows username: "
read name

echo -n "Password: "
read -s pass

ldapsearch -b 'dc=booknet,dc=local' -D "BOOKNET\\$name" -h 'booknet.local' -w "$pass" '(&(showInAddressBook=*)(mail=*)(mailNickname=*)(|(objectClass=person)(objectClass=group)(objectClass=groupOfNames)))' >> ~/mail.ldif

echo

echo 'Done.'
