#!/usr/bin/env bash

# Stop running containers and remove related directories
read -p "Do you really want to stop and remove EVERYTHING (y/n)? " answer
case ${answer:0:1} in
    y|Y )
        echo "INFO: Stopping containers"
        docker-compose stop
        echo "INFO: Removing containers"
        docker-compose rm -f
        echo "INFO: Setting file permissions to that of the user"
        docker run --rm \
          -v $(pwd):/clean \
          -e UID=$(id -u) \
          -e GID=$(id -g) \
          nginx:latest /bin/bash -c 'chown -R $UID:$GID /clean'
        echo "INFO: Pruning unused docker volumes"
        docker volume prune -f
        echo "INFO: Pruning unused docker networks"
        docker network prune -f
        echo "INFO: Removing directories and contents (certificates/  logs/nginx mysql/ wordpress/)"
        rm -rf certificates/ logs/nginx mysql/ wordpress/ nginx-proxy_conf acme
        echo "INFO: Done"
        exit 0;
    ;;
    * )
		read -p "Do you want to stop only (y/n)? " answer2
		case ${answer2:0:1} in
			y|Y )
				echo "INFO: Stopping containers"
		        docker-compose stop
		        echo "INFO: Removing containers"
		        docker-compose rm -f
		        echo "INFO: Setting file permissions to that of the user"
		        docker run --rm \
		          -v $(pwd):/clean \
		          -e UID=$(id -u) \
		          -e GID=$(id -g) \
		          nginx:latest /bin/bash -c 'chown -R $UID:$GID /clean'
				echo "INFO: Done"
        		exit 0;
    		;;
			* )
				echo "INFO: Exiting without stopping containers or removing files"
        	exit 0;
			;;
		esac
    ;;
esac

exit 0;
