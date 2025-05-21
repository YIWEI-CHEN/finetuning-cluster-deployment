#!/bin/bash

# Get username from command line argument or use default
if [ -z "$1" ]; then
    echo "No username provided, using default 'yiweichen'"
    USERNAME="yiweichen"
else
    USERNAME="$1"
    echo "Using provided username: $USERNAME"
fi

# Define the path to the .bashrc file
BASHRC="$HOME/.bashrc"

# Function to add line to bashrc if it doesn't already exist
add_to_bashrc() {
    local line="$1"
    if ! grep -Fxq "$line" "$BASHRC"; then
        echo "$line" >> "$BASHRC"
        echo "Added line: $line"
    else
        echo "Line already exists: $line"
    fi
}

# Add environment configurations
echo "Configuring environment in .bashrc..."
add_to_bashrc "export HF_HOME=/home/azureuser/cloudfiles/code/Users/${USERNAME}/hf_cache"
