# Initial Network Config

## Scope

This setup guide prepares a controlled enterprise Linux lab. The recommended environment is two or more virtual machines: one administration workstation, one server under test, and optional client nodes for network, NFS, SSH, and web service exercises. Keep snapshots before major storage, firewall, boot, or identity changes. Use RHEL 8 or RHEL 9 when possible; compatible rebuilds are acceptable for practice if subscription management commands are adjusted.

## Planning Checklist

| Item | Recommendation |
|---|---|
| CPU and memory | 2 vCPU and 4 GB RAM per VM for normal labs |
| Disk | 40 GB system disk plus optional extra virtual disks |
| Network | One NAT adapter for internet, one host-only lab network |
| Access | Console access plus SSH after hardening is validated |
| Snapshots | Take a clean baseline after package updates |

## Procedure

```bash
ip addr show
ip route show
nmcli device status
nmcli connection show
ss -tulpen
```

Start with a minimal install plus standard administration tools. Configure a predictable hostname, confirm DNS resolution, update packages, and enable only the services required for the current module. Document IP addresses, interface names, disk names, and credentials in a private lab note rather than in the repository.

## Verification

Confirm that `systemctl is-system-running` reports a healthy or degraded state you understand. Check `ip addr`, `ip route`, `timedatectl`, `dnf repolist`, and `getenforce`. A setup is not complete until you can reboot, reconnect, install a package, and resolve names from both the server and client perspectives.

## Operator Notes

Treat Initial Network Config as a controlled administrative change, not as a memory exercise. Read the command, state what object it changes, run it on a disposable lab host first, and record the before and after state. Enterprise Linux work is safest when every action can be explained later from logs, shell history, and a short ticket note. When your output differs from the examples, compare release versions, service names, SELinux mode, firewall zones, and whether NetworkManager or systemd is managing the component.
