# VMware Enterprise Linux Lab Network Topology

Import the following Mermaid diagram into draw.io.

```mermaid
graph TD

    INTERNET[Internet Access]

    subgraph VMWARE_HOST[VMware Workstation Host]
        VMNET8[VMnet8 NAT Network\n192.168.100.0/24]

        LB01[LB01\nHAProxy Load Balancer\n192.168.100.30]

        WEB01[WEB01\nApache/PHP Server\n192.168.100.20]

        WEB02[WEB02\nApache/PHP Server\n192.168.100.21]

        NFS01[NFS01\nNFS Storage Server\n192.168.100.40]

        CLIENT01[CLIENT01\nLinux Admin Workstation\n192.168.100.50]
    end

    INTERNET --> VMNET8

    VMNET8 --> LB01
    VMNET8 --> WEB01
    VMNET8 --> WEB02
    VMNET8 --> NFS01
    VMNET8 --> CLIENT01

    LB01 --> WEB01
    LB01 --> WEB02

    WEB01 --> NFS01
    WEB02 --> NFS01
```

Recommended draw.io styling:

- Use dark enterprise theme
- Use blue for infrastructure servers
- Use orange for HAProxy node
- Use green for client workstation
- Use directional arrows for traffic flow
- Add title:
  VMware Enterprise Linux Infrastructure Lab

Infrastructure Notes:

- Hypervisor:
  VMware Workstation

- Network Type:
  NAT (VMnet8)

- Linux Distribution:
  Red Hat Enterprise Linux 9.6

- Core Services:
  - HAProxy
  - Apache HTTP Server
  - NFS Shared Storage

Operational Workflow:

- CLIENT01 validates infrastructure access
- LB01 distributes traffic to backend servers
- WEB01 and WEB02 host applications
- NFS01 provides centralized storage

Administrative Validation Commands:

```bash
ip addr
ping 192.168.100.30
ss -tulpn
systemctl status haproxy
showmount -e 192.168.100.40
```

Screenshot Reference:

![VMware Enterprise Linux Lab Topology](../screenshots/vmware-linux-lab-topology.png)
