#!/bin/bash

# Get username from command line argument or use default
if [ -z "$1" ]; then
    echo "No username provided, using default 'yiweichen'"
    USERNAME="yiweichen"
else
    USERNAME="$1"
    echo "Using provided username: $USERNAME"
fi

# deactivate any existing conda environment
if [ -n "$CONDA_DEFAULT_ENV" ]; then
    echo "Deactivating existing conda environment: $CONDA_DEFAULT_ENV"
    conda deactivate
else
    echo "No conda environment to deactivate."
fi

OPENR1_FOLDER="/home/azureuser/cloudfiles/code/Users/${USERNAME}/open-r1"
# Check if the open-r1 folder exists
if [ ! -d "$OPENR1_FOLDER" ]; then
    echo "Open-R1 folder not found. Cloning from GitHub..."
    git clone https://github.com/huggingface/open-r1.git "$OPENR1_FOLDER"
    echo "Repository cloned successfully."
else
    echo "Open-R1 folder already exists."
fi

# Install dependencies
echo "Installing dependencies..."
cd "$OPENR1_FOLDER"
uv venv ${HOME}/openr1 --python 3.11 && . ${HOME}/openr1/bin/activate && uv pip install --upgrade pip
uv pip install vllm==0.8.4
uv pip install setuptools
uv pip install flash-attn --no-build-isolation
GIT_LFS_SKIP_SMUDGE=1 uv pip install -e ".[dev]"

# Define the path to the .bashrc file
BASHRC="$HOME/.bashrc"

# Define the line to remove
REMOVE_LINE="conda activate azureml_py38"

# Remove the line if it exists
if grep -Fxq "$REMOVE_LINE" "$BASHRC"; then
    sed -i "/^$REMOVE_LINE$/d" "$BASHRC"
    echo "Removed line: $REMOVE_LINE"
else
    echo "Line not found: $REMOVE_LINE"
fi

# Define the line to add
ADD_LINE='source /home/azureuser/openr1/bin/activate'
# Add the new line if it doesn't already exist
if ! grep -Fxq "$ADD_LINE" "$BASHRC"; then
    echo "$ADD_LINE" >> "$BASHRC"
    echo "Added line: $ADD_LINE"
else
    echo "Line already exists: $ADD_LINE"
fi