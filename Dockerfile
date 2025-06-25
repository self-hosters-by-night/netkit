FROM debian:12-slim

LABEL maintainer="Federico A. Corazza <git@facorazza.com>"
LABEL description="Network troubleshooting toolkit for Kubernetes and Docker environments"

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        aria2 \
        bmon \
        bridge-utils \
        ca-certificates \
        curl \
        dnsutils \
        ethtool \
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
        mtr-tiny \
        nano \
        net-tools \
        ngrep \
        nmap \
        netcat-openbsd \
        openssh-client \
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

RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
    chmod +x kubectl && \
    mv kubectl /usr/local/bin/

RUN useradd -m -s /bin/bash netkit && \
    echo "netkit ALL=(ALL) NOPASSWD: /usr/bin/arping, /usr/bin/bmon, /usr/sbin/ethtool, /usr/bin/iftop, /usr/bin/iotop, /bin/ip, /usr/bin/nmap, /bin/nsenter, /usr/bin/socat, /usr/sbin/ss, /usr/bin/tcpdump, /usr/bin/tshark" >> /etc/sudoers

WORKDIR /home/netkit

USER netkit

CMD ["/bin/bash"]
