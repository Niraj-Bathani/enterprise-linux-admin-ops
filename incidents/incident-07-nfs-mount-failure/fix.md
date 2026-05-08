# Fix

## Restoration Goal

The immediate goal was to restore service with the smallest safe change and then validate the user-visible path. The fix chosen was to correct /etc/exports, reload exportfs, and verify firewall and SELinux context.

## Commands

```bash
# Capture current state before changing it
systemctl status nfs-server --no-pager || true
journalctl -u nfs-server -b --no-pager | tail -30

# Apply the targeted correction for this incident
# Replace paths, users, devices, or addresses with the real values from the ticket.
systemctl daemon-reload || true
systemctl restart nfs-server || systemctl reload nfs-server

# Validate service and logs
systemctl is-active nfs-server
journalctl -u nfs-server -b --no-pager | tail -30
```

## Validation

The team repeated the failing user action after the service change. Logs no longer showed the original error, and monitoring returned to normal. The responder left additional observation in place for one business cycle and documented exact commands in the incident timeline.

## Operator Notes

Treat Fix as a controlled administrative change, not as a memory exercise. Read the command, state what object it changes, run it on a disposable lab host first, and record the before and after state. Enterprise Linux work is safest when every action can be explained later from logs, shell history, and a short ticket note. When your output differs from the examples, compare release versions, service names, SELinux mode, firewall zones, and whether NetworkManager or systemd is managing the component.

## Validation Habit

A good administrator validates from two directions: the local system state and the client experience. Do not only check that a daemon is active; also test the socket, review the log, and confirm that persistence survives a reboot. This habit prevents temporary fixes from being mistaken for durable operations. Keep commands readable, prefer documented configuration files, and avoid destructive shortcuts unless a backup and rollback plan are already written.
