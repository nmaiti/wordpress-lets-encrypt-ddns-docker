#!/bin/bash

###################################################################
# Script Name : init_folders.sh
# 
# Description :
#
# Args :
#
# Creation Date : 05-12-2020
# Last Modified :
# 
# Created By : Nabendu Maiti 
###################################################################


function check_create_dir() {
	if [ ! -d wordpress ]; then
		mkdir -p  logs/ mysql/ wordpress/
	fi
	if [ ! -d nginx-proxy ]; then
		mkdir -p nginx-proxy_conf
		cd nginx-proxy_conf
		mkdir -p html
		mkdir -p vhost
		mkdir -p dhparam
		cd ..
	fi
	if [ ! -d acme ]; then
		mkdir -p acme
	fi
	if [ ! -d certificates ]; then
		mkdir -p certificates
	fi
}

check_create_dir
# wpress_net_present=`docker network inspect $(docker network ls -q) | grep "nginx_wpress"`
###echo $wpress_net_present
###if [ -z "$wpress_net_present" ]; then
###	docker network create nginx_wpress
###fi
echo "Starting your server......"
docker-compose up

