#!/bin/bash
set -e
set -u

######### run local sdopythonapp script #######
PWD="`pwd`"
PROG="`basename $0`"

echo "Run sdopythonapp application localy...."

if [ ! -d sdopythonapp ]
then
    echo "No 'sdopythonapp' directory here aborting!"
    exit 1
fi

if [ ! -d sdopythonapp/runscripts ]
then
    echo "No 'sdopythonapp/runscripts' directory here aborting!"
    exit 1
fi

if [ ! -x sdopythonapp/runscripts/runpythonlocal.sh ]
then
    echo "No 'sdopythonapp/runscripts/runpythonlocal.sh' here aborting!"
    exit 1
fi

sdopythonapp/runscripts/runpythonlocal.sh 