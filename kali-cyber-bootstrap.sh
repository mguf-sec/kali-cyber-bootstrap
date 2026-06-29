#!/bin/bash
# =============================================================================
# kali-cyber-bootstrap.sh
# One-shot Kali Linux setup for students, CTF players, and bug bounty beginners
# For AUTHORIZED and EDUCATIONAL use only
# =============================================================================

set -Eeuo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m' # No Color

LOGFILE="$HOME/bootstrap-log.txt"

log()    { echo -e "${GREEN}[+]${NC} $1" | tee -a "$LOGFILE"; }
warn()   { echo -e "${YELLOW}[!]${NC} $1" | tee -a "$LOGFILE"; }
error()  { echo -e "${RED}[✗]${NC} $1" | tee -a "$LOGFILE"; }
header() { echo -e "\n${CYAN}${BOLD}==> $1${NC}" | tee -a "$LOGFILE"; }

safe_apt() {
    apt install -y "$@" 2>>"$LOGFILE" || warn "Some packages in this group failed: $*"
}

safe_go() {
    go install -v "$1" 2>>"$LOGFILE" || warn "Go install failed: $1"
}

safe_pipx() {
    pipx install "$1" 2>>"$LOGFILE" || warn "pipx install failed: $1"
}

safe_clone() {
    local repo="$1"
    local dest="$2"
    if [ -d "$dest" ]; then
        warn "Already exists, skipping: $dest"
    else
        git clone --depth=1 "$repo" "$dest" 2>>"$LOGFILE" || warn "Clone failed: $repo"
    fi
}

