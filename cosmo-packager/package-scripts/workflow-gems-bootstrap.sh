#!/usr/bin/env bash

function state_error
{
	echo "ERROR: ${1:-UNKNOWN} (status $?)" 1>&2
	exit 1
}

function check_pkg
{
	echo "checking to see if package $1 is installed..."
	dpkg -s $1 || state_error "package $1 is not installed"
	echo "package $1 is installed"
}

function check_user
{
	echo "checking to see if user $1 exists..."
	id -u $1 || state_error "user $1 doesn't exists"
	echo "user $1 exists"
}

function check_port
{
	echo "checking to see if port $1 is opened..."
	nc -z $1 $2 || state_error "port $2 is closed"
	echo "port $2 on $1 is opened"
}

function check_dir
{
	echo "checking to see if dir $1 exists..."
	if [ -d $1 ]; then
		echo "dir $1 exists"
	else
		state_error "dir $1 doesn't exist"
	fi
}

function check_file
{
	echo "checking to see if file $1 exists..."
	if [ -f $1 ]; then
		echo "file $1 exists"
		# if [ -$2 $1 ]; then
			# echo "$1 exists and contains the right attribs"
		# else
			# state_error "$1 exists but does not contain the right attribs"
		# fi
	else
		state_error "file $1 doesn't exists"
	fi
}

function check_upstart
{
	echo "checking to see if $1 daemon is running..."
	sudo status $1 || state_error "daemon $1 is not running"
	echo "daemon $1 is running"
}

function check_service
{
    echo "checking to see if $1 service is running..."
    sudo service $1 status || state_error "service $1 is not running"
    echo "service $1 is running"
}


PKG_NAME="workflow-gems"
PKG_DIR="/packages/workflow-gems"
BOOTSTRAP_LOG="/var/log/cloudify3-bootstrap.log"

BASE_DIR="/opt"
HOME_DIR="${BASE_DIR}/${PKG_NAME}"

echo "installing gems..."
cd ${PKG_DIR} && sudo /opt/ruby/bin/gem install *.gem --local