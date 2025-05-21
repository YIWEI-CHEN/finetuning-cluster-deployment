#!/bin/bash

# CUDA installation configuration
CUDA_VERSION="12.4.0"
CUDA_BUILD="550.54.14"
RUN_FILE="cuda_${CUDA_VERSION}_${CUDA_BUILD}_linux.run"
CUDA_URL="https://developer.download.nvidia.com/compute/cuda/${CUDA_VERSION}/local_installers/${RUN_FILE}"

# Download CUDA installer if needed
download_cuda() {
    if [ ! -f "$RUN_FILE" ]; then
        echo "Downloading CUDA ${CUDA_VERSION} installer package..."
        wget "$CUDA_URL"
        if [ $? -ne 0 ]; then
            echo "Failed to download CUDA installer. Exiting."
            exit 1
        fi
        echo "Download completed successfully."
    else
        echo "CUDA installer package already exists, skipping download."
    fi
}

# Install CUDA toolkit
install_cuda() {
    echo "Installing CUDA ${CUDA_VERSION}..."
    sudo sh "$RUN_FILE" --silent --driver --toolkit --override
    if [ $? -ne 0 ]; then
        echo "CUDA installation failed. Please check the logs."
        exit 1
    fi
    echo "CUDA ${CUDA_VERSION} installation completed successfully."
}

# Execute the functions
download_cuda
install_cuda

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

# Configure CUDA environment variables
echo "Configuring CUDA environment variables..."
add_to_bashrc 'export PATH=/usr/local/cuda-12.4/bin:${PATH}'
add_to_bashrc 'export LD_LIBRARY_PATH=/usr/local/cuda-12.4/lib64:${LD_LIBRARY_PATH}'