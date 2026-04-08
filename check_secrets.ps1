# check_secrets.ps1 - Check zip for leaked credentials
$zipPath = 'd:\code\wechatxcx\wechat-article-publisher\wechat-ai-writer-skill.zip'
$extractDir = 'd:\code\wechatxcx\wechat-article-publisher\_check_temp'

if (Test-Path $extractDir) { Remove-Item $extractDir -Recurse -Force }
Expand-Archive -Path $zipPath -DestinationPath $extractDir -Force

# List all files in zip
Write-Host "=== Files in zip ==="
Get-ChildItem -Recurse -File $extractDir | ForEach-Object {
    $rel = $_.FullName.Substring($extractDir.Length + 1)
    Write-Host "  $rel ($([math]::Round($_.Length/1KB,1)) KB)"
}

# Check if .env (real credentials) is included
Write-Host "`n=== Check: .env file (should NOT exist) ==="
$envFile = Get-ChildItem -Recurse -File $extractDir -Filter '.env' | Where-Object { $_.Name -eq '.env' }
if ($envFile) {
    Write-Host "  WARNING: .env file FOUND! Contents:" -ForegroundColor Red
    Get-Content $envFile.FullName
} else {
    Write-Host "  OK: .env file not in zip" -ForegroundColor Green
}

# Patterns to search for real credentials
$patterns = @(
    'wx[0-9a-f]{16}',           # WeChat AppID pattern
    '[0-9a-f]{32}',             # WeChat AppSecret / API key pattern (32 hex chars)
    'sk-[A-Za-z0-9]{20,}',     # API keys starting with sk-
    'tvly-[A-Za-z0-9]{20,}',   # Tavily API key pattern
    'AKID[A-Za-z0-9]{20,}'     # Cloud access key pattern
)

$patternNames = @(
    'WeChat AppID (wx+16hex)',
    'Hex key (32 chars)',
    'API key (sk-...)',
    'Tavily key (tvly-...)',
    'Cloud access key (AKID...)'
)

Write-Host "`n=== Scanning all files for credential patterns ==="

$allFiles = Get-ChildItem -Recurse -File $extractDir
$foundIssues = $false

for ($i = 0; $i -lt $patterns.Count; $i++) {
    $pattern = $patterns[$i]
    $name = $patternNames[$i]
    
    foreach ($file in $allFiles) {
        $content = Get-Content $file.FullName -Raw -ErrorAction SilentlyContinue
        if ($content -and ($content -match $pattern)) {
            $matches_found = [regex]::Matches($content, $pattern)
            foreach ($m in $matches_found) {
                $val = $m.Value
                # Skip placeholder values
                if ($val -like 'your_*' -or $val -eq 'wx0000000000000000') { continue }
                # Skip common non-secret hex strings (like color codes in CSS)
                if ($val.Length -eq 32 -and $file.Extension -in @('.md','.py','.js')) {
                    # Check context - is it near a key/secret/token keyword?
                    $idx = $content.IndexOf($val)
                    $start = [math]::Max(0, $idx - 50)
                    $context = $content.Substring($start, [math]::Min(100, $content.Length - $start))
                    if ($context -notmatch '(?i)(key|secret|token|password|appid|api)') { continue }
                }
                $rel = $file.FullName.Substring($extractDir.Length + 1)
                Write-Host "  WARNING in $rel [$name]: $val" -ForegroundColor Red
                $foundIssues = $true
            }
        }
    }
}

# Also search for common sensitive keywords with values
Write-Host "`n=== Scanning for hardcoded credential assignments ==="
$sensitivePatterns = @(
    'APP_ID\s*=\s*[^y\s]',
    'APP_SECRET\s*=\s*[^y\s]',
    'API_KEY\s*=\s*[^y\s]',
    'api_key\s*=\s*[''"][^y]',
    'app_secret\s*=\s*[''"][^y]',
    'app_id\s*=\s*[''"][^y]'
)

foreach ($file in $allFiles) {
    $lines = Get-Content $file.FullName -ErrorAction SilentlyContinue
    if (-not $lines) { continue }
    $lineNum = 0
    foreach ($line in $lines) {
        $lineNum++
        foreach ($sp in $sensitivePatterns) {
            if ($line -match $sp) {
                # Skip lines that are clearly examples/docs
                if ($line -match 'YOUR_|your_|example|placeholder|xxx|模板|说明|获取方式') { continue }
                # Skip comment lines
                if ($line.TrimStart().StartsWith('#') -or $line.TrimStart().StartsWith('//')) { continue }
                $rel = $file.FullName.Substring($extractDir.Length + 1)
                Write-Host "  REVIEW $rel :$lineNum : $($line.Trim())" -ForegroundColor Yellow
                $foundIssues = $true
            }
        }
    }
}

if (-not $foundIssues) {
    Write-Host "`n  ALL CLEAR: No real credentials detected" -ForegroundColor Green
}

Write-Host "`n=== Check complete ==="

# Cleanup
Remove-Item $extractDir -Recurse -Force
