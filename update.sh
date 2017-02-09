#/bin/bash

BASEDIR=`dirname "$0"` 
FULLPATH=`cd "$BASEDIR"; pwd`
cd $FULLPATH

git pull

mkdir -p $FULLPATH/ubuntu
cd $FULLPATH/ubuntu

COUNT1=`ls -1 | wc -l`

LINKS=`wget -q --output-document - https://github.com/keeweb/keeweb/releases | grep -Eo '/.*deb'`

while read -r url; do
    wget -q -N https://github.com$url
done <<< "$LINKS"

COUNT2=`ls -1 | wc -l`

if [ "$COUNT1" != "$COUNT2" ]; then    
    bash $FULLPATH/push.sh
fi;
