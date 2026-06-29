# 🛡️ kali-cyber-bootstrap

> **The ultimate one-shot setup script for Kali Linux** — built for cybersecurity students, CTF players, and bug bounty beginners learning in VM environments.

![Kali Linux](https://img.shields.io/badge/Kali_Linux-268BEE?style=for-the-badge&logo=kali-linux&logoColor=white)
![Bash](https://img.shields.io/badge/Bash-4EAA25?style=for-the-badge&logo=gnu-bash&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-brightgreen?style=for-the-badge)
![Platform](https://img.shields.io/badge/Platform-VirtualBox%20%7C%20VMware-blue?style=for-the-badge)
![Status](https://img.shields.io/badge/Status-Active-success?style=for-the-badge)

---

## ⚠️ Important Disclaimer

> **This script is for EDUCATIONAL and AUTHORIZED use only.**
> Run it only on machines you own, your own VMs, authorized CTF labs, or environments where you have explicit written permission.
> The author is **not responsible** for any misuse of this script or the tools it installs.

---

## 📖 What Is This?

Setting up a Kali Linux VM from scratch takes hours. You need to update packages, install dozens of tools, clone wordlists, configure your shell, and organize your workspace — before you even start learning.

**kali-cyber-bootstrap fixes all of that in one command.**

It automatically:
- ✅ Updates your entire Kali system
- ✅ Installs 50+ essential security tools
- ✅ Sets up your workspace folders
- ✅ Clones popular wordlists & repositories
- ✅ Installs Go & Python tools
- ✅ Configures Zsh with useful shortcuts
- ✅ Applies VM optimizations (clipboard, display, etc.)

---

## 💻 Requirements

| Requirement | Notes |
|---|---|
| **OS** | Kali Linux (rolling release recommended) |
| **VM Software** | VirtualBox or VMware Workstation |
| **RAM** | Minimum 4GB (8GB+ strongly recommended) |
| **Storage** | At least 40GB free disk space |
| **Internet** | Stable connection required throughout |
| **User** | Run as root or with sudo |

---

## 🚀 Quick Start (Beginners — Read This First!)

> **New to terminal?** Open Kali → Click the black terminal icon at the top → Copy and paste the commands below one at a time and press Enter after each.

### Option 1: One-Command Install ✅ (Recommended)

```bash
# Step 1: Download the script
curl -fsSL https://raw.githubusercontent.com/YOURUSERNAME/kali-cyber-bootstrap/main/kali-cyber-bootstrap.sh -o kali-cyber-bootstrap.sh

# Step 2: Make it executable
chmod +x kali-cyber-bootstrap.sh

# Step 3: Run it (this will take 10-30 minutes depending on your internet)
sudo ./kali-cyber-bootstrap.sh
```

### Option 2: Clone the Repository

```bash
git clone https://github.com/YOURUSERNAME/kali-cyber-bootstrap.git
cd kali-cyber-bootstrap
sudo ./kali-cyber-bootstrap.sh
```

---

## 🔧 What Gets Installed

### 🖥️ Core / Terminal Utilities
```
git · wget · curl · jq · tmux · fzf · ripgrep · bat · neovim · htop · btop · unzip · p7zip · tree
```

### 🌐 Recon / Web / Bug Bounty
```
nmap · masscan · subfinder · httpx · nuclei · gobuster · ffuf · feroxbuster
nikto · wpscan · sqlmap · wafw00f · whatweb · dirb
```

### 🔎 OSINT & Passive Recon
```
theHarvester · recon-ng · maltego (GUI) · exiftool · whois · dnsrecon
```

### 🔑 Credential / Password Attacks
```
hydra · john · hashcat · hcxtools · crunch · medusa
```

### 🏢 Active Directory / Windows / Infrastructure
```
crackmapexec · evil-winrm · impacket · responder · kerbrute · bloodhound
```

### 🔍 Secrets / Code Scanning
```
gitleaks · semgrep · trufflehog
```

### 🐍 Python Tools (via pipx)
```
mitmproxy · dirsearch · paramspider · bloodhound-python · updog
```

### 🐹 Go Tools
```
subfinder · httpx · nuclei · katana · gau · waybackurls
hakrawler · assetfinder · httprobe · interactsh-client
```

### 🖱️ GUI Applications
```
Burp Suite · Wireshark · Caido · BloodHound · Docker · VS Code
Maltego · Tor Browser · Obsidian
```

### 📚 Wordlists & Repositories Cloned

| Repository | Location |
|---|---|
| SecLists | `~/wordlists/SecLists` |
| PayloadsAllTheThings | `~/tools/PayloadsAllTheThings` |
| nuclei-templates | `~/tools/nuclei-templates` |
| XSStrike | `~/tools/XSStrike` |
| Gf-Patterns | `~/tools/Gf-Patterns` |
| fuzzing-templates | `~/tools/fuzzing-templates` |

---

## 📁 Workspace Layout

After running, your home directory will look like this:

```
~/
├── labs/           ← Your CTF & practice projects go here
├── tools/          ← All cloned tools & custom scripts
├── wordlists/      ← SecLists, rockyou, and other wordlists
├── reports/        ← Your pentest & bug bounty reports
└── screenshots/    ← Evidence screenshots of findings
```

---

## ⌨️ Shell Shortcuts Added

These aliases are automatically added to your `~/.zshrc`:

| Alias | Command | What It Does |
|---|---|---|
| `ll` | `ls -lah` | List files with full details |
| `ctf` | `cd ~/labs` | Jump to your CTF workspace |
| `tools` | `cd ~/tools` | Jump to tools folder |
| `wordlists` | `cd ~/wordlists` | Jump to wordlists folder |
| `ports` | `ss -tuln` | Show all open/listening ports |
| `myip` | `curl ifconfig.me` | Show your public IP address |
| `localip` | `hostname -I` | Show your local/VM IP address |
| `pyserver` | `python3 -m http.server 8000` | Start a quick web server |
| `reload` | `source ~/.zshrc` | Reload your shell config |
| `update` | `apt update && apt upgrade -y` | Full system update |

---

## ✅ After Running the Script

Follow these steps after the script finishes:

```bash
# 1. Reload your shell configuration
source ~/.zshrc

# 2. Reboot your VM (highly recommended)
reboot

# 3. After reboot — verify key tools are installed
which nmap ffuf nuclei subfinder httpx sqlmap hydra gobuster

# 4. Check Go tools are in your PATH
subfinder -version
httpx -version
nuclei -version

# 5. Jump into your CTF workspace and start hacking!
ctf
```

Then manually complete first-run setup for:
- **Burp Suite** — launch and accept license
- **Wireshark** — allow non-root capture if prompted
- **Docker** — `sudo systemctl enable docker && sudo systemctl start docker`

---

## 🖥️ VM Optimizations Included

The script also applies these quality-of-life fixes for VM users:

- Installs **VirtualBox Guest Additions** or **VMware Tools** automatically
- Enables **shared clipboard** (copy/paste between host and VM)
- Enables **drag and drop** file transfer
- Fixes **screen resolution** auto-scaling
- Installs `open-vm-tools` or `virtualbox-guest-x11` depending on your VM

---

## ❓ Manual / Special Cases

These tools are intentionally not included in the script:

| Tool | Reason | Alternative |
|---|---|---|
| **Nessus** | Paid product, requires Tenable account | Download from tenable.com |
| **Metasploit** | Already pre-installed in Kali | Just run `msfconsole` |
| **Mimikatz** | Windows-only in practice | Use inside a Windows VM |
| **Cobalt Strike** | Commercial / licensed tool | Use for authorized engagements only |

---

## 🛠️ Errors & Partial Failures

The script uses `set -Eeuo pipefail` with per-tool error handling.

- If **one tool fails**, the script shows a warning and **continues** — it won't crash entirely
- After the script finishes, check the terminal output for any `[!] WARNING` messages
- Common fix: run `apt --fix-broken install` and re-run the script

---

## 🤝 Contributing

Students and learners are welcome to contribute!

1. **Fork** this repository
2. Create a new branch: `git checkout -b add-my-tool`
3. Make your changes
4. **Submit a Pull Request** with a description of what you added

Ideas for contributions:
- Add more useful tools
- Improve VM compatibility
- Add a GUI progress indicator
- Add support for other Debian-based distros

---

## 📚 Learning Resources

If you're just getting started with cybersecurity, here are some great free platforms:

| Platform | What You'll Learn |
|---|---|
| [TryHackMe](https://tryhackme.com) | Beginner-friendly guided labs |
| [HackTheBox](https://hackthebox.com) | Real-world CTF machines |
| [PortSwigger Web Academy](https://portswigger.net/web-security) | Web hacking (free!) |
| [PicoCTF](https://picoctf.org) | CTF for students |
| [OverTheWire](https://overthewire.org) | Linux & security wargames |

---

## 📄 License

MIT — use freely, modify, and contribute back. See [LICENSE](LICENSE) for full terms.

---

## ⭐ Show Some Love

If this saved you hours of setup time, give the repo a **⭐ star** — it helps other students find it!

---

<div align="center">

**Happy Learning & Ethical Hacking!** 🐧

*Made with ❤️ for cybersecurity students everywhere*

</div>
