#!/bin/sh
set -e

function init_root_folder() {
  echo "=> Prepare Data Root folder"
  FOLDER=$(dirname $NGINX_CONFIG_FOLDER)
  mkdir -p $FOLDER
  chmod 755 /data

  echo
}

function init_nginx_config_folder() {
    FOLDER="$NGINX_CONFIG_FOLDER"

    if [[ ! -d $FOLDER ]]; then
        echo "=> No NGINX CONFIG folder detected."
        echo "=> Creating NGINX Configuration at $FOLDER .."

        mkdir -p $FOLDER;
        cp /etc/nginx_origin/* $FOLDER/ -R
    else
      echo "=> Using an existing NGINX Configuration at $FOLDER"          
    fi

    echo
}

function init_nginx_log_folder() {
    FOLDER="$NGINX_LOG_FOLDER"

    if [[ ! -d $FOLDER ]]; then
        echo "=> No NGINX LOG folder detected."
        echo "=> Creating NGINX LOG folder at [$FOLDER] ..."

        mkdir -p $FOLDER
        chown ${HOST_USER_NAME}:${HOST_GROUP_NAME} $FOLDER
    else
      echo "=> Using an existing NGINX LOG folder at $FOLDER"          
    fi

    echo
}

echo "***************************************"
echo "* INITIALIZING NGINX ...."
echo "***************************************"
echo 
init_root_folder
init_nginx_config_folder
init_nginx_log_folder
