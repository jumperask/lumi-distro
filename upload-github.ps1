# Upload LumiDistro to GitHub
# This script will upload all files to your GitHub repository

Write-Host "=== Uploading LumiDistro to GitHub ===" -ForegroundColor Cyan
Write-Host ""

# Check if git is installed
try {
    $gitVersion = git --version
    Write-Host "Git found: $gitVersion" -ForegroundColor Green
} catch {
    Write-Host "Git not found. Please install Git:" -ForegroundColor Red
    Write-Host "https://git-scm.com/download/win" -ForegroundColor Yellow
    exit 1
}

# Navigate to project directory
$projectPath = "C:\Users\l4r\Documents\lumiweb\lumi-distro"
Set-Location $projectPath
Write-Host "Working directory: $projectPath" -ForegroundColor Cyan

# Initialize git repository
Write-Host "Initializing git repository..." -ForegroundColor Yellow
git init

# Add all files
Write-Host "Adding files..." -ForegroundColor Yellow
git add .

# Commit
Write-Host "Creating commit..." -ForegroundColor Yellow
git commit -m "Initial commit - LumiDistro v1.0"

# Add remote
Write-Host "Adding remote repository..." -ForegroundColor Yellow
git remote add origin https://github.com/jumperask/lumi-distro.git

# Rename branch to main
Write-Host "Renaming branch to main..." -ForegroundColor Yellow
git branch -M main

# Push to GitHub
Write-Host "Pushing to GitHub..." -ForegroundColor Yellow
Write-Host "You may need to authenticate with GitHub" -ForegroundColor Cyan
git push -u origin main

Write-Host ""
Write-Host "=== Upload completed ===" -ForegroundColor Green
Write-Host "Repository: https://github.com/jumperask/lumi-distro" -ForegroundColor Cyan
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Yellow
Write-Host "1. Go to https://github.com/jumperask/lumi-distro" -ForegroundColor White
Write-Host "2. Click on 'Actions' tab" -ForegroundColor White
Write-Host "3. Select 'Build LumiDistro ISO' workflow" -ForegroundColor White
Write-Host "4. Click 'Run workflow'" -ForegroundColor White
Write-Host "5. Wait for build to complete (~15-30 minutes)" -ForegroundColor White
Write-Host "6. Download the ISO artifact" -ForegroundColor White
