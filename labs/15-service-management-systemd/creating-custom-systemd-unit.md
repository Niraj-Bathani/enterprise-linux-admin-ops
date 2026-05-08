# Creating Custom systemd Unit

## Objective

In this lab you will practice creating custom systemd unit on a RHEL compatible virtual machine. The objective is to move beyond memorizing commands and learn how to plan the change, apply it safely, validate it, and explain the result as an administrator would in an operations handoff.

## Prerequisites

- A disposable RHEL 8, RHEL 9, Rocky, AlmaLinux, or CentOS Stream VM.
- Console access or a snapshot before storage, firewall, boot, and identity changes.
- A user with sudo privileges.
- Network connectivity and package repositories for optional tools.

## Step By Step Commands

1. Run `systemctl status sshd` and record the output in your lab notes.
2. Run `systemctl enable --now firewalld` and record the output in your lab notes.
3. Run `journalctl -u sshd -b` and record the output in your lab notes.
4. Run `systemctl list-units --failed` and record the output in your lab notes.
5. Run `systemctl cat sshd` and record the output in your lab notes.

Example command sequence:

```bash
systemctl status sshd
systemctl enable --now firewalld
journalctl -u sshd -b
systemctl list-units --failed
systemctl cat sshd
```

## Expected Output

Expected output varies by release and lab topology, but you should see successful exit codes and state that matches the intended change. For read-only commands, confirm that device names, service names, usernames, mount points, ports, or counters are present. For configuration commands, repeat the inspection command and look for the new persistent value rather than a temporary shell-only result.

## Validation

Validate from the local host and, when relevant, from a second client. Use `systemctl status`, `journalctl -b`, `ip route`, `ss -tulpen`, `findmnt`, or the specific command for the feature. Reboot validation is recommended for networking, storage, boot, cron, and service management labs. Record any unexpected output and explain whether it is harmless, a lab topology difference, or a real misconfiguration.

## Cleanup

Undo only the changes you made. Remove temporary users, files, mounts, firewall rules, or test services after collecting text output for your notes. If the lab involved risky disk or boot operations, revert to the VM snapshot rather than trying to manually unwind every change.

## Operator Notes

Treat Creating Custom systemd Unit as a controlled administrative change, not as a memory exercise. Read the command, state what object it changes, run it on a disposable lab host first, and record the before and after state. Enterprise Linux work is safest when every action can be explained later from logs, shell history, and a short ticket note. When your output differs from the examples, compare release versions, service names, SELinux mode, firewall zones, and whether NetworkManager or systemd is managing the component.
