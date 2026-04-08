# pack_skill.ps1
$skillDir = 'd:\code\wechatxcx\wechat-article-publisher\wechat-article-publisher'
$outputZip = 'd:\code\wechatxcx\wechat-article-publisher\wechat-ai-writer-skill.zip'
$tempDir = 'd:\code\wechatxcx\wechat-article-publisher\_pack_temp'

if (Test-Path $outputZip) { Remove-Item $outputZip -Force }
if (Test-Path $tempDir) { Remove-Item $tempDir -Recurse -Force }

$destRoot = Join-Path $tempDir 'wechat-ai-writer'
New-Item -ItemType Directory -Path $destRoot -Force | Out-Null

# Copy top-level files
$files = @(
    'SKILL.md', 'CONFIG.md', 'README.md', 'INSTALL.md', 'CHANGELOG.md',
    'CHICKEN_SOUP_STYLE.md', 'HUMANIZE_GUIDE.md', 'THEME_GUIDE.md',
    '.env.example', '.gitignore', 'footer.md'
)

foreach ($f in $files) {
    $src = Join-Path $skillDir $f
    if (Test-Path $src) {
        Copy-Item $src -Destination $destRoot -Force
        Write-Host "  + $f"
    }
}

# Copy scripts dir (exclude pycache, images, pyc)
$scriptsSrc = Join-Path $skillDir 'scripts'
$scriptsDest = Join-Path $destRoot 'scripts'
New-Item -ItemType Directory -Path $scriptsDest -Force | Out-Null

Get-ChildItem -File $scriptsSrc -Filter '*.py' | ForEach-Object {
    Copy-Item $_.FullName -Destination $scriptsDest -Force
    Write-Host "  + scripts/$($_.Name)"
}

# Copy references dir (exclude images)
$refSrc = Join-Path $skillDir 'references'
$refDest = Join-Path $destRoot 'references'
New-Item -ItemType Directory -Path $refDest -Force | Out-Null

Get-ChildItem -File $refSrc | Where-Object {
    $_.Extension -notin @('.jpg','.jpeg','.png','.gif','.bmp','.webp')
} | ForEach-Object {
    Copy-Item $_.FullName -Destination $refDest -Force
    Write-Host "  + references/$($_.Name)"
}

# Copy reader dir (only source files, no node_modules)
$readerSrc = Join-Path $skillDir 'reader'
$readerDest = Join-Path $destRoot 'reader'
New-Item -ItemType Directory -Path $readerDest -Force | Out-Null

@('extract_and_convert.js', 'package.json') | ForEach-Object {
    $p = Join-Path $readerSrc $_
    if (Test-Path $p) {
        Copy-Item $p -Destination $readerDest -Force
        Write-Host "  + reader/$_"
    }
}

# Compress
Write-Host ''
Write-Host 'Compressing...'
Compress-Archive -Path $destRoot -DestinationPath $outputZip -Force

$zipSize = (Get-Item $outputZip).Length
$zipKB = [math]::Round($zipSize / 1KB, 1)
$zipMB = [math]::Round($zipSize / 1MB, 2)

Write-Host ''
Write-Host '========================================'
Write-Host "Done! Output: $outputZip"
Write-Host "Size: $zipKB KB ($zipMB MB)"
if ($zipMB -le 5) {
    Write-Host 'OK: Under 5MB Telegram limit'
} else {
    Write-Host 'WARNING: Over 5MB limit!'
}
Write-Host '========================================'

# Cleanup temp
Remove-Item $tempDir -Recurse -Force
Write-Host 'Temp dir cleaned up.'
