# Office Hardware Specification Report

## 1. The Fallacy of Identical Machines
The director’s assumption that we should buy four identical machines is fundamentally wrong. The workloads of an accountant and a designer are completely opposite. If we split the 3,000,000 KZT budget equally (750,000 KZT per machine), the designer will be severely bottlenecked by a weak GPU and a low-quality monitor, while the accountant and sales manager will have expensive hardware sitting idle. By tailoring the builds, we allocate the budget where it is actually needed.

## 2. Administrative Roles (Accountant & Sales)
These roles do not require heavy computation. Their workloads consist of browser-based CRM, 1C Accounting, Excel, and video calls. These tasks are heavily dependent on memory capacity and fast storage, not graphics processing. We can safely use integrated graphics and mid-range CPUs, allowing us to keep the cost per machine under 450,000 KZT while still providing 32GB of RAM for the sales manager's heavy multitasking.

## 3. Production Roles (Web Developer & Designer)
These machines consume the majority of our budget. The web developer requires high multi-core CPU performance and massive RAM (64GB) to run local servers and Docker containers, but does not need a dedicated GPU. The designer requires a high-end dedicated GPU (RTX 4070) for rendering and an expensive, color-accurate 4K monitor. 

## 4. Budget Compliance
The total cost for all four machines, including licensed Windows 11 Pro and monitors for everyone, comes to **2,873,800 KZT**. This leaves a safe buffer of over 120,000 KZT for delivery fees or minor price fluctuations, successfully staying under the 3,000,000 KZT limit. Every machine meets the hard requirements of at least 16 GB memory and a 1 TB SSD.

## 5. Q&A

**1. Which of the four machines will you upgrade first, eighteen months from now, and why?**
The Designer’s storage. We met the hard requirement of a 1 TB SSD to afford the GPU and monitor, but massive raw video files, Photoshop scratch disks, and Figma caches will fill 1 TB very quickly. Within 18 months, we will need to purchase an additional 2 TB or 4 TB secondary NVMe drive for this specific machine.

**2. Price the same four as pre-built machines from a vendor. What does the company gain and what does it lose by not building them?**
Purchasing equivalent pre-built workstations (e.g., Dell XPS or HP EliteDesk lines from local vendors) would cost approximately 15-25% more, pushing us over the 3,000,000 KZT budget. 
*   **What we gain:** A single point of contact for warranties, guaranteed out-of-the-box compatibility, and zero time spent by our staff on assembly and troubleshooting.
*   **What we lose:** We lose computing power per tenge spent. More importantly, we lose future upgradeability, as enterprise pre-builts frequently use proprietary motherboards and power supplies that prevent us from simply swapping in a new GPU or standard RAM later.

**3. One of these four people will complain about performance within a month. Which one, and about what?**
The Web Developer will complain, but not about the PC's performance. They will complain about having only one monitor. We provided a single high-quality 27-inch 1440p monitor to stay within budget, but web development almost universally requires a dual-monitor setup (one for code, one for the browser/output).
