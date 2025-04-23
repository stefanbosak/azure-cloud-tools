#!/bin/bash
#
# Wrapper for recognizing latest available tools versions
#

# site prefix
URI_PREFIX="https://mcr.microsoft.com"

# amount of latest versions strings to show
VERSIONS_AMOUNT=${VERSIONS_AMOUNT:-1}

# check prerequisites (if all required tools are available)
TOOLS="curl jq"

for tool in ${TOOLS}; do
  if [ -z "$(which ${tool})" ]; then
    echo "Tool ${tool} has not been found, please install tool in your system"
    exit 1
  fi
done

echo "AZ_CLI_VERSION:"
curl -sSL "${URI_PREFIX}/v2/azure-cli/tags/list" | jq --raw-output '.tags|.[] | select(test("^\\d+\\.\\d+\\.\\d+$"))' | sort -V | tail -n ${VERSIONS_AMOUNT}
echo ";"
