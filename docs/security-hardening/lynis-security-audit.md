# Lynis Security Audit

## Security Goal

Lynis Security Audit reduces the attack surface or improves detection on enterprise Linux systems. Hardening should be measured, documented, and reversible. A server that is locked down without operational understanding can become fragile, so pair every restriction with a validation test and a recovery path.

## Baseline Checks

```bash
getenforce
ausearch -m AVC -ts recent
semanage port -l | grep ssh
auditctl -s
lynis audit system
```

Check the current package version, service state, configuration file, SELinux mode, firewall exposure, and logs. On RHEL compatible systems, security features often work together: SSH policy may be correct while firewalld blocks the port, or a daemon may be listening while SELinux prevents file access.

## Implementation Notes

Apply one control at a time. For SSH, test a second login before closing the current session. For auditd, confirm rules are loaded and searchable. For log rotation, force a test rotation against noncritical logs. For central logging, send a `logger` message and confirm it arrives with the expected hostname and facility.

## Validation And Maintenance

Security controls drift as packages, users, and applications change. Schedule periodic reviews with `journalctl`, `ausearch`, `firewall-cmd`, and configuration management reports. Record exceptions with owner, date, reason, and expiration. The best hardening standard is one that future administrators can understand quickly during an outage.

## Operator Notes

Treat Lynis Security Audit as a controlled administrative change, not as a memory exercise. Read the command, state what object it changes, run it on a disposable lab host first, and record the before and after state. Enterprise Linux work is safest when every action can be explained later from logs, shell history, and a short ticket note. When your output differs from the examples, compare release versions, service names, SELinux mode, firewall zones, and whether NetworkManager or systemd is managing the component.
