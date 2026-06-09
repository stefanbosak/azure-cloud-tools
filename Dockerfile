# user in container
ARG CONTAINER_USER=user
ARG CONTAINER_GROUP=user

ARG CONTAINER_USER_ID=1000
ARG CONTAINER_GROUP_ID=1000

# set location of workspace directory
# (temporary space within container image)
ARG WORKSPACE_ROOT_DIR="/home/${CONTAINER_USER}"

# Debian release and options
ARG DEBIAN_RELEASE=trixie-debian13-dev
ARG DEBIAN_FRONTEND=noninteractive

# ansible CLI tools versions
ARG ANSIBLE_CLI_VERSION=v2.21.0

# Helm version
ARG HELM_CLI_VERSION=v4.2.0

# kubectl version
ARG K9S_CLI_VERSION=v0.50.18

# kops version
ARG KOPS_CLI_VERSION=v1.36.0-alpha.1

# kubectl version
ARG KUBECTL_CLI_VERSION=v1.36.1

# Terraform version
ARG TERRAFORM_CLI_VERSION=1.15.5

# Terragrunt version
ARG TERRAGRUNT_CLI_VERSION=v1.0.6

# Azure CLI version
ARG AZURE_CLI_VERSION=2.86.0

# cert-manager CLI version
ARG CM_CTL_CLI_VERSION=v2.5.0

# container as builder for preparing Azure cloud tools
FROM dhi.io/debian-base:${DEBIAN_RELEASE} AS azure-cloud-tools-builder

LABEL stage="azure-cloud-tools-builder" \
      description="Debian-based container builder for preparing Azure cloud tools" \
      org.opencontainers.image.description="Debian-based container builder for preparing Azure cloud tools" \
      org.opencontainers.image.url=https://github.com/stefanbosak/azure-cloud-tools \
      org.opencontainers.image.source=https://github.com/stefanbosak/azure-cloud-tools

ARG DEBIAN_FRONTEND

ARG WORKSPACE_ROOT_DIR
WORKDIR "${WORKSPACE_ROOT_DIR}"

# install required packages and additional applications
RUN apt-get update && \
    apt-get -y --no-install-recommends install ca-certificates binutils curl unzip && \
    apt-get clean && rm -rf "/var/lib/apt/lists/*"

# container as builder for preparing Azure cloud tools
FROM azure-cloud-tools-builder AS azure-cloud-tools-ansible-cli-builder

LABEL stage="azure-cloud-tools-ansible-cli-builder" \
      description="Debian-based container builder for preparing Azure cloud tool ansible" \
      org.opencontainers.image.description="Debian-based container builder for preparing Azure cloud tool ansible" \
      org.opencontainers.image.url=https://github.com/stefanbosak/azure-cloud-tools \
      org.opencontainers.image.source=https://github.com/stefanbosak/azure-cloud-tools

ARG TARGETOS
ARG TARGETARCH
ARG ANSIBLE_CLI_VERSION

ARG WORKSPACE_ROOT_DIR
WORKDIR "${WORKSPACE_ROOT_DIR}"

# download and install ansible tool
RUN apt-get -y --no-install-recommends install python3-pip && \
    apt-get clean && rm -rf "/var/lib/apt/lists/*"
RUN python3 -m pip install --break-system-packages  "https://github.com/ansible/ansible/archive/refs/tags/${ANSIBLE_CLI_VERSION}.tar.gz"
    
# container as builder for preparing Azure cloud tools
FROM azure-cloud-tools-builder AS azure-cloud-tools-helm-builder

LABEL stage="azure-cloud-tools-helm-builder" \
      description="Debian-based container builder for preparing Azure cloud tool HELM CLI" \
      org.opencontainers.image.description="Debian-based container builder for preparing Azure cloud tool HELM CLI" \
      org.opencontainers.image.url=https://github.com/stefanbosak/azure-cloud-tools \
      org.opencontainers.image.source=https://github.com/stefanbosak/azure-cloud-tools

ARG TARGETOS
ARG TARGETARCH
ARG HELM_CLI_VERSION

ARG WORKSPACE_ROOT_DIR
WORKDIR "${WORKSPACE_ROOT_DIR}"

# download HELM archive file
ADD "https://get.helm.sh/helm-${HELM_CLI_VERSION}-${TARGETOS}-${TARGETARCH}.tar.gz" "${WORKSPACE_ROOT_DIR}/"

# install HELM
RUN mkdir -p "/usr/local/bin/" && mkdir -v "${WORKSPACE_ROOT_DIR}/helm" && tar -zxf "helm-${HELM_CLI_VERSION}-${TARGETOS}-${TARGETARCH}.tar.gz" -C "/usr/local/bin" --strip-components 1 --no-anchored "helm"


