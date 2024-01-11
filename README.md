# azure-cloud-tools

Aim of this repository is to provide flexible helpers/wrappers for preparing
common tools (pre-defined versions) frequently required when working
with [Azure](https://azure.microsoft.com/en-us) ecosystem/environment. 

covered common CLI tools to interact with Azure ecosystem:
- [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/)
- [Bicep](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/)
  - for installation run (when using Azure CLI first time): az bicep install

> [!NOTE]
> Every script and file would be reasonable well commented and relevant details can be found there.

> [!IMPORTANT]
> Check details before taking any action.

> [!CAUTION]
> User is responsible for any modification and execution of any parts from this repository.

__shared scripts:__
- [setvariables.sh](setvariables.sh): set required versions for above mentioned tools
- [get_versions_string.sh](get_versions_strings.sh): get versions strings for above mentioned tools
- [set_latest_versions_strings.sh](set_latest_versions_strings.sh): set latest versions strings for above mentioned tools as environment variables

### Docker container approach
Docker run script is simple wrapped for on-demand execution of related tools.

__scripts and files:__
- [docker-run.sh](docker-run.sh): wrapper as Docker runner script
- [docker-versions.sh](docker-versions.sh): wrapper for showing tools versions
- [![build_status_badge](https://github.com/stefanbosak/azure-cloud-tools/actions/workflows/docker-image-test-amd64-arm64.yml/badge.svg?branch=main)](.github/workflows/docker-image-test-amd64-arm64.yml): GitHub Actions workflow file for automation of Docker image testing (amd64, arm64)
  - MacOS Docker is covered via Colima (prerequisite; installation might take long time, sometimes it is not deterministic and execution could fail, situation might change in the future)

### Standalone installer approach
Dedicated installer wrapper script is covering all of above mentioned tools.
Read detail inside script. There are two ways of installation:
- based on Python virtual environment workspace (highly recommended)
- using Microsoft maintained installed (commented approach, be carefull when considering to use)

__scripts and files:__
- [standalone-install.sh](standalone-install.sh): standalone installer script
- [![build_status_badge](https://github.com/stefanbosak/azure-cloud-tools/actions/workflows/standalone-test-amd64.yml/badge.svg?branch=main)](.github/workflows/standalone-test-amd64.yml): GitHub Actions workflow file for automation of standalone testing (amd64)
