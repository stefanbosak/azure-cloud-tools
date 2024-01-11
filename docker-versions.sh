#!/bin/bash
#
# Wrapper to obtain version metadata of tools inside docker container
#
# NOTEs:
# - any execution and modification(s) is only in responsibility of user
# - modify/align to fit user needs/requirements at your own
#
cwd=$(dirname $(realpath "${0}"))

DOCKER_CMD="${cwd}/docker-run.sh "

echo -ne "Try to run docker container and get hostname: "
${DOCKER_CMD} "hostname"

if [ ${?} -ne 0 ]; then
  echo "Docker run failed, see more above."
  exit 1
fi

echo -ne "Azure CLI: "
${DOCKER_CMD} "az --version | head -n 1"