# container as builder for preparing Azure cloud tools
FROM azure-cloud-tools-builder AS azure-cloud-tools-kops-builder

LABEL stage="azure-cloud-tools-kops-builder" \
      description="Debian-based container builder for preparing Azure cloud tool kops CLI" \
      org.opencontainers.image.description="Debian-based container builder for preparing Azure cloud tool kops CLI" \
      org.opencontainers.image.url=https://github.com/stefanbosak/azure-cloud-tools \
      org.opencontainers.image.source=https://github.com/stefanbosak/azure-cloud-tools

ARG TARGETOS
ARG TARGETARCH
ARG KOPS_CLI_VERSION

ARG WORKSPACE_ROOT_DIR
WORKDIR "${WORKSPACE_ROOT_DIR}"

# download kubectl CLI binary file
ADD "https://github.com/kubernetes/kops/releases/download/${KOPS_CLI_VERSION}/kops-${TARGETOS}-${TARGETARCH}" "${WORKSPACE_ROOT_DIR}/"

# install kubectl
RUN mkdir -p "/usr/local/bin/" && install -v -o root -g root -m 0755 "${WORKSPACE_ROOT_DIR}/kops-${TARGETOS}-${TARGETARCH}" "/usr/local/bin/kops"


# container as builder for preparing Azure cloud tools
FROM azure-cloud-tools-builder AS azure-cloud-tools-kubectl-builder

LABEL stage="azure-cloud-tools-kubectl-builder" \
      description="Debian-based container builder for preparing Azure cloud tool kubectl CLI" \
      org.opencontainers.image.description="Debian-based container builder for preparing Azure cloud tool kubectl CLI" \
      org.opencontainers.image.url=https://github.com/stefanbosak/azure-cloud-tools \
      org.opencontainers.image.source=https://github.com/stefanbosak/azure-cloud-tools

ARG TARGETOS
ARG TARGETARCH
ARG KUBECTL_CLI_VERSION

ARG WORKSPACE_ROOT_DIR
WORKDIR "${WORKSPACE_ROOT_DIR}"

# download kubectl CLI binary file
ADD "https://dl.k8s.io/release/${KUBECTL_CLI_VERSION}/bin/linux/${TARGETARCH}/kubectl" "${WORKSPACE_ROOT_DIR}/"

# install kubectl
RUN mkdir -p "/usr/local/bin/" && install -v -o root -g root -m 0755 "${WORKSPACE_ROOT_DIR}/kubectl" "/usr/local/bin/"


# container as builder for preparing Azure cloud tools
FROM azure-cloud-tools-builder AS azure-cloud-tools-k9s-builder

LABEL stage="azure-cloud-tools-k9s-builder" \
      description="Debian-based container builder for preparing Azure cloud tool k9s CLI" \
      org.opencontainers.image.description="Debian-based container builder for preparing Azure cloud tool k9s CLI" \
      org.opencontainers.image.url=https://github.com/stefanbosak/azure-cloud-tools \
      org.opencontainers.image.source=https://github.com/stefanbosak/azure-cloud-tools

ARG TARGETOS
ARG TARGETARCH
ARG K9S_CLI_VERSION

ARG WORKSPACE_ROOT_DIR
WORKDIR "${WORKSPACE_ROOT_DIR}"

# download k9s CLI binary file
ADD "https://github.com/derailed/k9s/releases/download/${K9S_CLI_VERSION}/k9s_Linux_${TARGETARCH}.tar.gz" "${WORKSPACE_ROOT_DIR}/"

# install k9s
RUN mkdir -p "/usr/local/bin/" && tar -zxf "k9s_Linux_${TARGETARCH}.tar.gz" -C "/usr/local/bin" --no-anchored "k9s"

# container as builder for preparing Azure cloud tools
FROM azure-cloud-tools-builder AS azure-cloud-tools-terraform-builder

LABEL stage="azure-cloud-tools-terraform-builder" \
      description="Debian-based container builder for preparing Azure cloud tool terraform" \
      org.opencontainers.image.description="Debian-based container builder for preparing Azure cloud tool terraform" \
      org.opencontainers.image.url=https://github.com/stefanbosak/azure-cloud-tools \
      org.opencontainers.image.source=https://github.com/stefanbosak/azure-cloud-tools

ARG TARGETOS
ARG TARGETARCH
ARG TERRAFORM_CLI_VERSION

ARG WORKSPACE_ROOT_DIR
WORKDIR "${WORKSPACE_ROOT_DIR}"

