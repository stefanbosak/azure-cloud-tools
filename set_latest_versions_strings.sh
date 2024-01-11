#!/bin/bash
#
# Wrapper to automatically detect and set latest
# available versions for all of related tools
#
cwd=$(dirname $(realpath "${0}"))

# 1 which means latest versions
export VERSIONS_AMOUNT=1

# create temporary workspace
TMP_DIR=$(mktemp -d)
TMP_ENVIRONMENT="${TMP_DIR}/environment"
TMP_SCRIPT="${TMP_DIR}/script.sh"

# cleanup temporary workspace
trap 'rm -fr ${TMP_DIR}' EXIT

# generate environment variables data
"${cwd}/get_versions_strings.sh" | tr ':' '=' | tr -d '\n' | tr ';' '\n' > "${TMP_ENVIRONMENT}"

# generate temporary script
echo "#!/bin/bash" > "${TMP_SCRIPT}"
sed 's/^/export /g' "${TMP_ENVIRONMENT}" >> "${TMP_SCRIPT}"

# make script executable
chmod +x "${TMP_SCRIPT}"

# source content of temporary script
# publish exports to who called me
# (this script)
source "${TMP_SCRIPT}"
