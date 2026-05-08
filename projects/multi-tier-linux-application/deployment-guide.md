# Deployment Guide

## Project Goal

This project turns individual administration skills into an operational Linux service. The design emphasizes clear ownership, repeatable deployment, validation, backup, monitoring, and recovery. Treat the project as a miniature production environment: every service should have a purpose, an owner, a configuration file, logs, and a test that proves it works.

## Design

Use at least two virtual machines when possible: one service node and one client or supporting node. Keep hostnames predictable, document IP addresses, and use firewalld zones intentionally. Store example configuration in the repository and keep secrets out of it. For deployment guide, focus on the workflow that an operations team would support after handoff.

## Implementation Commands

```bash
pwd
ls -lah /etc
find /var/log -maxdepth 1 -type f
df -hT
du -sh /var/log/* | sort -h
```

## Validation

Validation must include service status, port checks, log review, client testing, and persistence after reboot. For web or load-balancing projects, use `curl -I` and backend log checks. For backup projects, perform an actual restore. For logging projects, send a test message and confirm it arrives with correct hostname and timestamp.

## Operations Notes

Write a short runbook with normal start, stop, reload, backup, and troubleshooting commands. Include common failure modes and where logs are stored. The project is complete when another administrator can deploy it from the guide without asking for hidden context.

## Operator Notes

Treat Deployment Guide as a controlled administrative change, not as a memory exercise. Read the command, state what object it changes, run it on a disposable lab host first, and record the before and after state. Enterprise Linux work is safest when every action can be explained later from logs, shell history, and a short ticket note. When your output differs from the examples, compare release versions, service names, SELinux mode, firewall zones, and whether NetworkManager or systemd is managing the component.