# download TF CLI archive file
ADD "https://releases.hashicorp.com/terraform/${TERRAFORM_CLI_VERSION}/terraform_${TERRAFORM_CLI_VERSION}_${TARGETOS}_${TARGETARCH}.zip" "${WORKSPACE_ROOT_DIR}/"

# install TF CLI binary
RUN mkdir -p "/usr/local/bin/" && unzip "terraform_${TERRAFORM_CLI_VERSION}_${TARGETOS}_${TARGETARCH}.zip" -d "/usr/local/bin/"


# container as builder for preparing Azure cloud tools
FROM azure-cloud-tools-builder AS azure-cloud-tools-terragrunt-builder

LABEL stage="azure-cloud-tools-kubectl-builder" \
      description="Debian-based container builder for preparing Azure cloud tool terragrunt CLI" \
      org.opencontainers.image.description="Debian-based container builder for preparing Azure cloud tool terragrunt CLI" \
      org.opencontainers.image.url=https://github.com/stefanbosak/azure-cloud-tools \
      org.opencontainers.image.source=https://github.com/stefanbosak/azure-cloud-tools

ARG TARGETOS
ARG TARGETARCH
ARG TERRAGRUNT_CLI_VERSION

ARG WORKSPACE_ROOT_DIR
WORKDIR "${WORKSPACE_ROOT_DIR}"

# download kubectl CLI binary file
ADD "https://github.com/gruntwork-io/terragrunt/releases/download/${TERRAGRUNT_CLI_VERSION}/terragrunt_${TARGETOS}_${TARGETARCH}" "${WORKSPACE_ROOT_DIR}/"

# install terragrunt CLI
RUN mkdir -p "/usr/local/bin/" && install -v -o root -g root -m 0755 "${WORKSPACE_ROOT_DIR}/terragrunt_${TARGETOS}_${TARGETARCH}" "/usr/local/bin/terragrunt"


# container as final image for providing Azure cloud tools
FROM dhi.io/debian-base:${DEBIAN_RELEASE} AS azure-cloud-tools-image

LABEL stage="azure-cloud-tools-image" \
      description="Debian-based container with Azure cloud tools" \
      org.opencontainers.image.description="Debian-based container with Azure cloud tools" \
      org.opencontainers.image.url=https://github.com/stefanbosak/azure-cloud-tools \
      org.opencontainers.image.source=https://github.com/stefanbosak/azure-cloud-tools

ARG TARGETOS
ARG TARGETARCH

# user in container
ARG CONTAINER_USER
ARG CONTAINER_GROUP

ARG CONTAINER_USER_ID
ARG CONTAINER_GROUP_ID

ARG WORKSPACE_ROOT_DIR
WORKDIR "${WORKSPACE_ROOT_DIR}"

ARG AZURE_CLI_VERSION

ARG CM_CTL_CLI_VERSION

ARG DEBIAN_FRONTEND

RUN mkdir -p "/usr/local/bin/" && \
    apt-get update \
    && apt-get install -y --no-install-recommends \
      bash \
      bash-completion \
      bc \
      ca-certificates \
      curl \
      dnsutils \
      git \
      gnupg \
      gzip \
      iproute2 \
      iputils-ping \
      jq \
      kmod \
      lsof \
      openssh-client \
      pigz \
      procps \
      psmisc \
      python3-venv \
      python3-argcomplete \
      ripgrep \
      rsync \
      socat \
      unzip \
      wget \
      whois \
    && apt-get clean \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

# transfer tools from builders
COPY --from=azure-cloud-tools-ansible-cli-builder "/usr/local/bin" "/usr/local/bin"
COPY --from=azure-cloud-tools-ansible-cli-builder "/usr/local/lib/" "/usr/local/lib"
COPY --from=azure-cloud-tools-helm-builder "/usr/local/bin/" "/usr/local/bin/"
COPY --from=azure-cloud-tools-kops-builder "/usr/local/bin/" "/usr/local/bin/"
COPY --from=azure-cloud-tools-kubectl-builder "/usr/local/bin/" "/usr/local/bin/"
COPY --from=azure-cloud-tools-k9s-builder "/usr/local/bin/" "/usr/local/bin/"
COPY --from=azure-cloud-tools-terraform-builder "/usr/local/bin/" "/usr/local/bin/"
COPY --from=azure-cloud-tools-terragrunt-builder "/usr/local/bin/" "/usr/local/bin/"

ADD "https://github.com/cert-manager/cmctl/releases/download/${CM_CTL_CLI_VERSION}/cmctl_linux_${TARGETARCH}" "/usr/local/bin/kubectl-cert_manager"

