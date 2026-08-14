param(
    [string]$Path = "ruoyi-admin/src/main/resources/db/migration/V1_2_0__wvp_baseline.sql"
)

$ErrorActionPreference = "Stop"
$allowedInsertTables = @(
    "sys_config",
    "sys_dept",
    "sys_dict_data",
    "sys_dict_type",
    "sys_menu",
    "sys_post",
    "sys_role",
    "sys_role_dept",
    "sys_role_menu",
    "sys_user",
    "sys_user_post",
    "sys_user_role"
)

$resolved = (Resolve-Path -LiteralPath $Path).Path
$lines = [System.IO.File]::ReadAllLines($resolved)
$sanitized = foreach ($line in $lines) {
    if ($line -match '^INSERT INTO `([^`]+)`') {
        $table = $Matches[1]
        if ($allowedInsertTables -notcontains $table) {
            continue
        }
        if ($table -eq "sys_user" -and $line -notmatch '^INSERT INTO `sys_user` VALUES \(1,') {
            continue
        }
        if (($table -eq "sys_user_post" -or $table -eq "sys_user_role") -and $line -notmatch 'VALUES \(1,') {
            continue
        }
    }

    $line = $line.Replace("'http://192.168.2.199:4000'", "'http://127.0.0.1:4000'")
    $line = $line.Replace("'9eed021bd609d5ea103de227a2b49896'", "''")
    $line = $line.Replace("'a134f56be1707124b5bc94753f0d74a4'", "''")
    $line
}

[System.IO.File]::WriteAllLines($resolved, $sanitized, [System.Text.UTF8Encoding]::new($false))
Write-Output "Sanitized WVP baseline: $resolved"
