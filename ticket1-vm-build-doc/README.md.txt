# Ticket 1: Test machine for new dev

## 1. What was asked

"Hi, we have someone starting on Monday and he needs a test computer set up. Nothing special, just so he can try things without breaking anything. Can you write down how to do it so I can do the next one myself? Thanks"

## 2. What was actually needed

The requester asked for a "test computer" but left out critical technical details. They did not specify:
- Which Operating System the developer needs (Windows, Linux, or macOS).
- The hardware requirements (RAM, CPU cores, Disk space).
- The hypervisor platform to use.
- Network requirements (does it need internet access or local network isolation?).

I assumed a standard Ubuntu Linux Virtual Machine using VirtualBox (or VMware). I assumed giving it 2 CPU cores, 2048 MB of RAM, and a 20 GB disk, which is enough for basic testing without overloading the host machine. I also assumed NAT for safe internet access.

## 3. What I did

I created a step-by-step build document (`BUILD.md`) that a non-technical person (the office manager) can follow. 
I documented the process of setting up an Ubuntu VM from scratch, making sure to explain *why* certain settings (like RAM allocation and Network Adapter type) were chosen instead of just saying *what* to click.

## 4. Evidence

- [01-new-vm-wizard.png](evidence/01-new-vm-wizard.png): Shows the initial VM creation wizard.
- [02-disk-settings.png](evidence/02-disk-settings.png): Shows the disk allocation settings.
- [03-network-adapter.png](evidence/03-network-adapter.png): Shows the network set to NAT for safe internet access.
- [04-guest-uname.txt](evidence/04-guest-uname.txt): Proves the guest OS is installed and running.
- [05-ping-between-guests.txt](evidence/05-ping-between-guests.txt): Proves the VM has network connectivity.
- [06-snapshot-list.png](evidence/06-snapshot-list.png): Shows a clean snapshot taken so the dev can revert if they break things.

## 5. What I would do differently

Next time, instead of writing a manual step-by-step GUI guide, I would create an automated provisioning script (like a Vagrantfile). That way, the office manager could just run a single command to spin up a fresh testing environment, completely removing the risk of human error during manual setup.