RUN if getent group "${CONTAINER_GROUP_ID}" > /dev/null; then \
      _existing_group="$(getent group "${CONTAINER_GROUP_ID}" | cut -d: -f1)"; \
      if [ "${_existing_group}" != "${CONTAINER_GROUP}" ]; then \
        groupmod -n "${CONTAINER_GROUP}" "${_existing_group}"; \
      fi; \
    else \
      groupadd --gid "${CONTAINER_GROUP_ID}" "${CONTAINER_GROUP}"; \
    fi \
    && if getent passwd "${CONTAINER_USER_ID}" > /dev/null; then \
         _existing_user="$(getent passwd "${CONTAINER_USER_ID}" | cut -d: -f1)"; \
         if [ "${_existing_user}" != "${CONTAINER_USER}" ]; then \
           if [ -d "/home/${_existing_user}" ]; then \
             mv "/home/${_existing_user}" "/home/${CONTAINER_USER}"; \
           fi; \
           usermod -d "/home/${CONTAINER_USER}" -l "${CONTAINER_USER}" "${_existing_user}"; \
         fi; \
       else \
         useradd \
           --uid "${CONTAINER_USER_ID}" \
           --gid "${CONTAINER_GROUP_ID}" \
           --groups "${CONTAINER_GROUP}" \
           -M -d "${WORKSPACE_ROOT_DIR}" \
           -s /bin/bash \
           "${CONTAINER_USER}"; \
       fi \
    && chown -R "${CONTAINER_USER}:${CONTAINER_GROUP}" "${WORKSPACE_ROOT_DIR}" && \
# enable tools completions (not required to run any tool)
    cp "/etc/skel/.bashrc" "/root" && \
    cp "/etc/skel/.bashrc" "${WORKSPACE_ROOT_DIR}" && \
    cp "/etc/skel/.profile" "${WORKSPACE_ROOT_DIR}" && \
    echo "complete -C terraform terraform" > "/usr/share/bash-completion/completions/terraform" && \
    echo "complete -C terragrunt terragrunt" > "/usr/share/bash-completion/completions/terragrunt" && \
# install azure CLI tooling
    echo "deb [signed-by=/usr/share/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/azure-cli/ bookworm main" | \
    tee -a /etc/apt/sources.list.d/azure-cli.list && \
    curl -sLS https://packages.microsoft.com/keys/microsoft.asc | \
    gpg --dearmor -o /usr/share/keyrings/microsoft.gpg && \
    apt-get update && apt-get install azure-cli=${AZURE_CLI_VERSION}-1~bookworm && \
# enable tools completions (required to run given tool to generate completion file content)
    helm completion bash > "/usr/share/bash-completion/completions/helm" && \
    kops completion bash > "/usr/share/bash-completion/completions/kops" && \
    kubectl completion bash > "/usr/share/bash-completion/completions/kubectl" && \
    cp "/usr/share/bash-completion/completions/kubectl" "/usr/share/bash-completion/completions/k" && \
    sed -i 's/kubectl/k/g' "/usr/share/bash-completion/completions/k" && \
    ln -s /usr/local/bin/kubectl /usr/local/bin/k && \
    k9s completion bash > "/usr/share/bash-completion/completions/k9s" && \
    activate-global-python-argcomplete && \
# DiD (Docker in Docker)
# - DinD via QEMU on ARM64 is not supported
#   (ARM64 requires ARM64 kernel from host system which is not present on AMD64 host)
    curl -fsSL https://test.docker.com | sh && \
    if ! getent group docker > /dev/null 2>&1; then \
      groupadd docker; \
    fi && \
    usermod -aG docker "${CONTAINER_USER}" && \
# install kubectl CNPG plugin
    curl -sSfL https://github.com/cloudnative-pg/cloudnative-pg/raw/main/hack/install-cnpg-plugin.sh | \
    sh -s -- -b /usr/local/bin && \
    ln -s /usr/local/bin/kubectl-cnpg /usr/local/bin/cnpgctl && \
    cnpgctl completion bash > /usr/share/bash-completion/completions/cnpgctl && \
    sed -i 's/kubectl-cnpg/cnpgctl/g' /usr/share/bash-completion/completions/cnpgctl && \
# install kubectl cert-manager plugin
    chmod a+x /usr/local/bin/kubectl-cert_manager && \
    ln -s /usr/local/bin/kubectl-cert_manager /usr/local/bin/cmctl && \
    cmctl completion bash > /usr/share/bash-completion/completions/cmctl

# user home directory as workdir
WORKDIR "${WORKSPACE_ROOT_DIR}"

# container user and group
USER "${CONTAINER_USER}:${CONTAINER_GROUP}"

# open shell
CMD ["bash"]
