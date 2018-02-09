#!/bin/bash

BASEDIR=`dirname "$0"`
FULLPATH=`cd "$BASEDIR"; pwd`
cd $FULLPATH

function pull() {
  docker run --rm \
  -v $FULLPATH/root:/root \
  -v $FULLPATH:/app \
  tagplus5/ubuntu-ppa bash pull.sh
}

function checkVersion() {
  NEWVERSION=`docker run --rm -v $FULLPATH:/app tagplus5/ubuntu-ppa bash update.sh`
}

function updatePPA() {
  docker run --rm \
  -v $FULLPATH/root:/root \
  -v $FULLPATH:/app \
  tagplus5/ubuntu-ppa bash updatePPA.sh
}

function commit() {
  docker run --rm \
  -v $FULLPATH/root:/root \
  -v $FULLPATH:/app \
  tagplus5/ubuntu-ppa bash commit.sh
}

function push() {
  docker run --rm \
  -v $FULLPATH/root:/root \
  -v $FULLPATH:/app \
  tagplus5/ubuntu-ppa bash push.sh
}

pull

checkVersion

if [ $NEWVERSION = 1 ]; then
  updatePPA
  commit
  push
else
  echo "not update";
fi
