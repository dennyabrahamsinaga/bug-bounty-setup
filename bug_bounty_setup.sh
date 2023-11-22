#!/bin/bash

# Function to check if a command is available
command_exists() {
  	command -v "$1" >/dev/null 2>&1
}

# Install or upgrade system packages
upgrade_system() {
  	sudo apt update
  	sudo apt upgrade -y
}

# Install Python and pip if not already installed
install_python() {
  	if ! command_exists "python3"; then
    	sudo apt install -y python3
  	fi

  	if ! command_exists "pip3"; then
    	sudo apt install -y python3-pip
  	fi
}

# Create bug-bounty directory
create_bug_bounty_directory() {
  	mkdir -p ~/bug-bounty
  	cd ~/bug-bounty || exit
}

# Install Go and set environment if not already installed
install_go() {
  if ! command_exists "go"; then
    sudo apt install -y golang
    echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc
    source ~/.bashrc
  fi
}

# Install subfinder
install_subfinder() {
  go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
  sudo mv ~/go/bin/subfinder /usr/local/bin
}

# Install httpx
install_httpx() {
  	go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest
  	sudo mv ~/go/bin/httpx /usr/local/bin
}

# Install nmap if not already installed
install_nmap() {
	if ! command_exists "nmap"; then
    	sudo apt install -y nmap
  	fi
}

# Install Git if not already installed
install_git() {
	if ! command_exists "git"; then
   		sudo apt install -y git
  	fi
}

# Install nuclei
install_nuclei() {
  	go install -v github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest
  	sudo mv ~/go/bin/nuclei /usr/local/bin
}

# Install dirsearch
install_dirsearch() {
	mkdir -p ~/bug-bounty/tools
  	cd ~/bug-bounty/tools || exit
  	if [ ! -d "dirsearch" ]; then
    	git clone https://github.com/maurosoria/dirsearch.git --depth 1
  	else
    	echo "dirsearch is already installed."
  	fi
}

# Install sqlmap
install_sqlmap() {
	mkdir -p ~/bug-bounty/tools
	cd ~/bug-bounty/tools || exit
	if [ ! -d "sqlmap-dev" ]; then
		git clone --depth 1 https://github.com/sqlmapproject/sqlmap.git sqlmap-dev
	else
		echo "sqlmap is already installed"
	fi
}

# Main setup function
setup_bug_bounty_environment() {
  	upgrade_system
  	install_python
  	create_bug_bounty_directory
  	install_go
  	install_subfinder
  	install_httpx
  	install_nmap
	install_git
	install_nuclei
	install_dirsearch
	install_sqlmap

	echo "Bug bounty environment setup complete."
}

# Run the main setup function
setup_bug_bounty_environment
