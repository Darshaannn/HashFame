$ErrorActionPreference = 'Stop'
$repositoryRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$passed = 0

function Assert-Foundation([bool] $Condition, [string] $Label) {
    if (-not $Condition) {
        throw "FAIL: $Label"
    }
    $script:passed++
    Write-Output "PASS: $Label"
}

$migrationDirectory = Join-Path $repositoryRoot 'supabase/migrations'
$migrations = @(Get-ChildItem -LiteralPath $migrationDirectory -File -Filter '*.sql' | Sort-Object Name)
$expectedMigrations = 1..8 | ForEach-Object { '{0:D4}' -f $_ }
$actualMigrations = @($migrations | ForEach-Object { $_.BaseName.Substring(0, 4) })
Assert-Foundation ($migrations.Count -eq 8) 'exactly eight Phase-1 migrations exist'
Assert-Foundation (($actualMigrations -join ',') -eq ($expectedMigrations -join ',')) 'migrations are ordered 0001 through 0008'

$presentationFiles = @(Get-ChildItem -LiteralPath (Join-Path $repositoryRoot 'apps/mobile/lib/features') -Recurse -File -Filter '*.dart' |
    Where-Object { $_.FullName -match '[\\/]presentation[\\/]' })
$presentationSource = ($presentationFiles | ForEach-Object { Get-Content -LiteralPath $_.FullName -Raw }) -join "`n"
Assert-Foundation ($presentationSource -notmatch 'supabase_flutter|SupabaseClient|\.from\(|\.rpc\(') 'presentation has no direct Supabase access'

$authContract = Get-Content -LiteralPath (Join-Path $repositoryRoot 'apps/mobile/lib/features/auth/domain/auth_repository.dart') -Raw
$authScreen = Get-Content -LiteralPath (Join-Path $repositoryRoot 'apps/mobile/lib/features/auth/presentation/auth_screens.dart') -Raw
$routerSource = Get-Content -LiteralPath (Join-Path $repositoryRoot 'apps/mobile/lib/app/router.dart') -Raw
Assert-Foundation ($authContract -match 'sendPhoneOtp' -and $authContract -match 'verifyPhoneOtp') 'authentication contract supports phone OTP'
Assert-Foundation ($authScreen -notmatch 'sendPhoneOtp|verifyPhone|Phone number') 'phone OTP is not a Phase-1 launch dependency'
Assert-Foundation ($routerSource -match "path: '/startup'" -and $routerSource -match "path: '/profile'") 'startup and profile routes are present'

$tokensSource = Get-Content -LiteralPath (Join-Path $repositoryRoot 'apps/mobile/lib/core/design_system/tokens.dart') -Raw
Assert-Foundation ($tokensSource -match 'class AppMotion') 'design system includes motion tokens'
Assert-Foundation (
    (Test-Path -LiteralPath (Join-Path $repositoryRoot 'apps/admin/README.md')) -and
    (Test-Path -LiteralPath (Join-Path $repositoryRoot 'apps/web/README.md'))
) 'future app boundaries contain README files only'

$environmentExample = @(Get-Content -LiteralPath (Join-Path $repositoryRoot '.env.example'))
$assignedEnvironmentValues = @($environmentExample | Where-Object {
    $_ -match '^[A-Z][A-Z0-9_]+=(.+)$' -and $Matches[1].Length -gt 0
})
Assert-Foundation ($assignedEnvironmentValues.Count -eq 0) '.env.example contains names only'

$clientFiles = @(
    Get-ChildItem -LiteralPath (Join-Path $repositoryRoot 'apps/mobile/lib') -Recurse -File -Filter '*.dart'
    Get-ChildItem -LiteralPath (Join-Path $repositoryRoot 'config') -Recurse -File
)
$clientSource = ($clientFiles | ForEach-Object { Get-Content -LiteralPath $_.FullName -Raw }) -join "`n"
Assert-Foundation ($clientSource -notmatch 'sb_secret_|SUPABASE_SERVICE_ROLE|"role"\s*:\s*"service_role"') 'client source contains no privileged Supabase credential'

$sql = ($migrations | ForEach-Object { Get-Content -LiteralPath $_.FullName -Raw }) -join "`n"
$tables = [regex]::Matches($sql, 'create table public\.([a-z_]+)', 'IgnoreCase') |
    ForEach-Object { $_.Groups[1].Value.ToLowerInvariant() } | Sort-Object -Unique
$rlsTables = [regex]::Matches($sql, 'alter table public\.([a-z_]+) enable row level security', 'IgnoreCase') |
    ForEach-Object { $_.Groups[1].Value.ToLowerInvariant() } | Sort-Object -Unique
Assert-Foundation (($tables -join ',') -eq ($rlsTables -join ',')) 'every public table explicitly enables RLS'
Assert-Foundation ($sql -match "chosen_role = 'admin'") 'onboarding RPC rejects self-assigned admin'

foreach ($environment in @('local', 'staging', 'production')) {
    $configPath = Join-Path $repositoryRoot "config/$environment.example.json"
    $config = Get-Content -LiteralPath $configPath -Raw | ConvertFrom-Json
    Assert-Foundation ($config.APP_ENV -eq $environment) "$environment Dart configuration is environment-matched"
    Assert-Foundation ($config.AUTH_REDIRECT_URL -eq "com.ggs.mobile.$environment`://auth/callback") "$environment callback is environment-matched"
}

Write-Output "Static foundation checks passed: $passed"
