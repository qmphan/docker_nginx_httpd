#!/usr/bin/bash
PROJECT_NAME=$1
if [ "${PROJECT_NAME}" = "" ]
then
    echo "setup_env.sh must be run with project name as first argument";
    exit -1;
fi
cd /var/www/$PROJECT_NAME/workspace/src/Symfony
su nginx -c phpunit -c app
