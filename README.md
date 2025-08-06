# NetKit - Network Toolkit

Container image packed with network troubleshooting tools for debugging Kubernetes clusters and Docker environments.

## Quick Start

### Docker

```bash
# Run interactively
docker run -it --rm ghcr.io/self-hosters-by-night/netkit:latest

# Run with host networking for advanced troubleshooting
docker run -it --rm --net=host --privileged ghcr.io/self-hosters-by-night/netkit:latest
```

### Kubernetes

#### Quick Debug Pod

```bash
kubectl run netkit -it --rm --restart=Never --image=ghcr.io/self-hosters-by-night/netkit:latest --namespace=default
```

#### Access the Pod

```bash
kubectl exec -it ghcr.io/self-hosters-by-night/netkit:latest -- bash
```

## Building from Source

```bash
git clone https://github.com/self-hosters-by-night/netkit.git
cd netkit
docker build -t ghcr.io/self-hosters-by-night/netkit:latest .
```

## Included Commands

### Network Analysis & Monitoring

- **bmon** - Bandwidth monitor with real-time interface statistics
- **iftop** - Real-time network bandwidth usage per connection
- **iotop** - Monitor I/O usage by processes
- **mtr-tiny** - Network diagnostic tool combining ping and traceroute
- **ngrep** - Network packet analyzer with grep-like pattern matching
- **tcpdump** - Packet capture and analysis tool
- **tshark** - Command-line network protocol analyzer (Wireshark CLI)

### Network Utilities

- **bridge-utils** - Ethernet bridge administration tools
- **curl** - Transfer data from/to servers (HTTP, FTP, etc.)
- **dnsutils** - DNS lookup utilities (dig, nslookup, host)
- **ethtool** - Display/change ethernet device settings
- **httpie** - Modern HTTP client with intuitive syntax
- **iproute2** - Advanced IP routing utilities (ip, ss commands)
- **net-tools** - Basic networking tools (ifconfig, netstat, route)

### Network Testing & Performance

- **iperf3** - Network bandwidth measurement tool
- **wrk** - HTTP benchmarking tool
- **netcat-openbsd** - Network connection utility for reading/writing data
- **socat** - Multipurpose relay tool for bidirectional data transfer

### IP & Network Calculation

- **ipcalc-ng** - IP address calculator and subnet planner
- **iputils-arping** - Send ARP requests to network hosts
- **iputils-ping** - Send ICMP echo requests (ping)
- **iputils-tracepath** - Trace network path to destination

### Network Discovery & Security

- **nmap** - Network discovery and security auditing tool
- **traceroute** - Trace network route to destination
- **tcptraceroute** - Traceroute using TCP packets

### Remote Access & Communication

- **openssh-client** - SSH client for secure remote connections
- **telnet** - Basic network protocol client
- **whois** - Query domain registration information

### System Monitoring

- **htop** - Interactive process viewer
- **lsof** - List open files and network connections
- **sysstat** - System performance monitoring tools

### LDAP & Directory Services

- **ldap-utils** - LDAP client utilities for directory operations

### File Operations & Downloads

- **aria2** - Multi-protocol download utility
- **wget** - Non-interactive network downloader
- **unzip/zip** - Archive compression/decompression tools

### Text Processing & Development

- **jq** - Command-line JSON processor
- **yq** - Command-line YAML processor
- **less** - Text file pager
- **nano/vim** - Text editors
- **tree** - Display directory structure in tree format

### Session Management

- **screen** - Terminal multiplexer for persistent sessions
- **tmux** - Advanced terminal multiplexer

### Kubernetes Integration

- **kubectl** - Kubernetes command-line tool
- **location** - IP geolocation lookup tool

### Security Features

- Non-root user `netkit` with sudo access to privileged network tools
- Minimal attack surface with slim Debian base
- Pre-configured kubectl aliases for faster Kubernetes operations

## Common Use Cases

### DNS Troubleshooting

```bash
# Test DNS resolution
dig google.com
```

### Network Connectivity

```bash
# Test connectivity
ping 8.8.8.8
traceroute google.com
mtr --report-cycles 10 8.8.8.8

# Port scanning
nmap -p 80,443 google.com
```

### Performance Testing

```bash
# Network performance (requires iperf3 server)
iperf3 -c <server-ip>
```

### Packet Analysis

```bash
# Capture packets
tcpdump -i any -n host 8.8.8.8

# With tshark
tshark -i any -n -f "host 8.8.8.8"
```

### Service Discovery

```bash
dig SRV _https._tcp.kubernetes.default.svc.cluster.local
```

## Contributing

Feel free to submit issues and pull requests to improve this toolset.
