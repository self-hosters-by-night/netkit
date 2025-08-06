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

#### Deploy Pod

```bash
kubectl apply -f k8s/pod.yaml
```

#### Access the Pod

```bash
kubectl exec -it netkit -- bash
```

## Building from Source

```bash
git clone https://github.com/self-hosters-by-night/netkit.git
cd netkit
docker build -t ghcr.io/self-hosters-by-night/netkit:latest .
```

## Included Tools

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
- **netstress** - Network stress testing tool

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
- **mosquitto-clients** - MQTT client tools (mosquitto_pub, mosquitto_sub)

### System Monitoring

- **htop** - Interactive process viewer
- **lsof** - List open files and network connections
- **sysstat** - System performance monitoring tools

### Directory Services

- **ldap-utils** - LDAP client utilities for directory operations

### File Operations & Downloads

- **aria2** - Multi-protocol download utility
- **wget** - Non-interactive network downloader
- **unzip/zip** - Archive compression/decompression tools
- **nfs-common** - NFS client utilities

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

## Security Features

- Non-root user `netkit` with sudo access to privileged network tools
- Minimal attack surface with slim Debian base
- Kubernetes pod runs with restricted security context
- Only essential network capabilities (NET_RAW, NET_ADMIN) when needed

## Common Use Cases

### DNS Troubleshooting

```bash
# Test DNS resolution
dig google.com
nslookup kubernetes.default.svc.cluster.local
host _https._tcp.kubernetes.default.svc.cluster.local
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

# HTTP benchmarking
wrk -t12 -c400 -d30s http://example.com/
```

### Packet Analysis

```bash
# Capture packets
sudo tcpdump -i any -n host 8.8.8.8

# With tshark
sudo tshark -i any -n -f "host 8.8.8.8"

# Network grep
sudo ngrep -d any "GET" tcp port 80
```

### Service Discovery

```bash
# Kubernetes service discovery
dig SRV _https._tcp.kubernetes.default.svc.cluster.local

# LDAP queries
ldapsearch -x -H ldap://ldap.example.com -b "dc=example,dc=com"
```

### MQTT Testing

```bash
# Subscribe to MQTT topic
mosquitto_sub -h mqtt.example.com -t "sensor/temperature"

# Publish MQTT message
mosquitto_pub -h mqtt.example.com -t "sensor/temperature" -m "23.5"
```

## Contributing

Feel free to submit issues and pull requests to improve this toolset.
