#!/bin/bash
#
# Configuration of versions and other variables
#
# changed: 2024-Jan-04
#
# NOTEs:
# - any execution and modification(s) is only in responsibility of user
# - add container volume mapping(s) based on user preference
# - modify/align to fit user needs/requirements at your own
# - if needed use environment variables with same naming
#   (following variables have default/pre-defined values
#    and can be overrided by environment variables)
#
cwd=$(dirname $(realpath "${0}"))

# automatically recognize and set latest available versions
# (comment line below if manually specified versions are preferred
# and automatically recongized latest available should not take in place)
source "${cwd}/set_latest_versions_strings.sh"

# default target OS, architecture and platforms
export TARGETOS=${TARGETOS:-linux}
export TARGETARCH=${TARGETARCH:-amd64}
export TARGETPLATFORM=${TARGETPLATFORM:-"${TARGETOS}/${TARGETARCH}"}

# container user and group
export CONTAINER_USER=${CONTAINER_USER:-"user"}
export CONTAINER_GROUP=${CONTAINER_GROUP:-"user"}

# AZ CLI version
export AZ_CLI_VERSION=${AZ_CLI_VERSION:-2.71.0}

# Docker container entities
export CONTAINER_NAME=${CONTAINER_NAME:-"azure-cli"}

# it is crutial to have ":" in the beginning of the string
export CONTAINER_TAG=${CONTAINER_TAG:-":${AZ_CLI_VERSION}"}

# it is crutial to have "/" at the end of the string
export CONTAINER_REPOSITORY=${CONTAINER_REPOSITORY:-"mcr.microsoft.com/"}

export CONTAINER_IMAGE=${CONTAINER_IMAGE:-"${CONTAINER_REPOSITORY}${CONTAINER_NAME}${CONTAINER_TAG}"}
