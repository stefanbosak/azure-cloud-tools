#!/bin/bash
#
# Wrapper for standalone installation of Azure cloud tools
#
# NOTEs:
# - user has to have root priviledges / sudo to execute standalone-install.sh
#   only when using Microsoft maintained script installer
# - user does not need to have root priviledges using Python virtual environment
#   (preferred way)
#   - path for Python virtual environment is based on
#     PYTHON_WORKSPACE variable which can be customized up to user requirements
#   - make sure Python virtual envirmnent in PYTHON_WORKSPACE is not in use
#     when running this script
#
cwd=$(dirname $(realpath "${0}"))

# Python virtual envronment workspace directory prefix
PYTHON_WORKSPACE=${PYTHON_WORKSPACE:-"${cwd}"}

# Python virtual envronment workspace directory
PYTHON_WORKSPACE="${PYTHON_WORKSPACE}/venv"

# set variables
source "${cwd}/setvariables.sh"

#
# Microsoft maintained script installer (not preferred way, be carefull using this)
#
# See https://learn.microsoft.com/en-us/cli/azure/install-azure-cli-linux?pivots=script#install-specific-version
#
#AZ_CLI_INSTALLER_URI="https://aka.ms/InstallAzureCli"

# download and install AZ CLI tool
#curl -sSL "${AZ_CLI_INSTALLER_URI}" | bash

#
# python pip approach to cover all platforms (preferred way)
#
# try to find requested version in python repository
echo "Checking if requested AZ CLI version is available in Python repository"
PIP_AZ_CLI_VERSION=$(pip index versions azure-cli 2> /dev/null | awk -F ':' '{print $2}' | sed -e 's/ /\n/g' -e 's/,//g' | sort -V | grep "${AZ_CLI_VERSION}")

# recognize latest AZ CLI tool version in python repository
echo "Gathering AZ CLI tool latest version available in Python repository"
PIP_AZ_CLI_LATEST_VERSION=$(pip index versions azure-cli 2> /dev/null | awk -F ':' '{print $2}' | sed -e 's/ /\n/g' -e 's/,//g' | sort -V | tail -n 1)

if [ -z "${PIP_AZ_CLI_VERSION}" ]; then
  echo "Requested AZ CLI tool version (${AZ_CLI_VERSION}) not found in Python repository, using latest available (${PIP_AZ_CLI_LATEST_VERSION}) instead"
  PIP_AZ_CLI_VERSION="${PIP_AZ_CLI_LATEST_VERSION}"
fi

# remove previously created Python virtual environment workspace
if [ -d "${PYTHON_WORKSPACE}" ]; then
  rm -fr "${PYTHON_WORKSPACE}"
fi

# create and enter to Python virtual environment
echo "Creating Python virtual environment workspace in ${PYTHON_WORKSPACE}"
python3 -m venv "${PYTHON_WORKSPACE}"

# activating Python virtual environment
source "${PYTHON_WORKSPACE}/bin/activate"

# install pre-defined version given by variable into Python virtual environment
pip install azure-cli==${PIP_AZ_CLI_VERSION}

# leave Python virtual environment
deactivate

# provide hint how to access installed AZ CLI tool
echo "use source "${PYTHON_WORKSPACE}/bin/activate" to access AZ CLI tools"
