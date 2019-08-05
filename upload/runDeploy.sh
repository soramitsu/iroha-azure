#!/bin/bash
while getopts "a:t:f:" opt; do
    case $opt in
        a)
            artifactsLocation=$OPTARG #base uri of the file including the container
        ;;
        t)
            token=$OPTARG #saToken for the uri - use "?" if the artifact is not secured via sasToken
        ;;
        f)
            fileToInstall=$OPTARG #filename of the file to download from storage
        ;;
    esac
done

# Configure logging
LOG_FILE=/tmp/runDeploy.log
exec > >(tee -ia $LOG_FILE)
exec 2> >(tee -ia $LOG_FILE >& 2)
exec 10> $LOG_FILE
BASH_XTRACEFD=10

# Configure environment
set -ex

fileUrl="${artifactsLocation}${fileToInstall}${token}"
stagingDir="/opt/iroha-deploy"
mkdir -p "$stagingDir"

curl -fsSL https://get.docker.com -o /tmp/get-docker.sh
sh /tmp/get-docker.sh
rm /tmp/get-docker.sh
apt update && apt -y install python3-pip
pip3 install docker-compose
curl -fsSL $fileUrl -o "$stagingDir/$fileToInstall"
pushd $stagingDir
tar zxf "$stagingDir/$fileToInstall"
pushd assets
docker-compose up -d