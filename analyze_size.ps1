$root = 'd:\code\wechatxcx\wechat-article-publisher\wechat-article-publisher'

# All files
$allFiles = Get-ChildItem -Recurse -File $root
$totalMB = [math]::Round(($allFiles | Measure-Object -Property Length -Sum).Sum / 1MB, 2)
Write-Host "=== Total: $totalMB MB, $($allFiles.Count) files ==="

# node_modules
$nm = $allFiles | Where-Object { $_.FullName -like '*node_modules*' }
$nmMB = [math]::Round(($nm | Measure-Object -Property Length -Sum).Sum / 1MB, 2)
Write-Host "node_modules: $nmMB MB, $($nm.Count) files"

# __pycache__
$pyc = $allFiles | Where-Object { $_.FullName -like '*__pycache__*' }
$pycMB = [math]::Round(($pyc | Measure-Object -Property Length -Sum).Sum / 1MB, 2)
Write-Host "__pycache__: $pycMB MB, $($pyc.Count) files"

# Image files
$imgs = $allFiles | Where-Object { $_.Extension -in @('.jpg','.png','.jpeg','.gif','.bmp','.webp') -and $_.FullName -notlike '*node_modules*' }
Write-Host "`n=== Image files (non-node_modules) ==="
foreach ($img in $imgs) {
    $sizeKB = [math]::Round($img.Length / 1KB, 1)
    Write-Host "  $sizeKB KB - $($img.Name)"
}
$imgMB = [math]::Round(($imgs | Measure-Object -Property Length -Sum).Sum / 1MB, 2)
Write-Host "Images total: $imgMB MB, $($imgs.Count) files"

# Core files (no node_modules, no pycache, no images)
$core = $allFiles | Where-Object { $_.FullName -notlike '*node_modules*' -and $_.FullName -notlike '*__pycache__*' -and $_.Extension -notin @('.jpg','.png','.jpeg','.gif','.bmp','.webp') }
$coreMB = [math]::Round(($core | Measure-Object -Property Length -Sum).Sum / 1MB, 2)
Write-Host "`n=== Core files (code+docs): $coreMB MB, $($core.Count) files ==="
