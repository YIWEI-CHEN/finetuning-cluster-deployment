#!/bin/bash

# echo "Initializing Compute Instance at startup..."

# Remove existing CUDA and NVIDIA package
echo "Removing existing CUDA and NVIDIA package..."
sudo apt-get -y remove --purge "*cuda*" "*cublas*" "*cufft*" "*cufile*" "*curand*" "*cusolver*" "*cusparse*" "*npp*" "*nvjpeg*" "nsight*"
sudo apt-get -y remove --purge --allow-change-held-packages "nvidia*"
sudo apt-get -y autoremove

sudo reboot