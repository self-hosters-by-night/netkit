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
