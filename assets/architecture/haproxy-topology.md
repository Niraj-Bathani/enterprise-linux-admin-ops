# HAProxy Load Balancer Topology

Import the following Mermaid diagram into draw.io.

graph TD

    INTERNET[Internet / Client Requests]

    subgraph LOAD_BALANCER_LAYER[HAProxy Load Balancer Layer]
        LB01[LB01\nHAProxy Server\n192.168.100.30]
    end

    subgraph WEB_SERVER_POOL[Backend Apache Web Servers]
        WEB01[WEB01\nApache/PHP\n192.168.100.20]
        WEB02[WEB02\nApache/PHP\n192.168.100.21]
    end

    subgraph STORAGE_LAYER[Shared Storage]
        NFS01[NFS01\nNFS Storage Server\n192.168.100.40]
    end

    INTERNET --> LB01

    LB01 --> WEB01
    LB01 --> WEB02

    WEB01 --> NFS01
    WEB02 --> NFS01
```

Recommended draw.io styling:

- Use dark enterprise theme
- Use orange color for HAProxy node
- Use blue color for web servers
- Use green color for storage server
- Use directional arrows for traffic flow
- Add title:
  Enterprise HAProxy Infrastructure Topology

Operational Notes:

- HAProxy frontend listens on:
  - Port 80
  - Port 443

- Load balancing algorithm:
  - roundrobin

- Backend services:
  - Apache HTTP Server
  - PHP application hosting

- Shared storage provided by:
  - NFS server

Validation Commands:

```bash
systemctl status haproxy
haproxy -c -f /etc/haproxy/haproxy.cfg
curl http://192.168.100.30
ss -tulpn | grep haproxy
```
---

Screenshot Reference:

![HAProxy Backend Validation](../screenshots/haproxy-backend-validation.png)


