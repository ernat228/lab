# Lab 6 — Live processes and memory pressure

Pair: Serikbay (ernat)
Machine: ERNATSERIKBAY, Windows + Ubuntu VM (lab01, 1.6 GiB RAM)
Date: 25.11.2026

## What I did

Looked at a live process on Windows using Task Manager and Process Explorer (Notepad.exe, PID 33488, PPID 29684, 1155 handles) and on the Linux VM using htop and /proc (python3 -m http.server 8000, PID 2250, PPID 2194, VSZ 35404 kB, RSS 22476 kB, 4 open fds).

On Linux I made a 1.0 GiB swap file, ran a small Python script that eats 50 MiB every 0.4 seconds, and logged ree -h before, during, and after into evidence/memory-pressure.txt. Then I grabbed the OOM killer lines from dmesg -T into evidence/kernel-log-extract.txt and checked Windows Event Viewer / System log for event ID 2004.

## Result

| Metric | Task Manager | Process Explorer | htop (Linux) |
|---|---|---|---|
| Process / PID | Notepad.exe (33488) | Notepad.exe (33488) | python3 -m http.server 8000 (2250) |
| Parent | Not shown in Details | Tree view (PPID 29684, already exited) | PPID 2194 (F5 tree) |
| Memory | 50 008 K (Get-Process: WorkingSet 126.4 MB, Private 106.4 MB, Virtual 2102990.4 MB) | Private Bytes 113 476 K, Working Set 141 476 K | VIRT 35404, RES 22476, SHR 10748 (1.4%) |
| Handles / FD | 1155 (from Get-Process) | 1155 (from Get-Process) | 4 open fds (/proc/2250/fd) |

The tools show memory differently. Task Manager just gives one memory column, while Process Explorer splits it into Private Bytes (113 476 K) and Working Set (141 476 K). In PowerShell Virtual_MB is huge (~2 TB) because Windows reserves a lot of virtual address space that isn't actually in RAM. On Linux, htop splits it into VIRT, RES, and SHR, and RES (22476) matches VmRSS in /proc/2250/status.

Task Manager also hides parent processes in the Details tab, while Process Explorer and htop (with F5) show the tree. For Notepad on Windows 11, the parent stub (29684) exits right after launch so there's no parent name left. Handles on Windows are way higher (1155) than fds on Linux (4) because Windows counts registry keys, events, mutexes, etc., not just files and sockets.

Memory pressure test on Linux:
- Before: 1.6Gi RAM (501Mi used, 758Mi free, 492Mi buff/cache, 1.1Gi available), swap 0B / 1.0Gi.
- During (15:11:42 to 15:12:14): available RAM dropped from 1.1Gi to 21Mi at 15:12:10, buff/cache shrunk to 68Mi, and swap filled up from 0B -> 24Ki -> 404Mi -> 968Mi -> 1.0Gi. The VM lagged pretty noticeably right before the kill.
- After: RAM went back to 441Mi used (1.1Gi available), with 28Mi left in swap.
- Kernel log: at 15:12:14 the OOM killer killed python3 (PID 2602, total-vm 2271668kB, anon-rss 1235948kB). The http.server process (PID 2250) stayed alive.
- Windows log: checked Microsoft-Windows-Resource-Exhaustion-Detector (event 2004) in the System log, nothing was recorded (evidence/win-event.txt).

## What did not work the first time

- Tried running Linux commands (&&, ree, swapon) in Windows PowerShell by mistake before switching to the VM.
- Tried launching python on Windows first, but it hit the Microsoft Store stub and exited with 0 memory, so I used Notepad (PID 33488) instead.
- The VM had 0 swap at the start (visible in htop.png), so I had to create a 1 GiB swap file before testing memory pressure.
- First scp failed because I forgot to replace <IP> and my lab folder was inside OneDrive Desktop.

## Evidence

- evidence/task-manager.png — Task Manager Details tab with Notepad.exe (33488)
- evidence/process-explorer.png — Process Explorer with Notepad.exe (33488)
- evidence/htop.png — htop on Linux with python3 http.server (2250)
- evidence/linux-process.txt — ps, /proc/2250/status, and open fd count
- evidence/win-process.txt — PowerShell process info for Notepad (33488)
- evidence/memory-pressure.txt — ree -h before/during/after
- evidence/kernel-log-extract.txt — dmesg -T OOM killer lines for PID 2602
- evidence/win-event.txt — Windows event ID 2004 check
- evidence/swap-setup.txt — swapon --show output
