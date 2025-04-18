# Install Chocolatey if it's not already installed
if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
    Write-Host "Installing Chocolatey..."
    Set-ExecutionPolicy Bypass -Scope Process -Force
    Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1')
}

# Install Git for Windows (Git Bash)
if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Host "Installing Git for Windows..."
    choco install git -y
}

# Install Node.js and npm
if (-not (Get-Command npm -ErrorAction SilentlyContinue)) {
    Write-Host "Installing Node.js and npm..."
    choco install nodejs-lts -y
}

# Install fast-cli and speedtest-cli via npm
Write-Host "Installing fast-cli and speedtest-cli..."
npm install -g fast-cli speedtest-cli

# Verify installations
Write-Host "Verifying installations..."
git --version
npm --version
fast-cli --version
speedtest-cli --version

# Create a folder for the scripts and download the repo if not already present
$repoPath = "C:\internet-speed-log-collection"
if (-not (Test-Path $repoPath)) {
    Write-Host "Cloning the internet-speed-log-collection repo..."
    git clone https://github.com/justbest23/internet-speed-log-collection.git $repoPath
} else {
    Write-Host "Repo already exists at $repoPath."
}

Write-Host "All installations complete. You can now run the scripts in the repository."
