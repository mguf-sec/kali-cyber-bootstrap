# 🛡️ kali-cyber-bootstrap

**The easiest way to turn a fresh Kali Linux VM into a powerful pentesting machine** — made especially for **students, beginners, CTF players, and bug bounty starters**.

![Kali Linux](https://img.shields.io/badge/Kali_Linux-268BEE?style=for-the-badge&logo=kali-linux&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-green.svg)

---

### Why Use This Script?

- Saves **hours** of manual setup
- Installs all essential tools students need
- Creates organized folders (`labs`, `tools`, `wordlists`)
- Adds useful shortcuts (aliases)
- Works great on VirtualBox / VMware
- Designed with **beginners in mind**

> ⚠️ **Important**: This script is for **educational purposes only**. Use it only on your own machines, authorized labs, or CTF environments.

---

### Requirements

- Kali Linux (fresh or existing VM)
- Internet connection
- At least **4GB RAM** recommended (8GB+ better)

---

### Super Easy Installation (Step-by-Step for Beginners)

#### Option 1: One-Command Install (Recommended)

Open **Terminal** in Kali Linux and copy-paste these commands one by one:

```bash
# Download the script
curl -fsSL https://raw.githubusercontent.com/YOURUSERNAME/kali-cyber-bootstrap/main/kali-cyber-bootstrap.sh -o kali-cyber-bootstrap.sh

# Make it executable
chmod +x kali-cyber-bootstrap.sh

# Run the script (with administrator rights)
sudo ./kali-cyber-bootstrap.sh
