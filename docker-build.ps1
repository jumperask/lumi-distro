# Docker Build Script for LumiDistro
# Requires Docker Desktop installed

Write-Host "=== LumiDistro Docker Build Script ===" -ForegroundColor Cyan
Write-Host ""

# Check if Docker is installed
try {
    $dockerVersion = docker --version
    Write-Host "Docker found: $dockerVersion" -ForegroundColor Green
} catch {
    Write-Host "Docker not found. Please install Docker Desktop:" -ForegroundColor Red
    Write-Host "https://www.docker.com/products/docker-desktop/" -ForegroundColor Yellow
    exit 1
}

# Build Docker image
Write-Host "Building Docker image..." -ForegroundColor Yellow
docker build -t lumi-distro-builder .

# Run container to build ISO
Write-Host "Building ISO in container..." -ForegroundColor Yellow
docker run --rm -v ${PWD}:/build lumi-distro-builder

# Check if ISO was created
$isoPath = ".\lumi-distro-1.0.iso"
if (Test-Path $isoPath) {
    $isoSize = (Get-Item $isoPath).Length / 1GB
    Write-Host "ISO created successfully!" -ForegroundColor Green
    Write-Host "Location: $isoPath" -ForegroundColor Cyan
    Write-Host "Size: $([math]::Round($isoSize, 2)) GB" -ForegroundColor Cyan
} else {
    Write-Host "ISO not found. Check the logs above." -ForegroundColor Red
}

Write-Host ""
Write-Host "=== Build completed ===" -ForegroundColor Green
Write-Host "You can now remove Docker if desired:" -ForegroundColor Yellow
Write-Host "Docker Desktop -> Uninstall" -ForegroundColor Yellow
