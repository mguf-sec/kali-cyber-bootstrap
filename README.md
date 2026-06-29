# kali-cyber-bootstrap
#!/bin/bash
# kali-cyber-bootstrap.sh
# One-shot setup for Kali Linux VMs - Perfect for students, CTF, bug bounty labs
# Run as root or with sudo

set -Eeuo pipefail

echo "🛡️ kali-cyber-bootstrap - Setting up your Kali Linux pentesting environment..."

# Update system
echo "[+] Updating system..."
apt update && apt full-upgrade -y

# Install core packages
echo "[+] Installing core tools and dependencies..."
apt install -y \
    git wget curl jq tmux fzf ripgrep bat htop btop neovim \
    gobuster feroxbuster ffuf sqlmap nikto wpscan nmap masscan \
    hydra john hashcat \
    evil-winrm impacket-scripts crackmapexec \
    python3-pipx golang go-tools \
    wireshark burpsuite caido bloodhound \
    docker.io docker-compose \
    zsh zsh-autosuggestions zsh-syntax-highlighting \
    seclists wordlists

# Setup directories
echo "[+] Creating workspace..."
mkdir -p ~/labs ~/tools ~/wordlists ~/reports ~/screenshots

# Clone useful repos
echo "[+] Cloning useful repositories..."
cd ~/tools
git clone https://github.com/danielmiessler/SecLists.git ~/wordlists/SecLists || true
git clone https://github.com/swisskyrepo/PayloadsAllTheThings.git || true
git clone https://github.com/projectdiscovery/nuclei-templates.git || true

# Install Go tools
echo "[+] Installing Go tools..."
go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest
go install -v github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest
# Add more: katana, gau, etc.

# Python tools via pipx
echo "[+] Installing Python tools..."
pipx install mitmproxy dirsearch paramspider

# Shell setup (zsh)
echo "[+] Setting up zsh as default shell..."
chsh -s /usr/bin/zsh "$USER" || true

cat >> ~/.zshrc << 'EOF'

# kali-cyber-bootstrap aliases
alias ll='ls -lah'
alias ctf='cd ~/labs'
alias tools='cd ~/tools'
alias wordlists='cd ~/wordlists'
alias ports='ss -tuln'
alias myip='curl ifconfig.me'
alias pyserver='python3 -m http.server 8000'

# Reload function
reload() { source ~/.zshrc; echo "Shell reloaded!"; }
EOF

echo "✅ Setup completed!"
echo ""
echo "Next steps:"
echo "1. source ~/.zshrc"
echo "2. Reboot your VM"
echo "3. Log into Bitwarden (if installed)"
echo "4. Start Burp Suite / Caido / Wireshark"
echo ""
echo "Happy hacking! (Only on authorized targets)"
