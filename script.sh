#!/bin/bash
# script.sh
# Automates Git + SSH setup for GitHub on EC2

# === USER VARIABLES ===
GIT_EMAIL="your_email@example.com"      # Replace with your GitHub email
GIT_NAME="your_github_username"         # Replace with your GitHub username
SSH_PASSPHRASE=""                       # Optional: leave empty for no passphrase

# === INSTALL GIT ===
sudo apt update -y
sudo apt install -y git

git config --global user.email "$GIT_EMAIL"
git config --global user.name "$GIT_NAME"

# === SSH SETUP ===
SSH_DIR="$HOME/.ssh"
KEY_PATH="$SSH_DIR/id_rsa"

mkdir -p "$SSH_DIR"
chmod 700 "$SSH_DIR"

echo "🔍 Checking if SSH key already exists..."
if [[ -f "$KEY_PATH" && -f "$KEY_PATH.pub" ]]; then
    echo "✅ Existing SSH key found at $KEY_PATH."
    read -p "Do you want to reuse this existing key? (y/n): " reuse
    if [[ "$reuse" =~ ^[Yy]$ ]]; then
        echo "Reusing existing SSH key..."
    else
        echo "Generating a new SSH key..."
        ssh-keygen -t rsa -b 4096 -C "$GIT_EMAIL" -N "$SSH_PASSPHRASE" -f "$KEY_PATH"
    fi
else
    echo "⚠️ No SSH key found. Generating a new one..."
    ssh-keygen -t rsa -b 4096 -C "$GIT_EMAIL" -N "$SSH_PASSPHRASE" -f "$KEY_PATH"
fi

# Start SSH agent and add key
eval "$(ssh-agent -s)"
ssh-add "$KEY_PATH"

# === DISPLAY PUBLIC KEY ===
echo
echo "============================================"
echo "📋 Copy the following SSH PUBLIC key and add it to your GitHub account:"
echo "👉 GitHub → Settings → SSH and GPG keys → New SSH key"
echo "============================================"
cat "$KEY_PATH.pub"
echo "============================================"
echo
read -p "⏸️  Press ENTER once you've added the key to your GitHub account to continue..."

# === TEST CONNECTION ===
echo "Testing SSH connection to GitHub..."
ssh -T git@github.com || true

echo
echo "✅ GitHub SSH setup complete!"
echo "💡 You can now clone repositories using:"
echo "   git clone git@github.com:<username>/<repo>.git"
