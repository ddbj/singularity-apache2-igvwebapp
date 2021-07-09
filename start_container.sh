#!/bin/bash

module load singularity/3.5.2

CONTAINER_HOME=$(cd $(dirname $0); pwd)
CONTAINER="apache_igvwebapp"
IMAGE="ubuntu-18.04-apache-2.4.48-igvwebapp-1.5.5_latest.sif"

if [ ! -e ${CONTAINER_HOME}/htdocs ]; then
    mkdir ${CONTAINER_HOME}/htdocs
fi

if [ ! -e ${CONTAINER_HOME}/cgi-bin ]; then
    mkdir ${CONTAINER_HOME}/cgi-bin
fi

if [ ! -e ${CONTAINER_HOME}/logs ]; then
    mkdir ${CONTAINER_HOME}/logs
fi

if [ ! -e ${CONTAINER_HOME}/${IMAGE} ]; then
    singularity pull --arch amd64 library://yookuda/default/ubuntu-18.04-apache-2.4.48-igvwebapp-1.5.5:latest
fi

singularity instance start \
-B ${CONTAINER_HOME}/httpd.conf:/usr/local/apache2/conf/httpd.conf \
-B ${CONTAINER_HOME}/logs:/usr/local/apache2/logs \
-B ${CONTAINER_HOME}/htdocs:/usr/local/apache2/htdocs \
-B ${CONTAINER_HOME}/cgi-bin:/usr/local/apache2/cgi-bin \
-B ${CONTAINER_HOME}/package.json:/usr/local/src/igv-webapp/package.json \
-B ${CONTAINER_HOME}/start.sh:/usr/bin/start.sh \
${CONTAINER_HOME}/${IMAGE} \
${CONTAINER}

singularity exec instance://${CONTAINER} /usr/local/apache2/bin/apachectl start
singularity exec instance://${CONTAINER} /usr/bin/start.sh 1>> igv-webapp.log 2>> igv-webapp.log &
