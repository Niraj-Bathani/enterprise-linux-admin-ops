# Bonding

## Objective

In this lab you will practice bonding on a RHEL compatible virtual machine. The objective is to move beyond memorizing commands and learn how to plan the change, apply it safely, validate it, and explain the result as an administrator would in an operations handoff.

## Prerequisites

- A disposable RHEL 8, RHEL 9, Rocky, AlmaLinux, or CentOS Stream VM.
- Console access or a snapshot before storage, firewall, boot, and identity changes.
- A user with sudo privileges.
- Network connectivity and package repositories for optional tools.

## Step By Step Commands

1. Run `ip addr show` and record the output in your lab notes.
2. Run `ip route show` and record the output in your lab notes.
3. Run `nmcli device status` and record the output in your lab notes.
4. Run `nmcli connection show` and record the output in your lab notes.
5. Run `ss -tulpen` and record the output in your lab notes.

Example command sequence:

```bash
ip addr show
ip route show
nmcli device status
nmcli connection show
ss -tulpen
```

## Expected Output

Expected output varies by release and lab topology, but you should see successful exit codes and state that matches the intended change. For read-only commands, confirm that device names, service names, usernames, mount points, ports, or counters are present. For configuration commands, repeat the inspection command and look for the new persistent value rather than a temporary shell-only result.

## Validation

Validate from the local host and, when relevant, from a second client. Use `systemctl status`, `journalctl -b`, `ip route`, `ss -tulpen`, `findmnt`, or the specific command for the feature. Reboot validation is recommended for networking, storage, boot, cron, and service management labs. Record any unexpected output and explain whether it is harmless, a lab topology difference, or a real misconfiguration.

## Cleanup

Undo only the changes you made. Remove temporary users, files, mounts, firewall rules, or test services after collecting text output for your notes. If the lab involved risky disk or boot operations, revert to the VM snapshot rather than trying to manually unwind every change.

## Operator Notes

Treat Bonding as a controlled administrative change, not as a memory exercise. Read the command, state what object it changes, run it on a disposable lab host first, and record the before and after state. Enterprise Linux work is safest when every action can be explained later from logs, shell history, and a short ticket note. When your output differs from the examples, compare release versions, service names, SELinux mode, firewall zones, and whether NetworkManager or systemd is managing the component.
