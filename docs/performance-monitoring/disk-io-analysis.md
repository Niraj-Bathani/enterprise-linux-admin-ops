# Disk I/O Analysis

## Analysis Goal

Disk I/O Analysis helps administrators distinguish a real bottleneck from normal activity. Performance work should start with user impact: what is slow, since when, for whom, and compared with what baseline? Tools such as `top`, `sar`, `iostat`, and `ss` are most useful when their output is tied to a timeline.

## First Commands

```bash
uptime
mpstat 1 5
free -h
iostat -xz 1 5
sar -n DEV 1 5
```

## Interpretation

High CPU usage is not automatically bad if throughput is healthy. Memory pressure matters when swapping, reclaim, or OOM events appear. Disk latency is often more important than raw throughput. Network problems may appear as retransmits, drops, DNS delay, or blocked ports. Compare current data to normal business hours and recent changes such as deployments, package updates, backups, or batch jobs.

## Investigation Flow

Start broad with load average, memory, disk, and network counters. Then narrow to a process, device, mount point, socket, or time window. Use `journalctl` and application logs to connect metric spikes with service behavior. Avoid tuning kernel parameters until you have evidence; many performance incidents are caused by capacity limits, application behavior, or a failing dependency rather than a missing sysctl.

## Deliverable

End with a short finding: symptom, evidence, suspected cause, mitigation, and monitoring recommendation. Good notes make later incidents faster to resolve.

## Operator Notes

Treat Disk I/O Analysis as a controlled administrative change, not as a memory exercise. Read the command, state what object it changes, run it on a disposable lab host first, and record the before and after state. Enterprise Linux work is safest when every action can be explained later from logs, shell history, and a short ticket note. When your output differs from the examples, compare release versions, service names, SELinux mode, firewall zones, and whether NetworkManager or systemd is managing the component.
