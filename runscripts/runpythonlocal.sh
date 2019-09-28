#!/bin/bash
set -e
set -u

######### sdopythonapp run local script #######
PWD="`pwd`"
PROG="`basename $0`"
INVENTORY="${PWD}/siteinventory.txt"

echo "sdopythonapp utility to run application using local dev_appserver.py"
if [ ! -f $INVENTORY ]
then
    echo "No 'siteinventory.txt' file here aboorting!"
    exit 1
fi
if [ ! -d sdopythonapp ]
then
    echo "No 'sdopythonapp' directory here aboorting!"
    exit 1
fi
if [ ! -d sdopythonapp/runscripts ]
then
    echo "No 'sdopythonapp/runscripts' directory here aboorting!"
    exit 1
fi
    
if [  -x ./runpythonpreprepare.sh ]
then
    echo "Running local preprepare script"
    ./runpythonpreprepare.sh $INVENTORY 
fi
if [  -x sdopythonapp/runscripts/runpythonprepare.sh ]
then
    echo "Running master prepare script"
    ( cd sdopythonapp ; ./runscripts/runpythonprepare.sh $INVENTORY )
fi
if [  -x ./runpythonpostprepare.sh ]
then
    echo "Running local postprepare script"
    ./runpythonpostprepare.sh $INVENTORY 
fi

echo ${PROG}: Moving to 'sdopythonapp' directory
cd sdopythonapp

ARGS="--enable_host_checking false --clear_search_indexes yes app.yaml"
if [ ! -z "$*" ]
then
    ARGS=$@
fi

echo dev_appserver.py $ARGS
echo "(To override default dev_appserver.py arguments run '$PROG [ new arguments ]')"
echo

sleep 2
dev_appserver.py $ARGS