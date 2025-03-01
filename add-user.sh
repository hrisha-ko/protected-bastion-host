#!/bin/bash

# Check if the script is run with root privileges
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root. Use sudo."
    exit 1
fi

# Read username from input
read -p "Enter the username: " USERNAME

# Check if the user already exists
if id "$USERNAME" &>/dev/null; then
    echo "User '$USERNAME' already exists. Exiting."
    exit 1
fi

# Create user with no shell access
sudo useradd -m -s /usr/sbin/nologin "$USERNAME"
echo "User '$USERNAME' created with no shell access."

# Set up SSH directory
SSH_DIR="/home/$USERNAME/.ssh"
sudo mkdir -p "$SSH_DIR"
sudo touch "$SSH_DIR/authorized_keys"

# Set correct permissions
sudo chmod 700 "$SSH_DIR"
sudo chmod 600 "$SSH_DIR/authorized_keys"
sudo chown -R "$USERNAME:$USERNAME" "$SSH_DIR"

echo "SSH directory and authorized_keys file set up."

# Prompt for SSH public key
read -p "Paste the SSH public key: " SSH_KEY
echo "$SSH_KEY" | sudo tee -a "$SSH_DIR/authorized_keys" > /dev/null

echo "SSH public key added for user '$USERNAME'."

# Confirm success
echo "User '$USERNAME' has been created without shell access, and SSH key authentication is set up."