#!/usr/bin/env bash
set +x
set -e
export LC_ALL=en_US
export LANG="$LC_ALL"
export DISPLAY=:2
Xvfb -screen 0 1920x1080x24 :2 &
until xset -q
do
	echo "Waiting for X server to start..."
	sleep 1;
done
ratpoison &

export PYTHONPATH=/usr/lib/python2.x/site-packages
export PYTHONHOME=/usr
export PYTHONIOENCODING=utf-8
if [ -z "$3" ]
then
	included_tag=functional
else
	included_tag=$3
fi
if [ -z "$4" ]
then
        excluded_tag=performance
else
        excluded_tag=$4
fi
if [ -z "$5" ]
then
        main_browser=chrome
else
        main_browser=$5
fi
if [ -z "$6" ]
then
        secundary_browser=chrome
else
        secundary_browser=$6
fi
if [ -z "$2" ]
then
        test_path=test
else
        test_path=$2
fi

robot -d robot/output -x xunit -i $included_tag -e $excluded_tag -v server:$1 -v browser:$main_browser -v browser-2:$secundary_browser robot/$test_path
