<label id="top"></label>

<div align="center">

<img src="./icon.png" alt="bash scripts app icon" width="120" height="120" />
<h1>Mek's Bash Scripts</h1>

[![License: All Rights Reserved](https://img.shields.io/badge/License-All%20Rights%20Reserved-red.svg)](./LICENSE.txt)
[![ShellCheck](https://img.shields.io/badge/ShellCheck-Passing-brightgreen.svg)](https://www.shellcheck.net/)
[![Bash](https://img.shields.io/badge/Bash-5.0+-4EAA25.svg)](https://www.gnu.org/software/bash/)

</div>

## Table of Contents
- [Introduction](#introduction)
- [Scripts](#scripts)
  - [git.sh - GitHub Repository Initializer](#gitsh---github-repository-initializer)
    - [Features](#features)
    - [Prerequisites](#prerequisites)
    - [Installation](#installation)
    - [Usage](#usage)
    - [Walkthrough](#walkthrough)
    - [Examples](#examples)
    - [Troubleshooting](#troubleshooting)
- [License](#license)

---

## Introduction

Hi! Welcome to my bash scripts repository, a collection of various scripts written in bash to automate tasks and improve workflow efficiency. From GitHub repository initialization to system maintenance, these scripts are designed to save time and reduce manual effort.

> **NOTE:** All scripts are sent through 3rd party testing via outside, trusted developers.

---

## Scripts

### git.sh - GitHub Repository Initializer

An interactive script that automates GitHub repository creation with dual-branch structure support.

#### Features

- 🔐 **Multi-Account Support** - Detects all logged-in GitHub accounts and lets you choose which to use
- 🌿 **Dual Branch Structure** - Automatically creates and pushes both `main` and `dev` branches
- 🎨 **Interactive Workflow** - Step-by-step prompts guide you through the process
- 🛡️ **Safety Checks** - Validates authentication, checks for existing repositories
- 📦 **Smart Git Initialization** - Initializes git, adds all files, and creates initial commit
- 🔍 **Repository Conflict Detection** - Checks if repository already exists on GitHub
- 🎯 **Flexible Visibility Options** - Choose between public and private repositories
- ✅ **Verification Steps** - Confirms account switching and successful repository creation
- 🎨 **Emoji Status Indicators** - Clear visual feedback for each step

#### Prerequisites

- **GitHub CLI** (`gh`) - [Installation Guide](https://cli.github.com/)
- **Git** - [Installation Guide](https://git-scm.com/)
- **Bash 5.0+** - Most systems have this by default
- **GitHub Account** - With authentication configured via `gh auth login`

#### Installation

**Option 1: Clone the Repository**
```bash
git clone https://github.com/account1/mek-bash-scripts.git
cd mek-bash-scripts
```

**Option 2: Direct Download**
```bash
curl -O https://raw.githubusercontent.com/account1/mek-bash-scripts/main/git.sh
chmod +x git.sh
```

**Option 3: Install to PATH (Optional)**
```bash
# Copy to a directory in your PATH
sudo cp git.sh /usr/local/bin/git-init
# Or add to ~/.local/bin
mkdir -p ~/.local/bin
cp git.sh ~/.local/bin/git-init
export PATH="$HOME/.local/bin:$PATH"  # Add to .bashrc for persistence
```

#### Usage

Simply run the script from any directory you want to turn into a GitHub repository:

```bash
./git.sh
```

The script will guide you through an interactive process with clear prompts at each step.

#### Walkthrough

Here's what happens when you run `git.sh`:

**1. GitHub Authentication Check**
- The script verifies you're logged in with `gh`
- Lists all authenticated GitHub accounts

**2. Account Selection**
- If multiple accounts are detected, you'll see a numbered list:
```
Logged in accounts:
 1. account1
 2. account2

Select account number (1-2): 
```
- The script switches to your selected account

**3. Account Verification**
- Confirms the account switch was successful

**4. Project Name Parsing**
- Automatically uses the current directory name as the repository name
- Example: If you're in `/home/user/projects/my-project`, the repository will be named `my-project`

**5. Repository Visibility Selection**
```
Repository visibility:
1. Public
2. Private
Select visibility (1-2): 
```

**6. Repository Creation**
The script then automatically:
- Initializes git with `main` as the default branch
- Adds all files in the current directory
- Creates an initial commit with message "initial upload"
- Checks if the repository already exists on GitHub
- Creates the repository on GitHub
- Pushes the `main` branch

**7. Dev Branch Creation**
- Creates a `dev` branch from `main`
- Pushes the `dev` branch to GitHub
- Switches back to `main` branch locally

**8. Completion**
- Displays the repository URL
- Shows current branch status
- Provides instructions for switching to dev branch

#### Examples

**Example 1: Creating a New Project Repository**
```bash
# Navigate to your project
cd ~/projects/awesome-app

# Run the script
~/mek-bash-scripts/git.sh

# Output:
# Checking GitHub authentication status...
# Logged in accounts:
#  1. account1
#  2. account2
# Select account number (1-2): 1
# ✅ Selected account: account1
# Verifying account... please wait...
# ✅ Account verifies successfully
# Parsing project name from current directory...
# 📁 Project name: awesome-app
# Repository visibility:
# 1. Public
# 2. Private
# Select visibility (1-2): 2
# 🚀 Creating GitHub repository...
# Account: account1
# Project: awesome-app
# Visibility: private
# 
# Initializing git repository...
# ✅ Git initialized with main branch
# 
# Adding files to git...
# ✅ Files staged
# 
# Making initial commit on main branch...
# [main (root-commit) 90bca80] initial upload
#  13 files changed, 268 insertions(+)
#  create mode 100644 .gitignore
#  create mode 100644 README.md
#  create mode 100644 app/__init__.py
#  create mode 100644 app/app.py
#  create mode 100644 app/static/assets/icon.png
#  create mode 100644 app/static/assets/robot.png
#  create mode 100644 app/static/js/components/header.js
#  create mode 100644 app/static/js/index.js
#  create mode 100644 app/static/styles/components/header.css
#  create mode 100644 app/static/styles/index.css
#  create mode 100644 app/templates/components/header.html
#  create mode 100644 app/templates/index.html
#  create mode 100644 pyproject.toml
# ✅ Initial commit created on main
# 
# 📤 Creating repository and pushing main branch...
# ✓ Created repository account1/awesome-app on github.com
#   https://github.com/account1/awesome-app
# ✓ Added remote https://github.com/account1/awesome-app.git
# Enumerating objects: 24, done.
# Counting objects: 100% (24/24), done.
# Delta compression using up to 16 threads
# Compressing objects: 100% (18/18), done.
# Writing objects: 100% (24/24), 2.67 MiB | 3.48 MiB/s, done.
# Total 24 (delta 0), reused 0 (delta 0), pack-reused 0
# To https://github.com/account1/awesome-app.git
#  * [new branch]      HEAD -> main
# branch 'main' set up to track 'origin/main'.
# ✓ Pushed commits to https://github.com/account1/awesome-app.git
# 
# ✅ Repository created and main branch pushed successfully!
# 🔗 https://github.com/account1/awesome-app
# 
# 🌿 Creating dev branch from main...
# Switched to a new branch 'dev'
# ✅ Dev branch created from main
# 
# 📤 Pushing dev branch...
# Total 0 (delta 0), reused 0 (delta 0), pack-reused 0
# remote: 
# remote: Create a pull request for 'dev' on GitHub by visiting:
# remote:      https://github.com/account1/awesome-app/pull/new/dev
# remote: 
# To https://github.com/account1/awesome-app.git
#  * [new branch]      dev -> dev
# branch 'dev' set up to track 'origin/dev'.
# ✅ Dev branch pushed successfully!
# 
# 🔄 Switching back to main branch...
# ✅ Switched back to main branch
# 
# ✅ Both main and dev branches pushed successfully!
# 📌 Current branch: main
# 🔀 Switch to dev with: git checkout dev
# 
# ✅ Repository setup complete!
```

**Example 2: Working with Multiple Accounts**
```bash
# When you have multiple GitHub accounts logged in
./git.sh

# Output:
# Checking GitHub authentication status...
# Logged in accounts:
#  1. account1
#  2. account2
# Select account number (1-2): 2
# ✅ Selected account: account2
# ... (rest of the process continues)
```

**Example 3: When Repository Already Exists**
```bash
./git.sh
# ... (previous steps)
# ⚠️  Repository account1/my-project already exists
# Do you want to continue anyway? (y/N): 
# 
# Type 'y' to continue (will attempt to push anyway)
# Type 'n' to exit
```

#### Troubleshooting

**Issue: "Error: Not logged into GitHub"**
```bash
# Solution: Authenticate with GitHub CLI
gh auth login
# Follow the interactive prompts
# Select: GitHub.com, HTTPS, Login with web browser, then choose your account
```

**Issue: "No accounts found"**
```bash
# Check your authentication status
gh auth status
# If no accounts shown, run:
gh auth login
```

**Issue: "Missing dependencies"**
```bash
# Install GitHub CLI
# Ubuntu/Debian
sudo apt install gh
# macOS
brew install gh
# Windows (via winget)
winget install --id GitHub.cli

# Install Git
# Ubuntu/Debian
sudo apt install git
# macOS
brew install git
```

**Issue: "Repository already exists"**
- The script will warn you and ask if you want to continue
- Choose 'y' to proceed (this will push to the existing repository)
- Choose 'n' to exit and rename your directory or repository

**Issue: "No changes to commit"**
- Ensure you have files in your directory
- The script will warn but continue if no changes found

**Issue: "Invalid selection" during account choice**
- Enter a valid number from the list
- Example: If you see accounts 1 and 2, enter `1` or `2`

**Issue: "Failed to create dev branch"**
- The script will show an error but the main branch will still be created
- You can manually create the dev branch later:
  ```bash
  git checkout -b dev
  git push -u origin dev
  ```

#### Notes

- The script uses the current directory name as the repository name
- All files in the current directory are added and committed
- The initial commit message is always "initial upload"
- Both `main` and `dev` branches are created and pushed
- After completion, you'll be on the `main` branch locally

---

## License

This project is licensed under the All Rights Reserved License - see the [LICENSE.txt](./LICENSE.txt) file for details.

© 2026 account1. All Rights Reserved.

---

<div align="center">

**Made with ❤️ and lots of ☕**

[Back to Top](#top)

</div>