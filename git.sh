#!/bin/bash
set -e  # Exit on any error

currentDir="$PWD"

# Function to create GitHub repository
create_github_repo() {
    local account=$1
    local project=$2
    local visibility=$3  # public or private
    
    echo -e "\n🚀 Creating GitHub repository..."
    echo -e "Account: $account"
    echo -e "Project: $project"
    echo -e "Visibility: $visibility"
    
    # Initialize git if not already
    if ! git rev-parse --git-dir &>/dev/null; then
        echo -e "\nInitializing git repository..."
        git init -b main || { echo "❌ Git init failed"; return 1; }
        echo "✅ Git initialized with main branch"
    fi
    
    # Add all files
    echo -e "\nAdding files to git..."
    git add . || { echo "❌ git add failed"; return 1; }
    echo "✅ Files staged"
    
    # Commit changes on main
    echo -e "\nMaking initial commit on main branch..."
    git commit -m "initial upload" || { echo "❌ git commit failed"; return 1; }
    echo "✅ Initial commit created on main"
    
    # Check if repository exists on GitHub
    if gh repo view "$account/$project" &>/dev/null; then
        echo -e "\n⚠️  Repository $account/$project already exists"
        read -p "Do you want to continue anyway? (y/N): " continue_anyway
        if [[ ! "$continue_anyway" =~ ^[Yy]$ ]]; then
            echo "Exiting."
            exit 1
        fi
    fi
    
    # Create the repository and push main branch
    echo -e "\n📤 Creating repository and pushing main branch..."
    if gh repo create "$project" --"$visibility" --source=. --remote=origin --push; then
        echo -e "\n✅ Repository created and main branch pushed successfully!"
        echo -e "🔗 https://github.com/$account/$project"
        
        # Now create dev branch from main
        echo -e "\n🌿 Creating dev branch from main..."
        git checkout -b dev || { echo "❌ Failed to create dev branch"; return 1; }
        echo "✅ Dev branch created from main"
        
        # Push dev branch
        echo -e "\n📤 Pushing dev branch..."
        git push -u origin dev || {
            echo "⚠️  Failed to push dev branch"
            echo "You can manually push it with: git push -u origin dev"
        }
        echo "✅ Dev branch pushed successfully!"
        
        # Switch back to main branch
        echo -e "\n🔄 Switching back to main branch..."
        git checkout main &>/dev/null
        echo "✅ Switched back to main branch"
        
        echo -e "\n✅ Both main and dev branches pushed successfully!"
        echo -e "📌 Current branch: main"
        echo -e "🔀 Switch to dev with: git checkout dev"
        
        return 0
    else
        echo -e "\n❌ Failed to create repository"
        return 1
    fi
}

# Check gh authentication
echo "Checking GitHub authentication status..."
if ! gh auth status &>/dev/null; then
    echo "Error: Not logged into GitHub. Please run 'gh auth login' first."
    exit 1
fi

# Get accounts
accounts=$(gh auth status 2>&1 | grep -E "Logged in to github.com account" | sed 's/.*Logged in to github.com account //' | sed 's/ .*//' | sort -u)

# Display accounts
echo -e "\nLogged in accounts:"
echo "$accounts" | nl -w2 -s'. '

# Count accounts
account_count=$(echo "$accounts" | grep -v "^$" | wc -l)

if [ -z "$accounts" ] || [ "$account_count" -eq 0 ]; then
    echo "No accounts found. Please run 'gh auth login' to add accounts."
    exit 1
fi

if [ "$account_count" -gt 1 ]; then
    echo
    read -p "Select account number (1-$account_count): " selection
    
    if ! [[ "$selection" =~ ^[0-9]+$ ]] || [ "$selection" -lt 1 ] || [ "$selection" -gt "$account_count" ]; then
        echo "Invalid selection. Exiting."
        exit 1
    fi
    
    selected_account=$(echo "$accounts" | sed -n "${selection}p")
    echo -e "\n✅ Selected account: $selected_account"
    
    gh auth switch -u "$selected_account" || {
        echo "Error: Failed to switch to account $selected_account"
        exit 1
    }
else
    selected_account=$(echo "$accounts" | head -1)
    echo -e "\n✅ Using account: $selected_account"
fi

# Verify the switch worked
echo -e "\nVerifying account... please wait..."
if gh auth status --active &>/dev/null; then
    echo "✅ Account verifies successfully"
else
    echo "❌ Account verification failed"
    exit 1
fi

# Parse project name from current directory
echo -e "\nParsing project name from current directory..."
project_name=$(basename "$currentDir")
echo -e "📁 Project name: $project_name"

# Ask for repository visibility
echo -e "\nRepository visibility:"
echo "1. Public"
echo "2. Private"
read -p "Select visibility (1-2): " visibility_choice

case $visibility_choice in
    1)
        visibility="public"
        ;;
    2)
        visibility="private"
        ;;
    *)
        echo "Invalid selection. Defaulting to public."
        visibility="public"
        ;;
esac

# Create the repository
if create_github_repo "$selected_account" "$project_name" "$visibility"; then
    echo -e "\n✅ Repository setup complete!"
else
    echo -e "\n❌ Repository creation failed"
    exit 1
fi