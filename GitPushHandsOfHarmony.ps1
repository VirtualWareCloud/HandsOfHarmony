# Variables
$LocalRepoPath = "C:\Users\Dell\Downloads\HANDSOFHARMONY"
$RemoteRepoURL = "https://github.com/VirtualWareCloud/HandsOfHarmony.git"

# Navigate to Local Path
Set-Location $LocalRepoPath

# Initialize Git if repository doesn't exist
if (!(Test-Path "$LocalRepoPath\.git")) {
    Write-Host "Initializing Git repository..."
    git init
    git remote add origin $RemoteRepoURL
    git branch -M main
}

# Check if remote origin is set correctly
$existingRemote = git remote get-url origin
if ($existingRemote -ne $RemoteRepoURL) {
    git remote set-url origin $RemoteRepoURL
}

# Stage, commit, and push changes
git add .
$commitMessage = "Auto-update: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
git commit -m "$commitMessage"

# Push changes (force set upstream if first push)
git push -u origin main

Write-Host "✅ Synchronization completed successfully."
