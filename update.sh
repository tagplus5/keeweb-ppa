#!/bin/bash

BASEDIR=`dirname "$0"` 
FULLPATH=`cd "$BASEDIR"; pwd`
cd $FULLPATH

mkdir -p $FULLPATH/ubuntu
cd $FULLPATH/ubuntu

COUNT1=`ls -1 | wc -l`

LINKS=`wget -q --output-document - https://github.com/keeweb/keeweb/releases | grep -Eo '/.*\.deb' | head -n 2`

while read -r url; do
    wget -q -N https://github.com$url
done <<< "$LINKS"

for n in 0 1 2 3 4 5 6 7 8 9
do
	rename "s/\\.$n\./.0$n./g" *.deb -f
    rename "s/\\.$n\./.0$n./g" *.deb -f
done

COUNT2=`ls -1 | wc -l`

ls -F *.deb | head -n -5 | xargs rm 2> /dev/null

if [ "$COUNT1" != "$COUNT2" ]; then
    echo 1
else
    echo 0
fi
