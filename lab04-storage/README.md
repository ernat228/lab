# Lab 4 — Storage

## Windows
Disk 0: partition style GPT, firmware_type UEFI — because the guest booted
in UEFI mode, and UEFI firmware boots only from a GPT disk (Windows 11
requires UEFI).

New disk (Disk 1): partition style GPT — because it is the modern default
and has no practical downside for this disk. For 2 GB either MBR or GPT
would work, since I am not booting from it. The choice would matter for a
disk larger than 2 TB (MBR cannot address it), for booting a UEFI system
(needs GPT), or for more than four partitions (MBR allows only four
primary partitions; GPT allows 128 and keeps a backup copy of the table).

Get-Disk (summary): Disk 0 - 64 GB, GPT, system disk, NVMe.
Disk 1 - 2 GB, GPT, NVMe (initialised from RAW).

Get-Partition -DiskNumber 1:

    PartitionNumber  DriveLetter Offset     Size     Type
    ---------------  ----------- ------     ----     ----
    1                            17408      15.98 MB Reserved
    2                E           16777216   1.98 GB  Basic

$env:firmware_type: UEFI

## Linux layout — before
(full output in evidence/lsblk-before.txt)

    sda     15G disk  (system: /boot, / on LVM)
    sdb      2G disk
    sdc      2G disk
    sdd      2G disk

## Linux layout — after the rebuild
(full output in evidence/lsblk-after.txt)

    sdb
    └─sdb1  2G part linux_raid_member
      └─md0 2G raid1 ext4  /mnt/mirror
    sdc
    └─sdc1  2G part linux_raid_member   (belongs to nothing now)
    sdd
    └─sdd1  2G part linux_raid_member
      └─md0 2G raid1 ext4  /mnt/mirror

| Role            | Device |
|-----------------|--------|
| Mirror half A   | sdb1   |
| Failed half     | sdc1   |
| Replacement     | sdd1   |

## The question
Your colleague deleted the wrong file from the mirror an hour ago.
Does RAID 1 help? Why?

No, RAID 1 does not help in this case. A mirror writes every change to both
disks at the same time, so the deletion was copied to both halves immediately
and the file is gone from each of them. What would have helped is a real
backup or snapshot: an independent, point-in-time copy kept separately,
from which the file could be restored.

## Appendix: full lsblk output

### Before
```
NAME                       SIZE TYPE FSTYPE      MOUNTPOINT
loop0                     66.8M loop squashfs    /snap/core24/1643
loop1                      1.5M loop squashfs    /snap/hwctl/123
loop2                      1.5M loop squashfs    /snap/hwctl/131
loop3                     50.1M loop squashfs    /snap/snapd/27710
sda                         15G disk             
├─sda1                       1M part             
├─sda2                     1.8G part ext4        /boot
└─sda3                    13.2G part LVM2_member 
  └─ubuntu--vg-ubuntu--lv   10G lvm  ext4        /
sdb                          2G disk             
sdc                          2G disk             
sdd                          2G disk             
sr0                        2.7G rom  iso9660
```

### After the rebuild
```
NAME                       SIZE TYPE  FSTYPE            MOUNTPOINT
loop0                     66.8M loop  squashfs          /snap/core24/1643
loop1                      1.5M loop  squashfs          /snap/hwctl/123
loop2                      1.5M loop  squashfs          /snap/hwctl/131
loop3                     50.1M loop  squashfs          /snap/snapd/27710
sda                         15G disk                    
├─sda1                       1M part                    
├─sda2                     1.8G part  ext4              /boot
└─sda3                    13.2G part  LVM2_member       
  └─ubuntu--vg-ubuntu--lv   10G lvm   ext4              /
sdb                          2G disk                    
└─sdb1                       2G part  linux_raid_member 
  └─md0                      2G raid1 ext4              /mnt/mirror
sdc                          2G disk                    
└─sdc1                       2G part  linux_raid_member 
sdd                          2G disk                    
└─sdd1                       2G part  linux_raid_member 
  └─md0                      2G raid1 ext4              /mnt/mirror
sr0                        2.7G rom   iso9660
```

