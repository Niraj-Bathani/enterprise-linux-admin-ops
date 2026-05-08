# Enterprise Linux Administration & Operations

This repository is a text-only training project for junior Linux administrators, help desk engineers moving into operations, and platform teams that want structured hands-on practice. It focuses on RHEL compatible systems and covers installation, storage, LVM, RAID, users, permissions, sudo, networking, firewalling, SSH, NFS, FTP, HAProxy, systemd, performance monitoring, boot recovery, troubleshooting, and realistic incident response.

## How To Use This Repository

Start with the setup guides in `docs/setup`, then work through the numbered labs in order. The labs build from basic installation and filesystem work toward multi-tier recovery exercises. Each lab includes objectives, prerequisites, commands, expected output, validation steps, and cleanup guidance. The scripts are examples for disposable lab systems; read them before running and avoid executing storage or recovery scripts on important hosts.

## Recommended Lab Topology

| Role | Example hostname | Purpose |
|---|---|---|
| Admin workstation | admin01 | SSH client, documentation, testing |
| Server node | server01 | Main lab target |
| Storage node | storage01 | NFS, RAID, LVM, backup drills |
| Web node | web01 | Apache, HAProxy, application troubleshooting |

## Repository Rules

The repository intentionally contains only Markdown, shell scripts, and plain text configuration examples. No image, binary, or draw.io files are required. Architecture and screenshot folders contain text placeholders so learners can add their own diagrams in private forks if needed.

## Safety

Practice destructive topics such as partitioning, RAID failure, boot repair, and password reset in snapshots or throwaway virtual machines. Enterprise administration is about controlled change: inspect state, change one thing, validate, document, and keep a rollback path.

## Operator Notes

Treat Enterprise Linux Administration & Operations as a controlled administrative change, not as a memory exercise. Read the command, state what object it changes, run it on a disposable lab host first, and record the before and after state. Enterprise Linux work is safest when every action can be explained later from logs, shell history, and a short ticket note. When your output differs from the examples, compare release versions, service names, SELinux mode, firewall zones, and whether NetworkManager or systemd is managing the component.

## Validation Habit

A good administrator validates from two directions: the local system state and the client experience. Do not only check that a daemon is active; also test the socket, review the log, and confirm that persistence survives a reboot. This habit prevents temporary fixes from being mistaken for durable operations. Keep commands readable, prefer documented configuration files, and avoid destructive shortcuts unless a backup and rollback plan are already written.
