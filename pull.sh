#!/bin/bash

BASEDIR=`dirname "$0"`
FULLPATH=`cd "$BASEDIR"; pwd`
cd $FULLPATH

git pull