# =============================================================================
# BANNER
# =============================================================================
clear
echo -e "${CYAN}${BOLD}"
cat << 'EOF'
  _  __     _ _    ____      _               ____              _       _
 | |/ /    | (_)  / ___|   _| |__   ___ _ __| __ )  ___   ___ | |_ ___| |_ _ __ __ _ _ __
 | ' / ___ | | | | |  | | | | '_ \ / _ \ '__|  _ \ / _ \ / _ \| __/ __| __| '__/ _` | '_ \
 | . \/ _ \| | | | |__| |_| | |_) |  __/ |  | |_) | (_) | (_) | |_\__ \ |_| | | (_| | |_) |
 |_|\_\___/|_|_|  \____\__, |_.__/ \___|_|  |____/ \___/ \___/ \__|___/\__|_|  \__,_| .__/
                        |___/                                                          |_|
EOF
echo -e "${NC}"
echo -e "${BOLD}  🛡️  Kali Linux Student Setup — One-Shot Edition${NC}"
echo -e "  For authorized labs, CTFs, and educational use only.\n"
echo -e "${YELLOW}  Starting at: $(date)${NC}"
echo -e "  Log file: ${LOGFILE}\n"
sleep 2

# =============================================================================
# STEP 1: System Update
# =============================================================================
header "STEP 1/9 — Updating System"
log "Running full system upgrade (this may take a few minutes)..."
apt update -y 2>>"$LOGFILE"
apt full-upgrade -y 2>>"$LOGFILE"
apt autoremove -y 2>>"$LOGFILE"
log "System updated successfully."

# =============================================================================
# STEP 2: Core Utilities
# =============================================================================
header "STEP 2/9 — Installing Core Utilities"
safe_apt \
    git wget curl jq tmux fzf ripgrep bat htop btop \
    neovim vim nano unzip p7zip-full tree net-tools \
    dnsutils whois traceroute netcat-traditional \
    tcpdump openssl ca-certificates gnupg lsb-release \
    apt-transport-https software-properties-common \
    build-essential libssl-dev libffi-dev \
    python3 python3-pip python3-dev python3-venv python3-pipx \
    golang-go default-jdk ruby ruby-dev \
    zsh zsh-autosuggestions zsh-syntax-highlighting

log "Core utilities installed."

# =============================================================================
# STEP 3: Security & Pentesting Tools
# =============================================================================
header "STEP 3/9 — Installing Security Tools"

log "Installing recon & scanning tools..."
safe_apt nmap masscan ncat ndiff zenmap gobuster feroxbuster ffuf dirbuster dirb

log "Installing web testing tools..."
safe_apt sqlmap nikto wpscan whatweb wafw00f curl wget arjun \
         burpsuite wireshark tshark tcpdump

log "Installing credential / cracking tools..."
safe_apt hydra john hashcat hcxtools hcxdumptool crunch medusa

log "Installing network tools..."
safe_apt netdiscover arp-scan macchanger ettercap-text-only \
         dsniff tcpflow bettercap

log "Installing Active Directory / Windows tools..."
safe_apt evil-winrm impacket-scripts crackmapexec responder smbclient \
         krb5-user ldap-utils

log "Installing OSINT tools..."
safe_apt recon-ng exiftool metagoofil dmitry

log "Installing exploit & post-exploitation tools..."
safe_apt metasploit-framework exploitdb \
         proxychains4 tor socat

log "Installing secrets scanning tools..."
safe_apt trufflehog || warn "trufflehog not available in apt, will try pipx later"

log "Installing misc useful tools..."
safe_apt docker.io docker-compose \
         rsync screen parallel jq yq \
         libreoffice-calc

log "Security tools installed."

# =============================================================================
# STEP 4: Go Tools
# =============================================================================
header "STEP 4/9 — Installing Go Tools"

# Ensure Go binary directory is in PATH
export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin:/usr/local/go/bin"

log "Installing ProjectDiscovery suite..."
safe_go "github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest"
safe_go "github.com/projectdiscovery/httpx/cmd/httpx@latest"
safe_go "github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest"
safe_go "github.com/projectdiscovery/katana/cmd/katana@latest"
safe_go "github.com/projectdiscovery/naabu/v2/cmd/naabu@latest"
safe_go "github.com/projectdiscovery/interactsh/cmd/interactsh-client@latest"
safe_go "github.com/projectdiscovery/dnsx/cmd/dnsx@latest"

log "Installing recon Go tools..."
safe_go "github.com/hakluke/hakrawler@latest"
safe_go "github.com/tomnomnom/waybackurls@latest"
safe_go "github.com/tomnomnom/assetfinder@latest"
safe_go "github.com/tomnomnom/httprobe@latest"
safe_go "github.com/tomnomnom/anew@latest"
safe_go "github.com/tomnomnom/gf@latest"
safe_go "github.com/lc/gau/v2/cmd/gau@latest"

log "Installing secret scanning Go tools..."
safe_go "github.com/zricethezav/gitleaks/v8@latest"

log "Installing fuzzing & misc Go tools..."
safe_go "github.com/ffuf/ffuf/v2@latest"

log "Go tools installed."

# =============================================================================
# STEP 5: Python Tools
# =============================================================================
header "STEP 5/9 — Installing Python Tools"

log "Installing via pipx..."
safe_pipx "mitmproxy"
safe_pipx "dirsearch"
safe_pipx "paramspider"
safe_pipx "updog"
safe_pipx "trufflehog"

log "Installing via pip3..."
pip3 install --break-system-packages \
    requests beautifulsoup4 lxml \
    pwntools ropper pycryptodome \
    bloodhound || warn "Some pip packages failed"

log "Python tools installed."

# =============================================================================
# STEP 6: Wordlists & Repositories
# =============================================================================
header "STEP 6/9 — Cloning Wordlists & Repositories"

mkdir -p ~/wordlists ~/tools

log "Cloning SecLists..."
safe_clone "https://github.com/danielmiessler/SecLists.git" "$HOME/wordlists/SecLists"

log "Cloning PayloadsAllTheThings..."
safe_clone "https://github.com/swisskyrepo/PayloadsAllTheThings.git" "$HOME/tools/PayloadsAllTheThings"

log "Cloning nuclei-templates..."
safe_clone "https://github.com/projectdiscovery/nuclei-templates.git" "$HOME/tools/nuclei-templates"

log "Cloning XSStrike..."
safe_clone "https://github.com/s0md3v/XSStrike.git" "$HOME/tools/XSStrike"

log "Cloning Gf-Patterns..."
safe_clone "https://github.com/tomnomnom/gf.git" "$HOME/tools/gf-patterns"

log "Cloning fuzzing-templates..."
safe_clone "https://github.com/projectdiscovery/fuzzing-templates.git" "$HOME/tools/fuzzing-templates"

log "Cloning PrivescCheck..."
safe_clone "https://github.com/itm4n/PrivescCheck.git" "$HOME/tools/PrivescCheck"

log "Cloning PEASS-ng (LinPEAS / WinPEAS)..."
safe_clone "https://github.com/carlospolop/PEASS-ng.git" "$HOME/tools/PEASS-ng"

log "Cloning Impacket examples..."
safe_clone "https://github.com/fortra/impacket.git" "$HOME/tools/impacket"

# Unzip rockyou if present
if [ -f /usr/share/wordlists/rockyou.txt.gz ]; then
    log "Decompressing rockyou.txt..."
    gunzip -f /usr/share/wordlists/rockyou.txt.gz 2>>"$LOGFILE" || true
fi

log "Wordlists and repositories ready."

# =============================================================================
# STEP 7: Workspace Directories
# =============================================================================
header "STEP 7/9 — Creating Workspace Layout"

mkdir -p \
    ~/labs \
    ~/tools \
    ~/wordlists \
    ~/reports \
    ~/screenshots \
    ~/ctf \
    ~/notes \
    ~/scripts

log "Workspace directories created:"
tree -L 1 ~ 2>/dev/null || ls ~

# =============================================================================
# STEP 8: VM Optimizations
# =============================================================================
header "STEP 8/9 — Applying VM Optimizations"

# Detect VM type
if systemd-detect-virt 2>/dev/null | grep -qi "vmware"; then
    log "VMware detected — installing open-vm-tools..."
    safe_apt open-vm-tools open-vm-tools-desktop
elif systemd-detect-virt 2>/dev/null | grep -qi "oracle\|virtualbox"; then
    log "VirtualBox detected — installing Guest Additions..."
    safe_apt virtualbox-guest-x11 virtualbox-guest-utils virtualbox-guest-dkms
else
    log "VM type not detected — skipping VM tools."
fi

# Enable Docker service
log "Enabling Docker service..."
systemctl enable docker 2>>"$LOGFILE" || warn "Could not enable Docker"
usermod -aG docker "$SUDO_USER" 2>>"$LOGFILE" || warn "Could not add user to docker group"

log "VM optimizations applied."

# =============================================================================
# STEP 9: Shell Configuration (Zsh + Aliases)
# =============================================================================
header "STEP 9/9 — Configuring Zsh Shell"

ZSHRC_TARGET="/home/${SUDO_USER:-$USER}/.zshrc"

# Switch default shell to Zsh
chsh -s /usr/bin/zsh "${SUDO_USER:-$USER}" 2>>"$LOGFILE" || warn "Could not switch shell to zsh"

# Append to .zshrc
cat >> "$ZSHRC_TARGET" << 'ZSHEOF'

# =============================================================================
# kali-cyber-bootstrap — Shell Configuration
# =============================================================================

# Go path
export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin:/usr/local/go/bin:$HOME/.local/bin"

# ---- Aliases ----
alias ll='ls -lah --color=auto'
alias la='ls -A'
alias l='ls -CF'
alias cls='clear'
alias ..='cd ..'
alias ...='cd ../..'

# Navigation shortcuts
alias ctf='cd ~/ctf'
alias labs='cd ~/labs'
alias tools='cd ~/tools'
alias wordlists='cd ~/wordlists'
alias reports='cd ~/reports'
alias notes='cd ~/notes'
alias scripts='cd ~/scripts'

# Network
alias ports='ss -tuln'
alias listening='ss -tulnp'
alias myip='curl -s ifconfig.me && echo'
alias localip='hostname -I | awk "{print \$1}"'
alias pingcheck='ping -c 4 google.com'

# Quick servers
alias pyserver='python3 -m http.server 8000'
alias pyserver443='python3 -m http.server 443'

# Tools shortcuts
alias nse='ls /usr/share/nmap/scripts | grep'
alias ffuf-quick='ffuf -w ~/wordlists/SecLists/Discovery/Web-Content/common.txt -u'
alias gobust='gobuster dir -w ~/wordlists/SecLists/Discovery/Web-Content/common.txt -u'

# System
alias update='sudo apt update && sudo apt full-upgrade -y && sudo apt autoremove -y'
alias reload='source ~/.zshrc && echo "✅ Shell reloaded!"'
alias myip6='curl -s ifconfig.me/ip'

# ---- Functions ----

# Start a quick Netcat listener
listen() { nc -lvnp "${1:-4444}"; }

# Decode base64 quickly
b64d() { echo "$1" | base64 -d; }
b64e() { echo "$1" | base64; }

# Quick nmap scans
scan_quick() { sudo nmap -sV -sC -T4 "$1"; }
scan_full()  { sudo nmap -sV -sC -T4 -p- "$1"; }
scan_udp()   { sudo nmap -sU -T4 "$1"; }

# Create a dated report folder
new_report() {
    local name="${1:-target}"
    local dir="$HOME/reports/${name}_$(date +%Y%m%d)"
    mkdir -p "$dir"/{recon,web,exploit,loot,notes}
    echo "✅ Report folder created: $dir"
    cd "$dir"
}

# Print banner on shell start
echo ""
echo "  🛡️  Kali Bootstrap Environment Ready"
echo "  ➤ ctf, labs, tools, wordlists, reports"
echo "  ➤ scan_quick <IP>  |  listen <PORT>  |  pyserver"
echo ""

ZSHEOF

log "Zsh configured with aliases and functions."

# =============================================================================
# DONE — Summary
# =============================================================================
echo ""
echo -e "${CYAN}${BOLD}"
echo "  ╔══════════════════════════════════════════════════════╗"
echo "  ║        ✅  SETUP COMPLETE — kali-cyber-bootstrap     ║"
echo "  ╚══════════════════════════════════════════════════════╝"
echo -e "${NC}"
echo -e "${GREEN}${BOLD}  Next Steps:${NC}"
echo -e "  1. ${YELLOW}source ~/.zshrc${NC}              ← Reload your shell"
echo -e "  2. ${YELLOW}reboot${NC}                       ← Reboot VM (recommended)"
echo -e "  3. ${YELLOW}which nmap ffuf nuclei${NC}       ← Verify tools"
echo -e "  4. ${YELLOW}ctf${NC}                          ← Jump into your workspace"
echo ""
echo -e "${GREEN}${BOLD}  GUI Apps to launch manually:${NC}"
echo -e "  • Burp Suite — complete first-run setup"
echo -e "  • Wireshark  — allow capture permissions"
echo -e "  • Docker     — systemctl start docker"
echo ""
echo -e "${BLUE}  📄 Full log saved to: ${LOGFILE}${NC}"
echo -e "${CYAN}  🐧 Happy Learning & Ethical Hacking!${NC}"
echo ""
