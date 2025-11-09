# GitHub EC2 Setup

Automated Git + SSH setup script for AWS EC2 instances. It installs Git, configures your GitHub identity, generates or reuses SSH keys, and verifies access — so you can clone and push to GitHub without entering your username or password.

## 🚀 Features

- Installs and configures Git automatically
- Creates or reuses existing SSH keys
- Displays your public key for easy GitHub setup
- Tests SSH connection to verify authentication
- Works on any Ubuntu-based EC2 instance

## 🧩 Prerequisites

- Ubuntu or Debian-based EC2 instance
- GitHub account access
- Internet connectivity

## ⚙️ Usage

### 1. Clone this repository

```bash
git clone https://github.com/<your-username>/github-ec2-setup.git
cd github-ec2-setup
```

### 2. Edit the script variables

Open `github-setup.sh` and update:

```bash
GIT_EMAIL="your_email@example.com"
GIT_NAME="your_github_username"
```

### 3. Run the script

```bash
chmod +x github-setup.sh
./github-setup.sh
```

### 4. Add your SSH key to GitHub

When prompted, copy the key shown on-screen and add it here:

👉 [GitHub → Settings → SSH and GPG keys → New SSH key](https://github.com/settings/keys)

### 5. Test your connection

```bash
ssh -T git@github.com
```

You should see:

```
Hi <your-username>! You've successfully authenticated...
```

## 🧰 Example

After setup, clone repositories directly via SSH:

```bash
git clone git@github.com:<username>/<repo>.git
```

No more password prompts — just seamless GitHub access.

## 📄 License

MIT License — free to use and modify.

---
