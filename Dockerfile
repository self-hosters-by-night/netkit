FROM debian:13-slim

LABEL maintainer="Federico A. Corazza <git@facorazza.com>"
LABEL description="Network troubleshooting toolkit for Kubernetes and Docker environments"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        aria2 \
        bmon \
        bridge-utils \
        ca-certificates \
        curl \
        dnsutils \
        ethtool \
        gnupg \
        htop \
        httpie \
        iftop \
        iotop \
        ipcalc-ng \
        iperf3 \
        iproute2 \
        iputils-arping \
        iputils-ping \
        iputils-tracepath \
        jq \
        ldap-utils \
        less \
        location \
        lsof \
        mosquitto-clients \
        mtr-tiny \
        mariadb-client-compat \
        nano \
        net-tools \
        netcat-openbsd \
        netstress \
        ngrep \
        nmap \
        nfs-common \
        openssh-client \
        postgresql-client \
        screen \
        socat \
        sysstat \
        tcpdump \
        tcptraceroute \
        telnet \
        tmux \
        traceroute \
        tree \
        tshark \
        unzip \
        vim \
        wget \
        whois \
        wrk \
        yq \
        zip \
        && \
    rm -rf /var/lib/apt/lists/*

# Install etcd
RUN ETCD_VER=v3.6.7 && \
    DOWNLOAD_URL=https://storage.googleapis.com/etcd && \
    curl -L ${DOWNLOAD_URL}/${ETCD_VER}/etcd-${ETCD_VER}-linux-amd64.tar.gz -o /tmp/etcd-${ETCD_VER}-linux-amd64.tar.gz && \
    mkdir -p /tmp/etcd && \
    tar xzvf /tmp/etcd-${ETCD_VER}-linux-amd64.tar.gz -C /tmp/etcd --strip-components=1 --no-same-owner && \
    rm -f /tmp/etcd-${ETCD_VER}-linux-amd64.tar.gz && \
    mv /tmp/etcd/etcd /usr/local/bin && \
    mv /tmp/etcd/etcdctl /usr/local/bin && \
    mv /tmp/etcd/etcdutl /usr/local/bin

# Install kubectl
RUN KUBECTL_VERSION=$(curl -L -s https://dl.k8s.io/release/stable.txt) && \
    curl -LO "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl" && \
    curl -LO "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl.sha256" && \
    echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check && \
    rm kubectl.sha256 && \
    chmod +x kubectl && \
    mv kubectl /usr/local/bin/kubectl
RUN kubectl version --client

# Install MongoDB shell
RUN curl -fsSL https://www.mongodb.org/static/pgp/server-8.0.asc | \
    gpg -o /usr/share/keyrings/mongodb-server-8.0.gpg --dearmor
RUN echo "deb [ signed-by=/usr/share/keyrings/mongodb-server-8.0.gpg ] https://repo.mongodb.org/apt/debian bookworm/mongodb-org/8.0 main" | tee /etc/apt/sources.list.d/mongodb-org-8.0.list
RUN apt-get update && \
    apt-get install -y \
    mongodb-mongosh && \
    rm -rf /var/lib/apt/lists/*
RUN mongosh --version

RUN useradd -m -s /bin/bash netkit && \
    echo "netkit ALL=(ALL) NOPASSWD: /usr/bin/arping, /usr/bin/bmon, /usr/sbin/ethtool, /usr/bin/iftop, /usr/bin/iotop, /bin/ip, /usr/bin/nmap, /bin/nsenter, /usr/bin/socat, /usr/sbin/ss, /usr/bin/tcpdump, /usr/bin/tshark" >> /etc/sudoers

WORKDIR /home/netkit

USER netkit

CMD ["/bin/bash"]
