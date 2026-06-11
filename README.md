<div align="center">

# ☁ Azure Cloud Tools

**Azure ecosystem CLI tools (Hardened)**

[![build_status_badge](../../actions/workflows/docker-image-native-multiplatform-pipeline.yaml/badge.svg?branch=main)](.github/workflows/docker-image-native-multiplatform-pipeline.yaml)
[![Azure](https://img.shields.io/badge/microsoft%20azure-0089D6?style=for-the-badge&logo=microsoft-azure&logoColor=white)](https://learn.microsoft.com/en-us/cli/azure)

</div>

---

## 📦 Latest Build

<!-- VERSION_INFO_START -->
| Component | Version |
|-----------|---------|
| **Ansible** | [`v2.21.0`](https://github.com/ansible/ansible/releases/tag/v2.21.0) |
| **Azure CLI** | [`2.87.0`](https://github.com/Azure/azure-cli/releases/tag/azure-cli-2.87.0) |
| **Helm** | [`v4.2.0`](https://github.com/helm/helm/releases/tag/v4.2.0) |
| **K9s** | [`v0.51.0`](https://github.com/derailed/k9s/releases/tag/v0.51.0) |
| **Kops** | [`v1.35.1`](https://github.com/kubernetes/kops/releases/tag/v1.35.1) |
| **Kubectl** | [`v1.37.0-alpha.1`](https://github.com/kubernetes/kubernetes/releases/tag/v1.37.0-alpha.1) |
| **Terraform** | [`1.15.6`](https://github.com/hashicorp/terraform/releases/tag/v1.15.6) |
| **Terragrunt** | [`v1.0.8`](https://github.com/gruntwork-io/terragrunt/releases/tag/v1.0.8) |

> 🔄 Last updated: 2026-06-11T05:51:06Z · [Build #27](https://github.com/stefanbosak/azure-cloud-tools/actions/runs/27326498977)
<!-- VERSION_INFO_END -->

---

## 📋 Overview

This repository provides a fully automated preparation of <span style="color: #0969da;">**containerized**</span> [Azure](https://azure.microsoft.com/en-us) environment using <span style="color: #1a7f37;">**Docker-in-Docker**</span> architecture.

### Covered CLI tools

| Tool | Description |
|------|-------------|
| [Ansible CLI](https://docs.ansible.com/ansible/latest/command_guide/command_line_tools.html) | <span style="color: #8250df;">Configuration management and automation</span> |
| [Azure CLI](https://github.com/Azure/azure-cli) | <span style="color: #8250df;">Official Azure command-line interface</span> |
| [HELM CLI](https://helm.sh/docs/helm/) | <span style="color: #0969da;">Kubernetes package manager</span> |
| [kops CLI](https://kops.sigs.k8s.io/) | <span style="color: #0969da;">Kubernetes cluster management</span> |
| [kubectl CLI](https://kubernetes.io/docs/reference/kubectl/) | <span style="color: #0969da;">Kubernetes command-line tool</span> |
| [k9s CLI](https://k9scli.io/) | <span style="color: #0969da;">Terminal UI for Kubernetes</span> |
| [Terraform CLI](https://developer.hashicorp.com/terraform/cli) | <span style="color: #1a7f37;">Infrastructure as Code tool</span> |
| [Terragrunt CLI](https://terragrunt.gruntwork.io/) | <span style="color: #1a7f37;">Terraform wrapper for DRY configurations</span> |
| [Docker CLI](https://docker.com) | <span style="color: #d73a49;">Container management CLI</span> |
| [Bicep](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/) | <span style="color: #d73a49;">Bicep CLI</span> |

> [!NOTE]
> Every script and file is reasonably well commented and relevant details can be found there.

> [!IMPORTANT]
> Check details before taking any action.

> [!CAUTION]
> User is responsible for any modification and execution of any parts from this repository.

---

## ⚡ Zero Effort Approach

GitHub Actions workflow file covers all necessary activities which are fully automated in GitHub (re-using Docker container approach as base for automation):

- <span style="color: #1a7f37;">Gathering and propagating latest available tools versions to Docker preparation process</span>
- <span style="color: #0969da;">Building Docker hardened image</span>

---

## 🐳 Docker Container Approach

Docker build wrapper script covers creation of a container built from a multistage Dockerfile using parallel execution of several builders to speed up preparation. Generated image contains all mentioned tools wi>

| File | Description |
|------|-------------|
| [`Dockerfile`](Dockerfile) | <span style="color: #0969da;">Recipe for preparation of Docker container</span> |
| [`.docker`](.docker) | <span style="color: #8250df;">Directory for configuration data persistency (can be mapped into container)</span> |

### 🏗 Container Images

| Registry | Network Support | Pull Command |
|----------|----------------|--------------|
| [**DockerHub CR**](https://hub.docker.com/r/developmententity/azure-cloud-tools) | <span style="color: #1a7f37;">IPv4 & IPv6</span> | `docker pull developmententity/azure-cloud-tools:initial` |
| [**GitHub CR**](https://github.com/users/stefanbosak/packages/container/package/azure-cloud-tools) | <span style="color: #8250df;">IPv4 only</span> | `docker pull ghcr.io/stefanbosak/azure-cloud-tools:initial` |

---

<div align="center">

<span style="color: #8250df;">**Made with ❤ for ☁ Azure ecosystem and 🔒 security**</span>

</div>
