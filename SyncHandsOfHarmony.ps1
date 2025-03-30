# Variables
$LocalRepoPath = "C:\Users\Dell\Downloads\HANDSOFHARMONY"
$RemoteRepoURL = "https://github.com/VirtualWareCloud/HandsOfHarmony.git"

# Check if local repository exists
if (!(Test-Path "$LocalRepoPath\.git")) {
    if (Test-Path $LocalRepoPath) {
        Write-Host "Local path exists but not a git repository. Deleting and recloning..."
        Remove-Item -Recurse -Force $LocalRepoPath
    }
    git clone $RemoteRepoURL $LocalRepoPath
}
else {
    Write-Host "Local repository found. Synchronizing changes..."
    Set-Location $LocalRepoPath

    # Pull latest changes
    git pull origin main

    # Add all changes
    git add .

    # Commit changes with timestamp
    $commitMessage = "Auto-sync $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
    git commit -m "$commitMessage"

    # Push changes to remote
    git push origin main
}

Write-Host "Synchronization complete."
