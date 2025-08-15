# setup.ps1 - Developer Environment Setup (Git already installed)

# Ensure script is running as Administrator
If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltinRole] "Administrator"))
{
    Write-Warning "Please run this script as Administrator!"
    Exit
}

Write-Host "Starting Developer Environment Setup..." -ForegroundColor Cyan

# -------------------------------
# 1. Install Node.js (LTS)
# -------------------------------
Write-Host "Installing Node.js LTS..." -ForegroundColor Yellow
$nodeInstaller = "$env:TEMP\node-lts.msi"
Invoke-WebRequest -Uri "https://nodejs.org/dist/v20.6.1/node-v20.6.1-x64.msi" -OutFile $nodeInstaller
Start-Process msiexec.exe -ArgumentList "/i `"$nodeInstaller`" /quiet /norestart" -Wait
Remove-Item $nodeInstaller

# -------------------------------
# 2. Install Python 3 (Latest)
# -------------------------------
Write-Host "Installing Python 3..." -ForegroundColor Yellow
$pythonInstaller = "$env:TEMP\python-installer.exe"
Invoke-WebRequest -Uri "https://www.python.org/ftp/python/3.12.2/python-3.12.2-amd64.exe" -OutFile $pythonInstaller
Start-Process $pythonInstaller -ArgumentList "/quiet InstallAllUsers=1 PrependPath=1" -Wait
Remove-Item $pythonInstaller

# -------------------------------
# 3. Install VS Code
# -------------------------------
Write-Host "Installing Visual Studio Code..." -ForegroundColor Yellow
$vsInstaller = "$env:TEMP\vscode-installer.exe"
Invoke-WebRequest -Uri "https://code.visualstudio.com/sha/download?build=stable&os=win32-x64-user" -OutFile $vsInstaller
Start-Process $vsInstaller -ArgumentList "/silent /mergetasks=!runcode" -Wait
Remove-Item $vsInstaller

# -------------------------------
# 4. Install Podman Desktop
# -------------------------------
Write-Host "Installing Podman Desktop..." -ForegroundColor Yellow
$podmanInstaller = "$env:TEMP\podman-desktop.msi"
Invoke-WebRequest -Uri "https://github.com/containers/podman-desktop/releases/download/v1.4.0/PodmanDesktop-Setup-1.4.0.msi" -OutFile $podmanInstaller
Start-Process msiexec.exe -ArgumentList "/i `"$podmanInstaller`" /quiet /norestart" -Wait
Remove-Item $podmanInstaller

# -------------------------------
# 5. Verify installations
# -------------------------------
Write-Host "`nVerifying installations..." -ForegroundColor Cyan
node -v
python --version
code --version
podman --version

Write-Host "`nDeveloper environment setup complete!" -ForegroundColor Green
