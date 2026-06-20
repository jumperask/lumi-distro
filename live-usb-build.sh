#!/bin/bash
# Live USB Build Script for LumiDistro
# Run this from a Linux Live USB

echo "=== LumiDistro Live USB Build Script ==="
echo ""

# Check if running from live USB
if [ ! -d /cdrom ] && [ ! -d /lib/live ]; then
    echo "Warning: This script is designed to run from a Live USB"
    echo "But it should work from any Linux system"
    echo ""
fi

# Find Windows partition
echo "Searching for Windows partition..."
WINDOWS_PARTITION=$(lsblk -o NAME,FSTYPE,LABEL | grep -i ntfs | head -1 | awk '{print $1}')

if [ -z "$WINDOWS_PARTITION" ]; then
    echo "No NTFS partition found. Please manually mount your Windows partition."
    echo "Usage: sudo mount -t ntfs-3g /dev/sdX1 /mnt/windows"
    exit 1
fi

# Mount Windows partition
MOUNT_POINT="/mnt/windows"
sudo mkdir -p $MOUNT_POINT
sudo mount -t ntfs-3g /dev/$WINDOWS_PARTITION $MOUNT_POINT

# Navigate to project
PROJECT_PATH="$MOUNT_POINT/Users/l4r/Documents/lumiweb/lumi-distro"

if [ ! -d "$PROJECT_PATH" ]; then
    echo "Project not found at: $PROJECT_PATH"
    echo "Please check the path and adjust if needed."
    sudo umount $MOUNT_POINT
    exit 1
fi

cd "$PROJECT_PATH"
echo "Changed to project directory: $PROJECT_PATH"

# Install dependencies
echo "Installing build dependencies..."
sudo apt-get update
sudo apt-get install -y debootstrap xorriso grub-pc-bin grub-efi-amd64-bin mtools python3 python3-pip
pip3 install Pillow --user

# Make scripts executable
chmod +x *.sh *.py

# Generate wallpaper
echo "Generating wallpaper..."
python3 generate-wallpaper.py

# Build ISO
echo "Building ISO..."
sudo ./create-iso.sh

# Check if ISO was created
ISO_PATH="lumi-distro-1.0.iso"
if [ -f "$ISO_PATH" ]; then
    ISO_SIZE=$(du -h "$ISO_PATH" | cut -f1)
    echo "ISO created successfully!"
    echo "Location: $PROJECT_PATH/$ISO_PATH"
    echo "Size: $ISO_SIZE"
    echo "You can now reboot to Windows and use the ISO."
else
    echo "ISO creation failed. Check the logs above."
fi

# Unmount Windows partition
sudo umount $MOUNT_POINT

echo "=== Build completed ==="
