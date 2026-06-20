# LumiDistro Windows Build Script
# Requires Administrator PowerShell

Write-Host "=== LumiDistro Windows Build Script ===" -ForegroundColor Cyan
Write-Host ""

# Check admin rights
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    Write-Host "X This script must be run as Administrator" -ForegroundColor Red
    Write-Host "Right-click PowerShell -> Run as Administrator" -ForegroundColor Yellow
    exit 1
}

# Function to check/install WSL
function Setup-WSL {
    Write-Host "Checking WSL..." -ForegroundColor Yellow
    
    $wslCheck = wsl --status 2>$null
    if ($LASTEXITCODE -ne 0) {
        Write-Host "WSL not installed. Installing..." -ForegroundColor Yellow
        wsl --install
        Write-Host "WSL installed. Please restart your computer." -ForegroundColor Green
        Write-Host "After restart, run this script again." -ForegroundColor Yellow
        exit 0
    } else {
        Write-Host "WSL is already installed" -ForegroundColor Green
    }
}

# Function to check/install Ubuntu
function Setup-Ubuntu {
    Write-Host "Checking Ubuntu in WSL..." -ForegroundColor Yellow
    
    $ubuntuCheck = wsl -l -v 2>$null | Select-String "Ubuntu"
    if (-not $ubuntuCheck) {
        Write-Host "Ubuntu not installed. Installing..." -ForegroundColor Yellow
        wsl --install -d Ubuntu
        Write-Host "Ubuntu installed. Please complete initial setup." -ForegroundColor Green
        Write-Host "Launch Ubuntu, create user, then run this script again." -ForegroundColor Yellow
        exit 0
    } else {
        Write-Host "Ubuntu is already installed" -ForegroundColor Green
    }
}

# Function to setup WSL environment
function Setup-Environment {
    Write-Host "Setting up WSL build environment..." -ForegroundColor Yellow
    
    $setupScript = @'
#!/bin/bash
echo "=== Setting up build environment ==="

# Update system
sudo apt update && sudo apt upgrade -y

# Install dependencies
sudo apt install -y debootstrap xorriso grub-pc-bin grub-efi-amd64-bin mtools python3 python3-pip

# Install Pillow for wallpaper
pip3 install Pillow --user

echo "Environment configured"
'@
    
    $setupScript | wsl bash -c "cat > /tmp/setup-env.sh"
    wsl bash -c "chmod +x /tmp/setup-env.sh && sudo /tmp/setup-env.sh"
}

# Function to build ISO
function Build-ISO {
    Write-Host "Building ISO..." -ForegroundColor Yellow
    
    $buildScript = @'
#!/bin/bash
cd /mnt/c/Users/l4r/Documents/lumiweb/lumi-distro

# Make scripts executable
chmod +x *.sh *.py

# Generate wallpaper
python3 generate-wallpaper.py

# Build ISO
sudo ./create-iso.sh

echo "Build completed"
'@
    
    $buildScript | wsl bash -c "cat > /tmp/build-iso.sh"
    wsl bash -c "chmod +x /tmp/build-iso.sh && /tmp/build-iso.sh"
}

# Function to check ISO
function Check-ISO {
    Write-Host "Checking ISO..." -ForegroundColor Yellow
    
    $isoPath = "C:\Users\l4r\Documents\lumiweb\lumi-distro-1.0.iso"
    
    if (Test-Path $isoPath) {
        $isoSize = (Get-Item $isoPath).Length / 1GB
        Write-Host "ISO created successfully!" -ForegroundColor Green
        Write-Host "Location: $isoPath" -ForegroundColor Cyan
        Write-Host "Size: $([math]::Round($isoSize, 2)) GB" -ForegroundColor Cyan
    } else {
        Write-Host "ISO not found. Check logs above." -ForegroundColor Red
    }
}

# Main menu
Write-Host "What do you want to do?" -ForegroundColor Cyan
Write-Host "1. Full installation (WSL + Ubuntu + Build)" -ForegroundColor White
Write-Host "2. Build ISO only (WSL already configured)" -ForegroundColor White
Write-Host "3. Exit" -ForegroundColor White
Write-Host ""

$choice = Read-Host "Your choice (1-3)"

switch ($choice) {
    "1" {
        Write-Host ""
        Write-Host "=== Full Installation ===" -ForegroundColor Cyan
        Setup-WSL
        Setup-Ubuntu
        Setup-Environment
        Build-ISO
        Check-ISO
    }
    "2" {
        Write-Host ""
        Write-Host "=== Building ISO ===" -ForegroundColor Cyan
        Setup-Environment
        Build-ISO
        Check-ISO
    }
    "3" {
        Write-Host "Goodbye!" -ForegroundColor Yellow
        exit 0
    }
    default {
        Write-Host "Invalid choice" -ForegroundColor Red
        exit 1
    }
}

Write-Host ""
Write-Host "=== Process completed ===" -ForegroundColor Green
Write-Host "See WINDOWS-GUIDE.md to flash ISO to USB" -ForegroundColor Cyan
