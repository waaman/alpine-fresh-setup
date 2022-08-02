#!/bin/sh

echo "--------------------------------------------------------"
echo "scripts/01-cifs.sh"
echo "--------------------------------------------------------"

ROOT_DIR=$(dirname $(readlink -f $0))/..

echo "CIFS / SAMBA ?"
echo "(o/N)"
read cifs

if [[ ! ${cifs} =~ ^(n|N)$ ]]
then
    apk add cifs-utils samba
fi