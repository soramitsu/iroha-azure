## Overview
This repository stores technical artifacts for managed application offer of Iroha on Azure Marketplace.

It creates a VM that runs a single Iroha peer with exposed client port 50051. This is a PoC so that we go through the (more) complex path of collecting and publishing all the [business artifacts](https://docs.microsoft.com/en-us/azure/marketplace/cloud-partner-portal/azure-applications/cpp-prerequisites#business-requirements).

## Structure
- `assets` directory stores keys for Iroha peer as well as 2 admin accounts -- Alice and Bob. There is also Docker Compose file that runs Iroha instance in a container.
- `upload` directory stores templates of infrastructure resources to be deployed on Azure. They are copied with slight modifications from Azure quickstart templates [repository on Github](https://github.com/Azure/azure-quickstart-templates/tree/master/100-marketplace-sample). Shell scripts in directory's root also taken from there.

## Quick start
- Fill in SSH password in `upload/azuredeploy.parameters.json` file;
- Create gzipped TAR archive containing `assets` directory called `assets.tar.gz` and put it in `upload` directory;
- Run `az-group-deploy.sh` script to test template deployment. It will upload artifacts into Azure storage and deploy a single VM instance with running Iroha instance on it.