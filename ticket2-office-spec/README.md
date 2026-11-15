# Ticket 2 — Office hardware specification

## 1. The request as received
Daniyar K. (Director): four computers for the second office — accountant, sales, web developer, designer; budget
3,000,000 tenge for everything; "everyone says we should just buy the same four machines, is that right?";
they must last a few years; monitors included.

## 2. The real request
**What the request left out.**
- What software each person runs (accounting package, CRM, IDE, design tools). The whole job depends on it.
- Whether 3,000,000 tenge includes Windows licences, delivery, VAT, and the things around the box
  (keyboard, mouse, webcam, headset, UPS).
- What "a few years" means in numbers.
**What I assumed instead.**
- Desktops, not laptops; licences, monitors and delivery inside the 3,000,000; "a few years" = four years with one upgrade at 18 months.
- Loads: accountant = office software; sales = browser, many tabs, video calls; developer = IDE, containers, builds;
  designer = raster and vector work, large files.
**Where the request itself was wrong.** Four identical machines is the wrong answer to the wrong question: the four
loads have four different bottlenecks (nothing, memory, memory + threads, monitor + graphics), so identical machines
overspend on the accountant and underspend on the designer. "Everyone says" is also not evidence. The second
mistake is the word "included": the monitor is a different share of the budget in each role.

## 3. The solution
Four builds with the load, bottleneck and trade-off for each: **builds.md**. Prices, sources and dates: **budget.csv**.
Evidence: **evidence/**. Result: four builds for 2,945,920 KZT without the four PSUs (price not found), 54,080 KZT under budget before PSUs.
Memory is unusually expensive: a 32 GB DDR5 kit costs 230,168 KZT at the cheapest listed shop (evidence/vendor-quotes), so only
the three roles with a memory-bound load get 32 GB.

**Q1. Which machine do I upgrade first, in eighteen months?** The developer's: memory 32 -> 64 GB. Containers and virtual machines
grow with every project, and the board has two free memory slots for exactly this. *(Replace with your own reasoning if you picked differently.)*

**Q2. The same four as pre-built machines.** The closest pre-built I found is the ITP Game 24 (Ryzen 5 7500F, B650, 32 GB, 1 TB SSD,
RTX 5060 8 GB, 600 W) at 799,990 KZT on alfa.kz (IT Portal KZ), 15 Nov 2026. It has no monitor and the listing does not mention Windows. My designer
machine without the monitor, with Windows, costs 817,174 KZT plus a PSU; the pre-built with a Windows licence added (87,420) is 887,410.
So building saves 70,236 KZT minus the PSU price, i.e. under 10 %, for a machine of the same class. What the company gains from pre-built: one warranty and one
invoice, no assembly time. What it loses: the saving, and above all the ability to differ by role. Pre-built lines are a few fixed
configurations, which is the director's "identical machines" assumption by another route; parts and the PSU may also be non-standard.

**Q3. Who complains within a month, and about what?** The designer, about colour: the monitor is business-class, not
factory-calibrated, so print proofs will not match the screen; the second complaint will be about export time, because the graphics card
is the cheapest that works. I accepted this on purpose to stay inside the budget.

## 4. Decisions and alternatives
- **One platform (AM5 / DDR5) for all four, instead of the cheapest board per role.** Alternative: cheaper DDR4 boards. Chosen: one stock of
  spares and a DDR5 upgrade path outweigh a small saving now.
- **32 GB for three roles and 16 GB for the accountant, instead of 32 GB for all.** 32 GB costs 106,859 KZT more than 16 GB per machine.
- **A second monitor for the developer instead of a bigger CPU.** The CPU is not that user's weak point; if the budget fails, this is the first cut.
- **A licensed Windows 11 Pro (87,420 KZT each) instead of the 2,000-20,000 KZT "activation keys" sold on marketplaces.** The cheap keys would save
  about 340,000 KZT in total but are not licences the company can prove it owns; the brief requires a licensed OS.
- **Build instead of pre-built.** Alternative: pre-built; trade-off in Q2.
- **Prices from one aggregator (e-katalog.kz) listing Kazakhstan shops.** Alternative: a written quote from each shop; slower, and prices move within a month either way, hence the date column.

## 5. What I would do differently
I would ask Daniyar the missing questions before building anything (software, peripherals, whether Windows is inside the budget) and price every part on two
different days to see how far memory moves. *(Edit this to something that really happened to you while doing the work.)*
