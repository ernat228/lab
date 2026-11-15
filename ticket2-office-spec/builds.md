# Builds — four machines, four loads

Common platform: AM5 (Ryzen 5 7600, 6 cores / 12 threads, integrated graphics), ASUS Prime B650M-A WiFi (4 memory slots),
DDR5, Kingston NV3 1 TB NVMe, Zalman M5 case, 550 W PSU, Windows 11 Pro. Reason: one platform means one stock of
spares and a DDR5 upgrade path; what differs between machines is memory, monitor and graphics, because that is where
the loads differ. Prices, sources and dates: budget.csv. The PSU price is not found yet, so no total below includes it.

## Build 1 — accountant
**Load:** accounting software and Excel, email, browser, one document at a time, many hours a day.
**Bottleneck:** none on the CPU or memory side. The real constraint is the user: eight hours of text on a screen.
**Trade-off:** 16 GB (one module, three slots left free) instead of 32 GB: a 32 GB kit costs 230,168 KZT against
123,309 for 16 GB, a difference of 106,859 KZT. That money went to nothing else here; it was simply not spent.
The 27" QHD IPS monitor reads text more comfortably than a cheap 24" Full HD one.
**Total (without PSU):** 585,773 KZT (budget.csv, accountant rows)

## Build 2 — sales manager
**Load:** CRM in a browser with 30-40 tabs, Excel, several hours of video calls a day, often all at once.
**Bottleneck:** memory, not CPU. A browser with that many tabs plus a video call is easily 11-12 GB.
**Trade-off:** a 6-core CPU instead of 8 cores, and 32 GB of memory. The CPU idles in this role, the memory does not.
**Total (without PSU):** 692,632 KZT

## Build 3 — web developer
**Load:** IDE, browser with documentation, Docker containers or a local database, sometimes a virtual machine, builds and tests.
**Bottleneck:** memory first (containers hold it), CPU threads second, disk speed third.
**Trade-off:** the same 6-core CPU as the others plus a second monitor, instead of a bigger CPU. Two screens save more
developer time than 20 % more CPU. 32 GB with two free slots leaves room to grow to 64 GB.
**Total (without PSU):** 757,922 KZT. The second monitor (65,290) is the first thing to cut if the PSUs push the total over 3,000,000.

## Build 4 — designer
**Load:** Photoshop / Figma / vector work, large files, export and rendering, colour decisions made by eye.
**Bottleneck:** the monitor (colour and size) and the graphics card; memory for large files.
**Trade-off:** a business-class IPS monitor (ASUS VB27AQ) instead of a factory-calibrated designer monitor, so there is money
for an RTX 5060 8 GB, the cheapest card of its class I found. This is the machine most likely to complain (README, question 3).
**Total (without PSU):** 909,593 KZT

## Total
585,773 + 692,632 + 757,922 + 909,593 = **2,945,920 KZT** of 3,000,000, without the four PSUs.
That leaves **54,080 KZT** for four 550 W PSUs, i.e. about 13,500 each. That is probably too little, so the budget is
tight: if the PSUs do not fit, drop the developer's second monitor (65,290) first.
