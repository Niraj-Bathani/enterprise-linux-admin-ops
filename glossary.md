# Glossary

| Term | Meaning |
|---|---|
| ACL | Access Control List, an extension to standard Unix file permissions. |
| auditd | Linux audit daemon used to record security-relevant events. |
| firewalld | Dynamic firewall manager used by RHEL compatible systems. |
| initramfs | Early boot image containing drivers and tools needed to mount root. |
| LVM | Logical Volume Manager, a flexible storage abstraction layer. |
| RAID | Redundant Array of Independent Disks, used for redundancy or performance. |
| SELinux | Mandatory access control system that confines processes and files. |
| systemd | Service manager and init system used by modern enterprise Linux. |
| runbook | Operational document that explains how to support a service. |
| RCA | Root Cause Analysis, a structured explanation of why an incident happened. |

## How To Learn Terms

Do not memorize this glossary in isolation. Connect each term to a command and a log file. For example, SELinux becomes clearer when you run `getenforce`, inspect `ls -Z`, and read an AVC denial with `ausearch`. LVM becomes concrete when you create a physical volume, volume group, and logical volume in a lab.

## Operational Vocabulary

Enterprise administrators need precise words. Say "the service is active but the port is blocked" rather than "the server is down." Say "DNS resolution fails for the internal zone" rather than "networking is broken." Clear vocabulary reduces escalation time and helps teams hand work to each other without losing context.

## Operator Notes

Treat Glossary as a controlled administrative change, not as a memory exercise. Read the command, state what object it changes, run it on a disposable lab host first, and record the before and after state. Enterprise Linux work is safest when every action can be explained later from logs, shell history, and a short ticket note. When your output differs from the examples, compare release versions, service names, SELinux mode, firewall zones, and whether NetworkManager or systemd is managing the component.
